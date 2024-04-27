import {
  Logger,
  ExceptionFilter,
  Catch,
  ArgumentsHost,
  HttpException,
  BadRequestException,
  BadGatewayException,
} from '@nestjs/common';
import { prismaClientError } from 'src/utils/PrismaError';
import { Response } from 'express';

@Catch(HttpException)
export class HttpExceptionFilter implements ExceptionFilter {
  catch(exception: HttpException, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const request = ctx.getRequest<any>();
    const response = ctx.getResponse<Response>();
    const code = exception.getStatus();
    const errors = exception.getResponse();

    // filter error for bad request execution only
    if (exception instanceof BadRequestException) {
      if (process.env.NODE_ENV !== 'production') {
        // write error log to file
        Logger.error(Object.values(errors).at(-1), {
          params: request.params,
          query: request.query,
          payload: request.payload,
          endpoint: host.getArgs()[0]['url'],
          response: errors,
        });
      }

      const message = errors['message'];

      return response.status(code).send({
        code: code,
        message: message,
        count: 0,
        data: [],
        errors: [],
      });
    }

    // filter error for bad gateway exception only
    if (exception instanceof BadGatewayException) {
      if (process.env.NODE_ENV === 'production') {
        // write error log to file
        Logger.error(exception.name, {
          params: request.params,
          query: request.query,
          payload: request.payload,
          endpoint: host.getArgs()[0]['url'],
          response: exception,
        });
      }

      return response.status(code).send({
        code: code,
        message: response.statusMessage,
        count: 0,
        data: [],
        errors: [prismaClientError(exception.message)],
      });
    }

    const message = errors['message'];

    // if error not bad request or bad gateway
    return response.status(code).send({
      code: code,
      message: response.statusMessage,
      count: 0,
      data: [],
      errors: [message],
    });
  }
}
