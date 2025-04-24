import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { AppDataSource } from './database/datasource';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  try {
    await AppDataSource.initialize();
    console.log('Database connected');
  } catch (error) {
    console.error('Database connection failed', error);
  }

  await app.listen(3000);
}
bootstrap();
