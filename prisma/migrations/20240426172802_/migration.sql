/*
  Warnings:

  - You are about to drop the column `departmen` on the `employee` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "employee" DROP COLUMN "departmen",
ADD COLUMN     "departemen" TEXT;
