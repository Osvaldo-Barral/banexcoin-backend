import { Body, Controller, Get, Param, ParseIntPipe, Post } from '@nestjs/common';
import { TransaccionesService } from './transacciones.service';
import { CreateTransaccionDto, TransaccionDto } from './transaccion.dto';

@Controller('transacciones')
export class TransaccionesController {
  constructor(private readonly transaccionesService: TransaccionesService) { }


  /**
   * Realiza una transferencia entre cuentas
   * @param createTransaccionDto DTO con los datos de la transacción
   * @returns Detalles de la transacción realizada
   */
  @Post('transferir')
  async transferir(
    @Body() createTransaccionDto: CreateTransaccionDto,
  ): Promise<TransaccionDto> {
    return this.transaccionesService.postTransferencias(createTransaccionDto);
  }

  /**
   * Obtiene el historial de transacciones realizadas por una cuenta
   * @param cuentaId ID de la cuenta
   */
  @Get('realizadas/:cuentaId')
  async getHistorialRealizadas(
    @Param('cuentaId', ParseIntPipe) cuentaId: number,
  ) {
    return this.transaccionesService.getHistorialTransaccionesRealizadas(cuentaId);
  }

  /**
   * Obtiene el historial de transacciones recibidas por una cuenta
   * @param cuentaId ID de la cuenta
   */
  @Get('recibidas/:cuentaId')
  async getHistorialRecibidas(
    @Param('cuentaId', ParseIntPipe) cuentaId: number,
  ) {
    return this.transaccionesService.getHistorialTransaccionesRecibidas(cuentaId);
  }

}
