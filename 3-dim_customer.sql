USE EO_AdentureWorks2019
GO

--Droping Foreign Key
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_fact_sales_dim_customer'
                  AND parent_object_id = Object_id('fact_sales'))

ALTER TABLE fact_sales
DROP CONSTRAINT fk_fact_sales_dim_customer;

--DROP AND CREATE TABLE (Dim_Product)
IF EXISTS (SELECT * FROM sys.objects WHERE NAME ='dim_customer' AND type = 'U')
DROP TABLE IF EXISTS dim_customer;
go

CREATE TABLE dim_customer(
	Customer_key			INT NOT NULL IDENTITY(1,1), -- surrogate key
	Customer_id				INT NOT NULL, --Business key
	Customer_name			nvarchar(50),
	Address1				nvarchar(400),
	Address2				nvarchar(50),
	City					nvarchar(50),
	Phone					nvarchar(15),
	
	--MetaData
	source_system_code tinyint not null,

	--SCD
	start_date          DATETIME NOT NULL DEFAULT (Getdate()),
    end_date            DATETIME,
    is_current          TINYINT NOT NULL DEFAULT (1),
	CONSTRAINT pk_dim_customer PRIMARY KEY CLUSTERED (Customer_key)
);

-- Insert unknown record
SET IDENTITY_INSERT dim_customer ON

INSERT INTO dim_customer (Customer_key,Customer_id,Customer_name,Address1,Address2,City,Phone,source_system_code,start_date,end_date,is_current)
VALUES(0,0,'Unknown','Unknown','Unknown','Unknown','Unknown',0,'1900-01-01',NULL,1);

SET IDENTITY_INSERT dim_customer OFF

-- create foreign key
IF EXISTS (SELECT * FROM sys.tables WHERE NAME='fact_sales')

ALTER TABLE fact_sales 
ADD CONSTARINT fk_fact_sales_dim_customer FOREIGN KEY(Customer_key)
REFERENCES dim_customer(Customer_key);

--Create Index
IF EXISTS (SELECT * FROM sys.indexes WHERE NAME='dim_customer_Customer_id'		
											AND object_id = Object_id('dim_customer'))
DROP INDEX dim_customer.dim_customer_Customer_id;

CREATE INDEX dim_customer_Customer_id ON dim_customer(Customer_id);


IF EXISTS (SELECT * FROM sys.indexes WHERE NAME='dim_customer_city' 
											AND object_id = Object_id('dim_customer'))
DROP INDEX dim_customer.dim_customer_city;

CREATE INDEX dim_customer_city ON dim_customer(City);













































