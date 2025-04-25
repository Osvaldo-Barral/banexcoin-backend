# 💰 banexCoin API

API REST desarrollada con **NestJS**, **TypeORM** y **PostgreSQL** para la gestión de cuentas, transacciones y comisiones dentro de un sistema de billetera digital.

## 📦 Requisitos

- Node.js >= 18.x
- NPM >= 9.x 
- PostgreSQL >= 16
- NestJS CLI (`npm install -g @nestjs/cli`)

## ⚙️ Instalación

1. Clonar el repositorio:

  git clone https://github.com/Osvaldo-Barral/banexcoin-backend

2. Instalar dependencias:

  Una vez clonado el repositorio, entra en la carpeta backend y ejecuta los siguientes comandos para instalar las dependencias necesarias:

  npm install

  Esto instalará todos los módulos de Node.js necesarios para el funcionamiento de la API.

## 🌱 Levantar el Proyecto Localmente

  Para correr la API de forma local, asegúrate de tener PostgreSQL corriendo en tu máquina. 
  
  npm run start:dev

  Este comando levantará el servidor en modo de desarrollo y la API estará disponible en http://localhost:3000.

## 🛠️ Base de Datos
  En la carpeta src/database/ encontrarás dos archivos relacionados con la base de datos:

  banexcoin_backup.sql: Un archivo de respaldo de la base de datos en formato .sql que puedes importar directamente a PostgreSQL para restaurar la base de datos con datos previos.

  banexcoin.sql: Este archivo contiene el script de creación y llenado de la base de datos.

## VAriable de entorno
  debe instalar dotenv para la variables de entorno y configurarlas para la conceccion de la base de datos y el usuario mockeado ya que es  un sistema que no tiene una autenticacion y se supone que ya un usuario esta loguedo.

  las configuracionesson la siguientes

  DB_HOST=localhost
  DB_PORT=5432
  DB_USERNAME=postgres
  DB_PASSWORD="sucontraseña"
  DB_NAME=el noombre de la base de datos
  DB_SYNC=true  # Solo para desarrollo

  ID_USUARIO="el id del usuario Mockeado, debe ser un numero entero"

## 📜 Comandos Útiles
  Iniciar el servidor en desarrollo:

  npm run start:dev

