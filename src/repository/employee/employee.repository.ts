import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/database/database.service';
import { IEmployeeRepository } from './employee.repository.abstract';
import { EmployeeEntity } from 'src/entities/employee/employee.entity';

@Injectable()
export class EmployeeRepository implements IEmployeeRepository {
    constructor(private readonly cloudsql: PrismaService) { }

    async createManyEmployee(data: any): Promise<{ count: number; data: any; }> {
        try {
            const result = await this.cloudsql.employee.createMany({
                data: data,
            });
            return {
                count: Object(result).length,
                data: result,
            };
        } catch (error) {
            throw error
        }
    }

    async createEmployee(data: EmployeeEntity): Promise<{ count: number; data: any; }> {
        try {
            const result = await this.cloudsql.employee.create({
                data: data,
            });
            return {
                count: Object(result).length,
                data: result,
            };
        } catch (error) {
            throw error
        }
    }

    async getEmployee(): Promise<{ count: number; data: any; }> {
        try {
            const [count_employee, employee] = await this.cloudsql.$transaction([
                this.cloudsql.employee.count(),
                this.cloudsql.employee.findMany({
                    select: {
                        id: true,
                        nama: true,
                        nomor: true,
                        jabatan: true,
                        departmen: true,
                        foto: true,
                        status: true
                    },
                    orderBy: {
                        "created_at": "desc"
                    }
                }),
            ]);
            return { count: count_employee, data: employee };
        } catch (error) {
            throw error
        }
    }

    async updateEmployee(id: string, data: any): Promise<{ count: number; data: any; }> {
        try {
            await this.cloudsql.employee.update({
                where: { id: id },
                data: data,
            });
            return {
                count: 1,
                data: data,
            };
        } catch (error) {
            throw error
        }
    }

    async deleteEmployee(id: string): Promise<{ count: number; }> {
        try {
            await this.cloudsql.employee.delete({
                where: { id: id },
            });
            return {
                count: 1,
            };
        } catch (error) {
            throw error
        }
    }
}