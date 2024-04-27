import { v4 } from 'uuid';
import { Parser } from 'json2csv';
import * as PDFDocument from 'pdfkit';
import * as fs from 'fs';
import * as csvParser from 'csv-parser';
import {
    Injectable,
    HttpStatus,
} from '@nestjs/common';
import { IResponse } from 'src/response/response.interface';
import { Response } from 'src/response/response';
import { IEmployeeService } from './employee.service.abstract';
import { AddEmployeeDto } from 'src/dto/employee/add_employee.payload.dto';
import { IEmployeeRepository } from 'src/repository/employee/employee.repository.abstract';
import { UpdateEmployeeDto } from 'src/dto/employee/update_employe.payload.dto';

@Injectable()
export class EmployeeService implements IEmployeeService {
    constructor(
        private readonly employeeRepository: IEmployeeRepository,
    ) { }

    async exportPdf(): Promise<IResponse> {
        try {
            const data = await this.employeeRepository.getEmployee();
            const doc = new PDFDocument();
            const timeNow = BigInt(Date.now());
            const stream = fs.createWriteStream(`directory/employees_${timeNow}.pdf`);
            doc.pipe(stream);
            doc.text(JSON.stringify(data.data));
            doc.end();
            const url = `http://localhost:3000/employees_${timeNow}.pdf`
            return new Response(HttpStatus.OK, 'ok', 1, url, null);
        } catch (error) {
            throw error;
        }
    }

    async exportCsv(): Promise<IResponse> {
        try {
            const data = await this.employeeRepository.getEmployee();
            const jsonParser = new Parser();
            const csvData = jsonParser.parse(data.data);
            const timeNow = BigInt(Date.now())
            const fileName = `directory/employees_${timeNow}.csv`;
            fs.writeFileSync(fileName, csvData, 'utf8');
            const url = `http://localhost:3000/employees_${timeNow}.csv`
            return new Response(HttpStatus.OK, 'ok', 1, url, null);
        } catch (error) {
            throw error;
        }
    }

    async importCsv(csv: any): Promise<IResponse> {
        try {
            const csvBuffer = csv.csv[0].buffer;

            const csvData = csvBuffer.toString('utf-8');

            const parsedRows: any[] = [];

            const processDataPromise = new Promise<void>((resolve, reject) => {

                const stream = csvParser();

                stream.on('data', (row: any) => {
                    const rowDataFinal = {
                        ...row,
                        id: v4(),
                        created_at: BigInt(Date.now()),
                    };
                    parsedRows.push(rowDataFinal)
                });

                stream.on('end', () => {
                    resolve();
                });

                stream.on('error', (error: Error) => {
                    reject(error);
                });

                stream.write(csvData);

                stream.end();
            });


            await processDataPromise;

            await this.employeeRepository.createManyEmployee(parsedRows)

            const data = await this.employeeRepository.getEmployee();

            return new Response(HttpStatus.OK, 'ok', null, null, null);
        } catch (error) {
            throw error;
        }
    }

    async getEmployee(): Promise<IResponse> {
        try {
            const data = await this.employeeRepository.getEmployee()
            return new Response(HttpStatus.OK, 'ok', data.count, data.data, null);
        } catch (error) {
            throw error
        }
    }

    async createEmployee(payload: AddEmployeeDto) {
        try {
            const id = await v4();
            const data = {
                id: id,
                created_at: BigInt(Date.now()),
                nama: payload.nama,
                nomor: payload.nomor,
                jabatan: payload.jabatan,
                departmen: payload.departmen,
                tanggal_masuk: payload.tanggal_masuk,
                foto: payload.foto,
                status: payload.status
            }
            await this.employeeRepository.createEmployee(data)
            return new Response(HttpStatus.OK, 'ok', null, null, null);
        } catch (error) {
            throw error
        }
    }

    async updateEmployee(param: string, data: UpdateEmployeeDto) {
        try {
            await this.employeeRepository.updateEmployee(param, data)
            return new Response(HttpStatus.OK, 'ok', null, null, null);
        } catch (error) {
            throw error
        }
    }

    async deleteEmployee(param: string): Promise<IResponse> {
        try {
            await this.employeeRepository.deleteEmployee(param)
            return new Response(HttpStatus.OK, 'ok', null, null, null);
        } catch (error) {
            throw error
        }
    }
}