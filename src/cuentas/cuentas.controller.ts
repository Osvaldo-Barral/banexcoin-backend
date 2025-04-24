import { Controller, Get, Param, ParseIntPipe } from '@nestjs/common';
import { CuentasService } from './cuentas.service';
import { SaldoDto } from './saldo.dto';
import { ContactoDto } from './contacto.dto';
import { CuentaDto } from './cuenta.dto';

@Controller('cuentas')
export class CuentasController {
  constructor(private readonly cuentasService: CuentasService) { }

  /**
  * Devuelve el listado completo de cuentas con sus saldos y relaciones
  */
  @Get('listar_cuentas')
  async listarCuentas(): Promise<CuentaDto[]> {
    return this.cuentasService.getCuentas();
  }

  /**
  * Devuelve el listado de contactos (otras cuentas) y el saldo de la cuenta actual (usuario simulado)
  */
  @Get('listar_contactos_saldo')
  async listarContactos(): Promise<{ contactos: ContactoDto[]; saldo: SaldoDto }> {
    return this.cuentasService.getContactosSaldo();
  }

  // Métodos individuales comentados por eficiencia, pero listos para habilitarse si es necesario

  // @Get('listar_contactos')
  // async listarContactos(): Promise<ContactoDto[]> {
  //   return this.cuentasService.getContactos();
  // }

  // @Get('saldo')
  // async getSaldo(
  //   // @Param('id_usuario', ParseIntPipe) id_usuario: number,
  // ): Promise<SaldoDto> {
  //   return this.cuentasService.getSaldo();
  // }

}
