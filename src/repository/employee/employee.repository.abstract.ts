import { EmployeeEntity } from "src/entities/employee/employee.entity";

export abstract class IEmployeeRepository {
    abstract createManyEmployee(
        data: any,
    ): Promise<{ count: number; data: any }>;

    abstract createEmployee(
        data: EmployeeEntity,
    ): Promise<{ count: number; data: any }>;

    abstract getEmployee(): Promise<{ count: number; data: any }>;

    abstract updateEmployee(
        id: string,
        data: any,
    ): Promise<{ count: number; data: any }>;

    abstract deleteEmployee(
        id: string,
    ): Promise<{ count: number }>;
}
