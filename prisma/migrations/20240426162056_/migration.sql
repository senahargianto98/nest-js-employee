/*
  Warnings:

  - You are about to drop the `associate` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `city` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `district` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `farmer` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `farmer_group` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `landing_page` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `menu` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `permission` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `province` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `role` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `static_menu` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sub_district` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `user` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "associate" DROP CONSTRAINT "city_fk";

-- DropForeignKey
ALTER TABLE "associate" DROP CONSTRAINT "district_fk";

-- DropForeignKey
ALTER TABLE "associate" DROP CONSTRAINT "province_fk";

-- DropForeignKey
ALTER TABLE "associate" DROP CONSTRAINT "subdistrict_fk";

-- DropForeignKey
ALTER TABLE "farmer" DROP CONSTRAINT "city_fk";

-- DropForeignKey
ALTER TABLE "farmer" DROP CONSTRAINT "district_fk";

-- DropForeignKey
ALTER TABLE "farmer" DROP CONSTRAINT "farmer_groupId_fk";

-- DropForeignKey
ALTER TABLE "farmer" DROP CONSTRAINT "province_fk";

-- DropForeignKey
ALTER TABLE "farmer" DROP CONSTRAINT "sub_district_fk";

-- DropForeignKey
ALTER TABLE "farmer_group" DROP CONSTRAINT "associateId_fk";

-- DropForeignKey
ALTER TABLE "farmer_group" DROP CONSTRAINT "city_id_fk";

-- DropForeignKey
ALTER TABLE "farmer_group" DROP CONSTRAINT "district_id_fk";

-- DropForeignKey
ALTER TABLE "farmer_group" DROP CONSTRAINT "province_id_fk";

-- DropForeignKey
ALTER TABLE "farmer_group" DROP CONSTRAINT "sub_district_id";

-- DropForeignKey
ALTER TABLE "landing_page" DROP CONSTRAINT "menu_id_fk";

-- DropForeignKey
ALTER TABLE "permission" DROP CONSTRAINT "menu_id_fk";

-- DropForeignKey
ALTER TABLE "permission" DROP CONSTRAINT "role_id_fk";

-- DropForeignKey
ALTER TABLE "user" DROP CONSTRAINT "associate_id_fk";

-- DropForeignKey
ALTER TABLE "user" DROP CONSTRAINT "role_id_fk";

-- DropTable
DROP TABLE "associate";

-- DropTable
DROP TABLE "city";

-- DropTable
DROP TABLE "district";

-- DropTable
DROP TABLE "farmer";

-- DropTable
DROP TABLE "farmer_group";

-- DropTable
DROP TABLE "landing_page";

-- DropTable
DROP TABLE "menu";

-- DropTable
DROP TABLE "permission";

-- DropTable
DROP TABLE "province";

-- DropTable
DROP TABLE "role";

-- DropTable
DROP TABLE "static_menu";

-- DropTable
DROP TABLE "sub_district";

-- DropTable
DROP TABLE "user";

-- DropEnum
DROP TYPE "farm_size";

-- DropEnum
DROP TYPE "gender";

-- CreateTable
CREATE TABLE "employee" (
    "id" UUID NOT NULL,
    "created_at" BIGINT NOT NULL,
    "created_by" UUID NOT NULL,
    "updated_at" BIGINT,
    "updated_by" UUID,
    "nama" TEXT,
    "nomor" TEXT,
    "jabatan" TEXT,
    "departmen" TEXT,
    "tanggal_masuk" TEXT,
    "foto" TEXT,
    "status" TEXT,

    CONSTRAINT "employee_pkey" PRIMARY KEY ("id")
);
