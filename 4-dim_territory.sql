USE EO_AdentureWorks2019
GO

--Droping Foreign Key
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_fact_sales_dim_territory'
                  AND parent_object_id = Object_id('fact_sales'))

ALTER TABLE fact_sales
DROP CONSTRAINT fk_fact_sales_dim_territory;

--DROP AND CREATE TABLE (Dim_Product)
IF EXISTS (SELECT * FROM sys.objects WHERE NAME ='dim_territory' AND type = 'U')
DROP TABLE IF EXISTS dim_territory;
go

CREATE TABLE dim_territory(
	Territory_key			INT NOT NULL IDENTITY(1,1), -- surrogate key
	Territory_id			INT NOT NULL, --Business key
	Territory_name			nvarchar(50),
	Territory_country		nvarchar(400),
	Territory_group			nvarchar(50),
	--MetaData
	source_system_code tinyint not null,
	--SCD
	start_date          DATETIME NOT NULL DEFAULT (Getdate()),
    end_date            DATETIME,
    is_current          TINYINT NOT NULL DEFAULT (1),
	CONSTRAINT pk_dim_territory PRIMARY KEY CLUSTERED (Territory_key)
);

-- Insert unknown record
SET IDENTITY_INSERT dim_territory ON

INSERT INTO dim_territory (Territory_key,Territory_id,Territory_name,Territory_country,Territory_group,source_system_code,start_date,end_date,is_current)
VALUES(0,0,'Unknown','Unknown','Unknown',0,'1900-01-01',NULL,1);

SET IDENTITY_INSERT dim_territory OFF

-- create foreign key
IF EXISTS (SELECT * FROM sys.tables WHERE NAME='fact_sales')

ALTER TABLE fact_sales 
ADD CONSTARINT fk_fact_sales_dim_customer FOREIGN KEY(Territory_key)
REFERENCES dim_territory(Territory_key);

--Create Index
IF EXISTS (SELECT *
           FROM   sys.indexes
           WHERE  NAME = 'dim_territory_territory_code'
                  AND object_id = Object_id('dim_territory'))
 DROP INDEX dim_territory.dim_territory_territory_code;

CREATE INDEX dim_territory_territory_id ON dim_territory(Territory_id); 