import {
    Entity,
    PrimaryGeneratedColumn,
    Column,
    ManyToOne,
    JoinColumn,
    OneToOne,
} from 'typeorm'; // Asegúrate de que la ruta sea correcta
// import { Comision } from './comision.entity'; // Importa la entidad Comision si existe
import { Cuenta } from 'src/cuentas/cuenta.entity';
import { Comision } from 'src/comisiones/comision.entity';

@Entity('transacciones') // Nombre exacto de tu tabla en PostgreSQL
export class Transaccion {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ type: 'numeric' })
    monto: number;

    @Column({ type: 'numeric' })
    comision: number; // Comisión de la transacción (no confundir con la entidad Comision)

    @Column({ type: 'timestamp', default: () => 'NOW()' })
    fecha: Date;

    // Relación: Muchas transacciones pueden tener una cuenta_origen
    @ManyToOne(() => Cuenta, (cuenta) => cuenta.transaccionesRealizadas)
    @JoinColumn({ name: 'cuenta_origen' }) // Nombre de la columna FK en la tabla
    cuentaOrigen: Cuenta;

    // Relación: Muchas transacciones pueden tener una cuenta_destino
    @ManyToOne(() => Cuenta, (cuenta) => cuenta.transaccionesRecibidas)
    @JoinColumn({ name: 'cuenta_destino' })
    cuentaDestino: Cuenta;

    // Relación: Una transacción puede tener 0 o 1 comisión (entidad separada)
    @OneToOne(() => Comision, (comision) => comision.transaccion)
    comisionRelacionada: Comision; // Opcional, solo si necesitas acceder a la entidad Comision desde aquí
}