import { Module } from '@nestjs/common';
import { TransaccionesService } from './transacciones.service';
import { TransaccionesController } from './transacciones.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Transaccion } from './transaccion.entity';
import { CuentasModule } from 'src/cuentas/cuentas.module';
import { ComisionesModule } from 'src/comisiones/comisiones.module';

@Module({
  imports: [TypeOrmModule.forFeature([Transaccion]), CuentasModule, ComisionesModule],
  controllers: [TransaccionesController],
  providers: [TransaccionesService],
  exports: [TypeOrmModule]
})
export class TransaccionesModule { }
