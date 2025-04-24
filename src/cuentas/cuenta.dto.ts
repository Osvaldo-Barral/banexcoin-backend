import { UsuarioDto } from "src/usuarios/usuario.dto";


export class CuentaDto {
    id: number;
    saldo: number;
    usuario: UsuarioDto | number;
    cuentaReferida?: CuentaDto | number
}