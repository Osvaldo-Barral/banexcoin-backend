import { CuentaDto } from "src/cuentas/cuenta.dto";

export class TransaccionDto {
    id: number;
    monto: number;
    comision: number;
    cuentaOrigen: CuentaDto | number;
    cuentaDestino: CuentaDto | number;
    fecha: Date;
}

export class CreateTransaccionDto {
    cuentaOrigenId: number;
    cuentaDestinoId: number;
    monto: number;
}
