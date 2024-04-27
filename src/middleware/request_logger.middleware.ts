import { Injectable, Logger, NestMiddleware } from '@nestjs/common';
import { Request, Response, NextFunction } from 'express';

@Injectable()
export class RequestLoggerMiddleware implements NestMiddleware {
  private readonly logger = new Logger();

  use(req: Request, res: Response, next: NextFunction) {
    res.on('finish', () => {
      const statusCode = res.statusCode;
      if (statusCode === 401 || statusCode === 404 || statusCode === 405) {
        this.logger.warn(`${req.method} | ${res.statusMessage} | ${req.url} `);
      }

      if (statusCode === 200 || statusCode === 201) {
        this.logger.log(`${req.method} | ${res.statusMessage} | ${req.url} `);
      }
    });

    next();
  }
}
