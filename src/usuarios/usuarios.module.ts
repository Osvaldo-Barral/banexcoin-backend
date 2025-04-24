import { Module } from '@nestjs/common';
import { UsuariosService } from './usuarios.service';
import { UsuariosController } from './usuarios.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Usuario } from './usuario.entity';
import { CuentasModule } from 'src/cuentas/cuentas.module';

@Module({
  imports: [TypeOrmModule.forFeature([Usuario]), CuentasModule],
  controllers: [UsuariosController],
  providers: [UsuariosService]
})
export class UsuariosModule { }
