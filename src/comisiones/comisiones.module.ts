import { Module } from '@nestjs/common';
import { ComisionesService } from './comisiones.service';
import { ComisionesController } from './comisiones.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Comision } from './comision.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Comision])],
  controllers: [ComisionesController],
  providers: [ComisionesService],
  exports: [TypeOrmModule]
})
export class ComisionesModule { }
