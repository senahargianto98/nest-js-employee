import { Logger, MiddlewareConsumer, Module } from '@nestjs/common';
import { APP_FILTER } from '@nestjs/core';
import { HttpModule } from '@nestjs/axios';
import { PrismaService } from './database/database.service';
import { HttpExceptionFilter } from 'src/response/http-exception.filter';
import { RequestLoggerMiddleware } from './middleware/request_logger.middleware';
import { ConfigModule } from '@nestjs/config';
import { EmployeeController } from './handler/employee/employee.controller';
import { IEmployeeService } from './service/employee/employee.service.abstract';
import { EmployeeService } from './service/employee/employee.service';
import { IEmployeeRepository } from './repository/employee/employee.repository.abstract';
import { EmployeeRepository } from './repository/employee/employee.repository';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';

@Module({
  imports: [
    HttpModule,
    ConfigModule.forRoot(),
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'directory'),
    }),
  ],
  controllers: [EmployeeController],
  providers: [
    Logger,
    PrismaService,
    {
      provide: IEmployeeService,
      useClass: EmployeeService,
    },
    {
      provide: IEmployeeRepository,
      useClass: EmployeeRepository,
    },
    {
      provide: APP_FILTER,
      useClass: HttpExceptionFilter,
    },
  ],
})
export class AppModule {
  configure(consumer: MiddlewareConsumer) {
    consumer.apply(RequestLoggerMiddleware).forRoutes('*');
  }
}
