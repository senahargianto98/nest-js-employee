import { IResponse } from 'src/response/response.interface';
import { AddEmployeeDto } from 'src/dto/employee/add_employee.payload.dto';

export abstract class IEmployeeService {
    abstract exportPdf(): Promise<IResponse>;
    abstract exportCsv(): Promise<IResponse>;
    abstract importCsv(csv: any): Promise<IResponse>;
    abstract getEmployee(): Promise<IResponse>;
    abstract createEmployee(payload: AddEmployeeDto): Promise<IResponse>;
    abstract updateEmployee(param: any, data: any): Promise<IResponse>;
    abstract deleteEmployee(param: any): Promise<IResponse>;
}