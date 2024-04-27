import { IsOptional, IsString } from 'class-validator';

export class UpdateEmployeeDto {
    @IsOptional()
    @IsString()
    nama: string

    @IsOptional()
    @IsString()
    nomor: string

    @IsOptional()
    @IsString()
    jabatan: string

    @IsOptional()
    @IsString()
    departmen: string

    @IsOptional()
    @IsString()
    tanggal_masuk: string

    @IsOptional()
    @IsString()
    foto: string

    @IsOptional()
    @IsString()
    status: string
}