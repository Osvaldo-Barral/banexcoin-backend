import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, Not } from 'typeorm';
import { Cuenta } from './cuenta.entity';
import { CuentaDto } from './cuenta.dto';
import { SaldoDto } from './saldo.dto';
import { ContactoDto } from './contacto.dto';

import { ConfigService } from '@nestjs/config';
import { config } from 'dotenv';
config();
const configService = new ConfigService();

@Injectable()
export class CuentasService {

    // Usuario simulado como logueado. En un sistema real, esto debería ser dinámico (por token, sesión, etc.)
    // Por ahora se definira el usuario en las variables de entorno
    private readonly userId = configService.get('ID_USUARIO');

    constructor(
        @InjectRepository(Cuenta)
        private cuentaRepository: Repository<Cuenta>
    ) { }

    /**
    * Obtiene todas las cuentas con su información relacionada.
    */
    async getCuentas(): Promise<CuentaDto[]> {
        const cuentas = await this.cuentaRepository.find({
            relations: ['usuario'],
        });

        return cuentas.map(cuenta => ({
            id: cuenta.id,
            saldo: cuenta.saldo,
            usuario: cuenta.usuario,
            cuentaReferida: cuenta.referidoDe,
        }));
    }

    async getContactosSaldo(): Promise<{ contactos: ContactoDto[]; saldo: SaldoDto }> {
        const [contactos, cuentaUsuario] = await Promise.all([
            this.cuentaRepository.find({
                where: { id: Not(this.userId) },
                relations: ['usuario'],
                order: {
                    id: "ASC"
                }
            }),
            this.cuentaRepository.findOne({
                where: { usuario: { id: this.userId } },
                relations: ['usuario'],
            }),
        ]);

        if (!cuentaUsuario) {
            throw new NotFoundException('Cuenta no encontrada');
        }

        return {
            contactos: contactos.map(contacto => ({
                nombre: contacto.usuario.nombre,
                cuenta: contacto.id,
            })),
            saldo: {
                id: this.userId,
                cuenta: cuentaUsuario.id,
                saldo: Number(cuentaUsuario.saldo),
            },
        };
    }

    /**
    * Se que se pueden trabajarlos por separado pero preferi hacerlo juntos
    */
    // async getContactos(): Promise<ContactoDto[]> {
    //     const contactos = await this.contactoRepository.find({
    //         where: { id: Not(this.userId) },
    //         relations: ['usuario']
    //     });

    //     return contactos.map(contacto => ({
    //         nombre: contacto.usuario.nombre,
    //         cuenta: contacto.id
    //     }))
    // }

    // async getSaldo(): Promise<SaldoDto> {
    //     const cuenta = await this.contactoRepository.findOne({
    //         where: { usuario: { id: this.userId } },
    //         relations: ['usuario'],
    //     });

    //     if (!cuenta) {
    //         throw new NotFoundException('Cuenta no encontrada');
    //     }

    //     return {
    //         saldo: Number(cuenta.saldo),
    //     };
    // }



}
