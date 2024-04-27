export class EmployeeEntity {
    id: string;
    created_at: bigint;
    nama?: string;
    nomor?: string;
    jabatan?: string;
    departmen?: string;
    tanggal_masuk?: string;
    foto?: string;
    status?: string;

    constructor(partial: Partial<EmployeeEntity>) {
        Object.assign(this, partial);
    }
}
