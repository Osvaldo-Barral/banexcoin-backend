import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Comision } from './comision.entity';
import { ComisionDto } from './comision.dto';

@Injectable()
export class ComisionesService {

    constructor(
        @InjectRepository(Comision)
        private comisionRepository: Repository<Comision>
    ) { }

    /**
  * Devuelve el historial de comisiones recibidas por una cuenta específica.
  * 
  * @param cuentaId - ID de la cuenta beneficiaria.
  */
    async getHistorialComisiones(cuentaId: number): Promise<ComisionDto[]> {
        const comisiones = await this.comisionRepository.find({
            where: { cuentaBeneficiaria: { id: cuentaId } },
            relations: [
                'transaccion',
                'transaccion.cuentaOrigen',
                'transaccion.cuentaDestino',
                'cuentaBeneficiaria',
            ],
        });

        return comisiones.map(comision => ({
            id: comision.id,
            monto: comision.monto,
            fecha: comision.fecha,
            Transaccion: comision.transaccion,
            cuentaBeneficiaria: comision.cuentaBeneficiaria,
        }));
    }

}
