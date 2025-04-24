
import { Entity, PrimaryGeneratedColumn, Column, ManyToOne, OneToMany, JoinColumn, OneToOne } from 'typeorm';
import { Usuario } from 'src/usuarios/usuario.entity';
import { Transaccion } from 'src/transacciones/transaccion.entity';
import { Comision } from 'src/comisiones/comision.entity';

@Entity('cuentas')
export class Cuenta {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ type: 'numeric', default: 0 })
    saldo: number;

    @ManyToOne(() => Usuario)
    @JoinColumn({ name: 'id_usuario' })
    usuario: Usuario;

    @ManyToOne(() => Cuenta, cuenta => cuenta.referido, { nullable: true },)
    @JoinColumn({ name: 'id_referido' })
    referido: Cuenta;

    @OneToMany(() => Cuenta, cuenta => cuenta.referido, { nullable: true })
    referidoDe: Cuenta;

    @OneToMany(() => Transaccion, transaccion => transaccion.cuentaOrigen)
    transaccionesRealizadas: Transaccion[];

    @OneToMany(() => Transaccion, transaccion => transaccion.cuentaDestino)
    transaccionesRecibidas: Transaccion[];

    @OneToMany(() => Comision, comision => comision.cuentaBeneficiaria)
    comisionesRecibidas: Comision[];
}