import { CuentaDto } from "src/cuentas/cuenta.dto";
import { TransaccionDto } from "src/transacciones/transaccion.dto";

export class ComisionDto {
    id: number;
    monto: number;
    fecha: Date;
    Transaccion: TransaccionDto;
    cuentaBeneficiaria: CuentaDto;
}