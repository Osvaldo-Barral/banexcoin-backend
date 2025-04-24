# 💰 BbanexCoin API

API REST desarrollada con **NestJS**, **TypeORM** y **PostgreSQL** para la gestión de cuentas, transacciones y comisiones dentro de un sistema de billetera digital.

## 📦 Requisitos

- Node.js >= 18.x
- NPM >= 9.x 
- PostgreSQL >= 16
- NestJS CLI (`npm install -g @nestjs/cli`)

## ⚙️ Instalación

1. Clonar el repositorio:

   ```bash
   git clone https://github.com/Osvaldo-Barral/criptos.git

Instalar dependencias:

Una vez clonado el repositorio, entra en la carpeta backend y ejecuta los siguientes comandos para instalar las dependencias necesarias:

cd backend
npm install

Esto instalará todos los módulos de Node.js necesarios para el funcionamiento de la API.

Levantar el Proyecto Localmente
Para correr la API de forma local, asegúrate de tener PostgreSQL corriendo en tu máquina. Luego, usa el siguiente comando en la terminal dentro de la carpeta backend:

npm run start:dev
Este comando levantará el servidor en modo de desarrollo y la API estará disponible en http://localhost:3000.

🛠️ Base de Datos
En la carpeta src/database/ encontrarás dos archivos relacionados con la base de datos:

banexcoin_backup.sql: Un archivo de respaldo de la base de datos en formato .sql que puedes importar directamente a PostgreSQL para restaurar la base de datos con datos previos.

banexcoin.sql: Este archivo contiene el script de creación y llenado de la base de datos.

Comandos Útiles
Iniciar el servidor en desarrollo:
npm run start:dev

Generar un módulo (reemplaza module-name con el nombre de tu módulo):
nest generate module module-name

Generar un servicio:
nest generate service module-name

Generar un controlador:
nest generate controller module-name