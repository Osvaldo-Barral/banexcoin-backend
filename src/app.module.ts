import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import { AppDataSource } from './database/datasource';
import { UsuariosModule } from './usuarios/usuarios.module';
import { CuentasModule } from './cuentas/cuentas.module';
import { TransaccionesModule } from './transacciones/transacciones.module';
import { ComisionesModule } from './comisiones/comisiones.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }), // Habilita variables de entorno globales
    TypeOrmModule.forRootAsync({
      useFactory: () => (AppDataSource.options), // Reutiliza la configuración
    }), UsuariosModule, CuentasModule, TransaccionesModule, ComisionesModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule { }
