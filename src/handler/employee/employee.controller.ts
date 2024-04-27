import {
    Controller,
    Body,
    Res,
    Put,
    Param,
    Post,
    Delete,
    Get,
    UploadedFiles,
    UseInterceptors,
} from '@nestjs/common';
import { Response } from 'express';
import { AddEmployeeDto } from 'src/dto/employee/add_employee.payload.dto';
import { UpdateEmployeeDto } from 'src/dto/employee/update_employe.payload.dto';
import { IEmployeeService } from 'src/service/employee/employee.service.abstract';
import { FileFieldsInterceptor } from '@nestjs/platform-express';

@Controller('/v1/api/employee')
export class EmployeeController {
    constructor(private readonly employeeService: IEmployeeService) { }

    @Post('/export-pdf')
    async exportPdf(
        @Res() response: Response,
    ): Promise<any> {
        try {
            const result = await this.employeeService.exportPdf()
            return response.status(200).send(result);
        } catch (error) {
            throw error;
        }
    }


    @Post('/export-csv')
    async exportCsv(
        @Res() response: Response,
    ): Promise<any> {
        try {
            const result = await this.employeeService.exportCsv()
            return response.status(200).send(result);
        } catch (error) {
            throw error;
        }
    }

    @Post('/import-csv')
    @UseInterceptors(FileFieldsInterceptor([{ name: 'csv', maxCount: 1 }]))
    async importCsv(
        @Res() response: Response,
        @UploadedFiles() csv: any,
    ): Promise<any> {
        try {
            const result = await this.employeeService.importCsv(csv)
            return response.status(200).send(result);
        } catch (error) {
            throw error;
        }
    }

    @Post('/add-employee')
    async addEmployee(
        @Res() response: Response,
        @Body() payload: AddEmployeeDto,
    ): Promise<any> {
        try {
            const result = await this.employeeService.createEmployee(payload);
            return response.status(result.code).send(result);
        } catch (error) {
            throw error;
        }
    }

    @Get('/get-employee')
    async getEmployee(
        @Res() response: Response,
    ): Promise<any> {
        try {
            const result = await this.employeeService.getEmployee();
            return response.status(result.code).send(result);
        } catch (error) {
            throw error;
        }
    }

    @Put('/update-employee/:employee_id')
    async updateEmployee(
        @Param('employee_id') param: string,
        @Res() response: Response,
        @Body() payload: UpdateEmployeeDto,
    ): Promise<any> {
        try {
            const result = await this.employeeService.updateEmployee(param, payload);
            return response.status(result.code).send(result);
        } catch (error) {
            throw error;
        }
    }

    @Delete('/delete-employee/:employee_id')
    async deleteEmployee(
        @Param('employee_id') param: string,
        @Res() response: Response,
    ): Promise<any> {
        try {
            const result = await this.employeeService.deleteEmployee(param);
            return response.status(result.code).send(result);
        } catch (error) {
            throw error;
        }
    }
}