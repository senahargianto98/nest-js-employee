/*
  Warnings:

  - You are about to drop the column `departemen` on the `employee` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "employee" DROP COLUMN "departemen",
ADD COLUMN     "departmen" TEXT;
