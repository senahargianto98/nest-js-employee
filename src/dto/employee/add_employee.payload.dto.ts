import { IsNotEmpty, IsString } from 'class-validator';

export class AddEmployeeDto {
    @IsNotEmpty()
    @IsString()
    nama: string

    @IsNotEmpty()
    @IsString()
    nomor: string

    @IsNotEmpty()
    @IsString()
    jabatan: string

    @IsNotEmpty()
    @IsString()
    departmen: string

    @IsNotEmpty()
    @IsString()
    tanggal_masuk: string

    @IsNotEmpty()
    @IsString()
    foto: string

    @IsNotEmpty()
    @IsString()
    status: string
}