import { NestFactory } from '@nestjs/core';
import { WinstonModule } from 'nest-winston';
import { transports, format } from 'winston';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { HttpExceptionFilter } from './response/http-exception.filter';
import multipart from '@fastify/multipart';
import { config } from 'dotenv';
import { join } from 'path';
import {
  NestFastifyApplication,
} from '@nestjs/platform-fastify';
import { AppModule } from './app.module';
config({ path: join(__dirname, '../.env') });
import 'winston-daily-rotate-file';
import * as bodyParser from 'body-parser';

async function bootstrap() {
  const app = await NestFactory.create<NestFastifyApplication>(
    AppModule
  );
  app.enableCors({
    allowedHeaders: '*',
    exposedHeaders: 'access_token,refresh_token',
    origin: '*',
    credentials: true,
  });

  app.useGlobalPipes(new ValidationPipe({ whitelist: true, transform: true }));

  app.useGlobalFilters(new HttpExceptionFilter());

  app.use(bodyParser.json({ limit: '50mb' }));

  app.use(bodyParser.urlencoded({ limit: '50mb', extended: true }));

  const config = new DocumentBuilder()
    .setTitle('Employee')
    .setDescription(
      'an API that automatically serve the front end needs,build with love by sena',
    )
    .setVersion('1.0')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document, {
    swaggerOptions: {
      persistAuthorization: true, // this
    },
  });
  await app.listen(process.env.PORT, '0.0.0.0', () =>
    console.log(`Listening on port: ${process.env.PORT}`),
  );
  console.log(`Application is running on: ${await app.getUrl()}`);
}
bootstrap();
