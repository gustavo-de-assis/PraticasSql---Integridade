CREATE TABLE "transactions" (
	"id" serial NOT NULL PRIMARY KEY,
	"bankAccountId" integer NOT NULL,
	"amount" integer NOT NULL,
	"type" TEXT NOT NULL,
	"time" DATE NOT NULL,
	"description" TEXT NOT NULL,
	"cancelled" BOOLEAN NOT NULL DEFAULT FALSE
	
);



CREATE TABLE "creditCards" (
	"id" serial NOT NULL PRIMARY KEY,
	"bankAccountId" integer NOT NULL,
	"name" varchar(30) NOT NULL,
	"number" TEXT NOT NULL UNIQUE,
	"securityCode" TEXT NOT NULL,
	"expirationMonth" integer NOT NULL,
	"expirationYear" integer NOT NULL,
	"password" TEXT NOT NULL,
	"limit" integer NOT NULL
);



CREATE TABLE "bankAccount" (
	"id" serial NOT NULL PRIMARY KEY,
	"customerId" integer NOT NULL,
	"accountNumber" integer NOT NULL UNIQUE,
	"agency" integer NOT NULL,
	"openDate" DATE NOT NULL,
	"closeDate" DATE
);



CREATE TABLE "customers" (
	"id" serial NOT NULL PRIMARY KEY,
	"fullName" varchar(50) NOT NULL,
	"cpf" varchar(11) NOT NULL UNIQUE,
	"email" TEXT NOT NULL UNIQUE,
	"password" TEXT NOT NULL
);



CREATE TABLE "customerPhones" (
	"id" serial NOT NULL PRIMARY KEY,
	"customerId" integer NOT NULL,
	"number" integer NOT NULL,
	"type" TEXT NOT NULL
);



CREATE TABLE "customerAddresses" (
	"id" serial NOT NULL PRIMARY KEY,
	"customerId" integer NOT NULL,
	"street" TEXT NOT NULL,
	"number" TEXT NOT NULL,
	"complement" TEXT NOT NULL,
	"postalCode" TEXT NOT NULL,
	"cityId" integer NOT NULL
);



CREATE TABLE "cities" (
	"id" serial NOT NULL PRIMARY KEY,
	"name" TEXT NOT NULL,
	"stateId" integer NOT NULL
);



CREATE TABLE "states" (
	"id" serial NOT NULL PRIMARY KEY,
	"name" TEXT NOT NULL UNIQUE
);



ALTER TABLE "transactions" ADD CONSTRAINT "transactions_fk0" FOREIGN KEY ("bankAccountId") REFERENCES "bankAccount"("id");

ALTER TABLE "creditCards" ADD CONSTRAINT "creditCards_fk0" FOREIGN KEY ("bankAccountId") REFERENCES "bankAccount"("id");

ALTER TABLE "bankAccount" ADD CONSTRAINT "bankAccount_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");


ALTER TABLE "customerPhones" ADD CONSTRAINT "customerPhones_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");

ALTER TABLE "customerAddresses" ADD CONSTRAINT "customerAddresses_fk0" FOREIGN KEY ("customerId") REFERENCES "customers"("id");
ALTER TABLE "customerAddresses" ADD CONSTRAINT "customerAddresses_fk1" FOREIGN KEY ("cityId") REFERENCES "cities"("id");

ALTER TABLE "cities" ADD CONSTRAINT "cities_fk0" FOREIGN KEY ("stateId") REFERENCES "states"("id");

CREATE TYPE phonetype AS ENUM ('landline', 'mobile');
CREATE TYPE transactiontype AS ENUM ('withdraw', 'deposit');

ALTER TABLE "transactions" 
	ALTER COLUMN type TYPE transactiontype
	USING type::transactiontype;

ALTER TABLE "customerPhones" 
	ALTER COLUMN type TYPE phonetype
	USING type::phonetype;





