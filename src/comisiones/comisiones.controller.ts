import { Controller, Get, Param } from '@nestjs/common';
import { ComisionesService } from './comisiones.service';

@Controller('comisiones')
export class ComisionesController {
  constructor(private readonly comisionesService: ComisionesService) { }

  /**
  * Obtiene el historial de comisiones recibidas por una cuenta
  * @param cuentaId ID de la cuenta beneficiaria
  */
  @Get('historial/:cuentaId')
  async getHistorialRealizadas(
    @Param('cuentaId') cuentaId: number,
  ) {
    return this.comisionesService.getHistorialComisiones(cuentaId);
  }

}
