import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Not, Repository } from 'typeorm';
import { ContactoDto } from '../cuentas/contacto.dto';
import { Cuenta } from 'src/cuentas/cuenta.entity';

@Injectable()
export class UsuariosService {

    constructor(
        @InjectRepository(Cuenta)
        private contactoRepository: Repository<Cuenta>
    ) { }
}
