import {
    Entity,
    PrimaryGeneratedColumn,
    Column,
    ManyToOne,
    JoinColumn,
    CreateDateColumn,
} from 'typeorm';

import { Cuenta } from 'src/cuentas/cuenta.entity';
import { Transaccion } from 'src/transacciones/transaccion.entity';

@Entity('comisiones')
export class Comision {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ type: 'numeric' })
    monto: number;

    @CreateDateColumn({ name: 'fecha' })
    fecha: Date;

    @ManyToOne(() => Transaccion, (transaccion) => transaccion.comision)
    @JoinColumn({ name: 'id_transaccion' })
    transaccion: Transaccion;

    @ManyToOne(() => Cuenta, (cuenta) => cuenta.comisionesRecibidas)
    @JoinColumn({ name: 'cuenta_beneficiaria' })
    cuentaBeneficiaria: Cuenta;
}