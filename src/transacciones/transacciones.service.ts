import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import Decimal from 'decimal.js';
import { CreateTransaccionDto, TransaccionDto } from './transaccion.dto';
import { Transaccion } from './transaccion.entity';
import { Cuenta } from 'src/cuentas/cuenta.entity';
import { Comision } from 'src/comisiones/comision.entity';

@Injectable()
export class TransaccionesService {
    private readonly PORCENTAJE_COMISION = 0.01;
    private readonly PORCENTAJE_REFERIDO = 0.5;


    constructor(
        @InjectRepository(Transaccion)
        private transaccionRepository: Repository<Transaccion>,

        @InjectRepository(Cuenta)
        private readonly cuentaRepository: Repository<Cuenta>,

        @InjectRepository(Comision)
        private comisionRepository: Repository<Comision>,
    ) { }

    /**
    * Realiza una transferencia entre cuentas con comisión y bonificación a referido.
    * Usa transacción y bloqueo pesimista para garantizar consistencia y evitar condiciones de carrera.
    */
    async postTransferencias(createTransaccionDto: CreateTransaccionDto) {
        return await this.transaccionRepository.manager.transaction(async manager => {

            const { cuentaOrigenId, cuentaDestinoId, monto } = createTransaccionDto;

            const cuentaOrigen: Cuenta = await manager.findOne(Cuenta, {
                where: { id: cuentaOrigenId },
                lock: { mode: 'pessimistic_write' },
            });

            if (!cuentaOrigen) throw new Error('Cuenta origen no encontrada');

            const cuentaDestino = await manager.findOne(Cuenta, {
                where: { id: cuentaDestinoId },
                lock: { mode: 'pessimistic_write' },
            });

            if (!cuentaDestino) throw new Error('Cuenta destino no encontrada');

            if (Number(cuentaOrigen.saldo) < monto) throw new Error('Saldo insuficiente');

            const cuentaReferido = await this.cuentaRepository.findOne({
                where: { id: cuentaOrigen.id },
                relations: ['referido'],
            });

            // Calcular montos
            const decimalMonto = new Decimal(monto);
            const comision = decimalMonto.mul(this.PORCENTAJE_COMISION);
            const comisionReferido = comision.mul(this.PORCENTAJE_REFERIDO);
            const totalADescontar = decimalMonto.plus(comision);

            // Actualizar saldos
            cuentaOrigen.saldo = this.truncarDecimal(new Decimal(cuentaOrigen.saldo).minus(totalADescontar));
            cuentaDestino.saldo = this.truncarDecimal(new Decimal(cuentaDestino.saldo).plus(decimalMonto));

            await manager.save([cuentaOrigen, cuentaDestino]);

            // Crear transacción
            const transaccion = this.transaccionRepository.create({
                monto: this.truncarDecimal(decimalMonto),
                comision: this.truncarDecimal(comision),
                cuentaOrigen,
                cuentaDestino,
            });

            const transaccionGuardada = await manager.save(transaccion);

            // Registrar comisión al referido (si existe)
            if (cuentaReferido.referido) {

                cuentaReferido.referido.saldo = this.truncarDecimal(
                    new Decimal(cuentaReferido.referido.saldo).plus(comisionReferido)
                );

                await manager.save(cuentaReferido.referido);

                const comisionEntity = this.comisionRepository.create({
                    monto: this.truncarDecimal(comisionReferido),
                    transaccion: transaccionGuardada,
                    cuentaBeneficiaria: cuentaReferido.referido,
                    fecha: new Date(),
                });
                await manager.save(comisionEntity);
            }

            return transaccionGuardada;
        });

    }

    /**
     * Trunca un número decimal sin redondeo.
     */
    private truncarDecimal(num: Decimal): number {
        const str = num.toString();
        if (str.includes('.')) {
            const decimales = str.split('.')[1].length;
            return Number(num.toDecimalPlaces(decimales, Decimal.ROUND_DOWN).toString());
        }
        return Number(num.toString());
    }


    /**
     * Historial de transacciones salientes desde una cuenta.
     */
    async getHistorialTransaccionesRealizadas(cuentaId: number): Promise<TransaccionDto[]> {
        const transacciones = await this.transaccionRepository.find({
            where: { cuentaOrigen: { id: cuentaId } },
            relations: ['cuentaOrigen', 'cuentaDestino'],
        });

        return this.mapTransaccionesToDto(transacciones);
    }

    /**
     * Historial de transacciones entrantes a una cuenta.
     */
    async getHistorialTransaccionesRecibidas(cuentaId: number): Promise<TransaccionDto[]> {
        const transacciones = await this.transaccionRepository.find({
            where: { cuentaDestino: { id: cuentaId } },
            relations: ['cuentaOrigen', 'cuentaDestino'],
        });

        return this.mapTransaccionesToDto(transacciones);
    }

    /**
     * Mapea entidades de transacción a DTOs.
     */
    private mapTransaccionesToDto(transacciones: Transaccion[]): TransaccionDto[] {
        return transacciones.map(tx => ({
            id: tx.id,
            monto: tx.monto,
            comision: tx.comision,
            cuentaOrigen: tx.cuentaOrigen,
            cuentaDestino: tx.cuentaDestino,
            fecha: tx.fecha,
        }));
    }

}