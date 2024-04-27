-- CreateEnum
CREATE TYPE "farm_size" AS ENUM ('Small', 'Medium', 'Large');

-- CreateEnum
CREATE TYPE "gender" AS ENUM ('Male', 'Female');

-- CreateTable
CREATE TABLE "associate" (
    "id" UUID NOT NULL,
    "created_at" BIGINT NOT NULL,
    "created_by" UUID NOT NULL,
    "updated_at" BIGINT,
    "updated_by" UUID,
    "province_id" UUID NOT NULL,
    "city_id" UUID NOT NULL,
    "district_id" UUID NOT NULL,
    "sub_district_id" UUID NOT NULL,
    "agenda_number" VARCHAR(50) NOT NULL,
    "ig_certificate_number" VARCHAR(100) NOT NULL,
    "image" TEXT NOT NULL,
    "registration_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "product" VARCHAR(100) NOT NULL,
    "owner" VARCHAR(150) NOT NULL,
    "village" VARCHAR(150) NOT NULL,
    "postal_code" VARCHAR(10) NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "address" TEXT NOT NULL,
    "count_of_subdistrict" INTEGER NOT NULL DEFAULT 0,
    "count_of_district" INTEGER NOT NULL DEFAULT 0,
    "count_of_village" INTEGER NOT NULL DEFAULT 0,
    "count_of_farmer" INTEGER NOT NULL DEFAULT 0,
    "count_of_farmer_group" INTEGER NOT NULL DEFAULT 0,
    "land_area" INTEGER,
    "count_of_city" INTEGER,

    CONSTRAINT "associate_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "city" (
    "province_id" VARCHAR,
    "kabupaten_id" VARCHAR,
    "kab_kota" VARCHAR(50),
    "id" UUID NOT NULL,

    CONSTRAINT "city_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "district" (
    "province_id" VARCHAR,
    "kabupaten_id" VARCHAR,
    "kecamatan_id" VARCHAR,
    "kecamatan" VARCHAR(50),
    "id" UUID NOT NULL,
    "kab_kota" VARCHAR(50),

    CONSTRAINT "district_pk" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "farmer" (
    "id" UUID NOT NULL,
    "created_at" BIGINT NOT NULL,
    "created_by" UUID NOT NULL,
    "updated_at" BIGINT,
    "updated_by" UUID,
    "farmer_groupId" UUID NOT NULL,
    "name_of_subak" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "number_id" TEXT NOT NULL,
    "phone_number" TEXT NOT NULL,
    "gender" "gender" NOT NULL,
    "latitude" DOUBLE PRECISION NOT NULL,
    "longitude" DOUBLE PRECISION NOT NULL,
    "country" TEXT NOT NULL,
    "village" TEXT NOT NULL,
    "farm_area_in_ha" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "farm_coffe_production" DOUBLE PRECISION NOT NULL DEFAULT 0,
    "count_of_tree" INTEGER NOT NULL DEFAULT 0,
    "farm_size" "farm_size" NOT NULL,
    "coffe_cherry" INTEGER NOT NULL DEFAULT 0,
    "green_coffe" INTEGER NOT NULL DEFAULT 0,
    "province_id" UUID,
    "city_id" UUID,
    "district_id" UUID,
    "sub_district_id" UUID,

    CONSTRAINT "farmer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "farmer_group" (
    "id" UUID NOT NULL,
    "created_at" BIGINT NOT NULL,
    "created_by" UUID NOT NULL,
    "updated_at" BIGINT,
    "updated_by" UUID,
    "associateId" UUID NOT NULL,
    "busnisess_licence_number" TEXT NOT NULL,
    "busnisess_esthablishment_date" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "group_name" TEXT NOT NULL,
    "group_leader_name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "count_of_farmer" INTEGER NOT NULL DEFAULT 0,
    "village" TEXT NOT NULL,
    "munduk" TEXT NOT NULL,
    "province_id" UUID,
    "district_id" UUID,
    "sub_district_id" UUID,
    "city_id" UUID,

    CONSTRAINT "farmer_group_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "landing_page" (
    "id" UUID NOT NULL,
    "created_at" BIGINT NOT NULL,
    "created_by" UUID NOT NULL,
    "updated_at" BIGINT,
    "updated_by" UUID,
    "content" JSONB NOT NULL,
    "menu_id" UUID NOT NULL,

    CONSTRAINT "landing_page_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "menu" (
    "id" UUID NOT NULL,
    "created_at" BIGINT NOT NULL,
    "created_by" UUID NOT NULL,
    "updated_at" BIGINT,
    "updated_by" UUID,
    "menu_name" TEXT NOT NULL,

    CONSTRAINT "menu_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "permission" (
    "id" UUID NOT NULL,
    "created_at" BIGINT NOT NULL,
    "created_by" UUID NOT NULL,
    "updated_at" BIGINT,
    "updated_by" UUID,
    "role_id" UUID NOT NULL,
    "static_menu_id" UUID NOT NULL,
    "create" BOOLEAN NOT NULL,
    "update" BOOLEAN NOT NULL,
    "read" BOOLEAN NOT NULL,
    "delete" BOOLEAN NOT NULL,

    CONSTRAINT "permission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "province" (
    "province_id" VARCHAR,
    "province" VARCHAR(50),
    "id" UUID NOT NULL,

    CONSTRAINT "province_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "role" (
    "id" UUID NOT NULL,
    "created_at" BIGINT NOT NULL,
    "created_by" UUID NOT NULL,
    "updated_at" BIGINT,
    "updated_by" UUID,
    "role_name" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL,

    CONSTRAINT "role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "static_menu" (
    "id" UUID NOT NULL,
    "created_at" BIGINT NOT NULL,
    "created_by" UUID NOT NULL,
    "updated_at" BIGINT,
    "updated_by" UUID,
    "menu_name" TEXT NOT NULL,
    "icon" TEXT NOT NULL,
    "path" TEXT NOT NULL,

    CONSTRAINT "static_menu_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "sub_district" (
    "province_id" VARCHAR,
    "kabupaten_id" VARCHAR,
    "kecamatan_id" VARCHAR,
    "kelurahan_id" VARCHAR,
    "kelurahan_desa" VARCHAR(50),
    "id" UUID NOT NULL,

    CONSTRAINT "sub_district_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "user" (
    "id" UUID NOT NULL,
    "created_at" BIGINT NOT NULL,
    "created_by" UUID NOT NULL,
    "updated_at" BIGINT,
    "updated_by" UUID,
    "username" VARCHAR(100) NOT NULL,
    "password" TEXT NOT NULL,
    "access_token" TEXT,
    "refresh_token" TEXT,
    "email" VARCHAR(50) NOT NULL,
    "image" TEXT,
    "role_id" UUID NOT NULL,
    "status" BOOLEAN,
    "associate_id" UUID,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "static_menu_path_key" ON "static_menu"("path");

-- CreateIndex
CREATE UNIQUE INDEX "user_username_idx" ON "user"("username");

-- AddForeignKey
ALTER TABLE "associate" ADD CONSTRAINT "city_fk" FOREIGN KEY ("city_id") REFERENCES "city"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "associate" ADD CONSTRAINT "district_fk" FOREIGN KEY ("district_id") REFERENCES "district"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "associate" ADD CONSTRAINT "province_fk" FOREIGN KEY ("province_id") REFERENCES "province"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "associate" ADD CONSTRAINT "subdistrict_fk" FOREIGN KEY ("sub_district_id") REFERENCES "sub_district"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "farmer" ADD CONSTRAINT "city_fk" FOREIGN KEY ("city_id") REFERENCES "city"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "farmer" ADD CONSTRAINT "district_fk" FOREIGN KEY ("district_id") REFERENCES "district"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "farmer" ADD CONSTRAINT "farmer_groupId_fk" FOREIGN KEY ("farmer_groupId") REFERENCES "farmer_group"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "farmer" ADD CONSTRAINT "province_fk" FOREIGN KEY ("province_id") REFERENCES "province"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "farmer" ADD CONSTRAINT "sub_district_fk" FOREIGN KEY ("sub_district_id") REFERENCES "sub_district"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "farmer_group" ADD CONSTRAINT "associateId_fk" FOREIGN KEY ("associateId") REFERENCES "associate"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "farmer_group" ADD CONSTRAINT "city_id_fk" FOREIGN KEY ("city_id") REFERENCES "city"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "farmer_group" ADD CONSTRAINT "district_id_fk" FOREIGN KEY ("district_id") REFERENCES "district"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "farmer_group" ADD CONSTRAINT "province_id_fk" FOREIGN KEY ("province_id") REFERENCES "province"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "farmer_group" ADD CONSTRAINT "sub_district_id" FOREIGN KEY ("sub_district_id") REFERENCES "sub_district"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "landing_page" ADD CONSTRAINT "menu_id_fk" FOREIGN KEY ("menu_id") REFERENCES "menu"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "permission" ADD CONSTRAINT "menu_id_fk" FOREIGN KEY ("static_menu_id") REFERENCES "static_menu"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "permission" ADD CONSTRAINT "role_id_fk" FOREIGN KEY ("role_id") REFERENCES "role"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "associate_id_fk" FOREIGN KEY ("associate_id") REFERENCES "associate"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "user" ADD CONSTRAINT "role_id_fk" FOREIGN KEY ("role_id") REFERENCES "role"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
