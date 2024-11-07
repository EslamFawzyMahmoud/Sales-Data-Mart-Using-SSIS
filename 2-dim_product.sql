USE EO_AdentureWorks2019
GO

--Droping Foreign Key
IF EXISTS (SELECT *
           FROM   sys.foreign_keys
           WHERE  NAME = 'fk_fact_sales_dim_product'
                  AND parent_object_id = Object_id('fact_sales'))

ALTER TABLE fact_sales
DROP CONSTRAINT fk_fact_sales_dim_product;

--DROP AND CREATE TABLE (Dim_Product)
IF EXISTS (SELECT * FROM sys.objects WHERE NAME ='dim_product' AND type = 'U')
DROP TABLE IF EXISTS dim_product;
go

CREATE TABLE dim_product(
	Product_key				INT NOT NULL IDENTITY(1,1), -- surrogate key
	Product_id				INT NOT NULL, --Business key
	Product_name			nvarchar(50),
	Product_description		nvarchar(400),
	Product_Subcategory		nvarchar(50),
	Product_category		nvarchar(50),
	color					nvarchar(15),
	model_name				nvarchar(50),
	reorder_point			SMALLINT,
	standard_cost			MONEY,

	--MetaData
	source_system_code tinyint not null,

	--SCD
	start_date          DATETIME NOT NULL DEFAULT (Getdate()),
    end_date            DATETIME,
    is_current          TINYINT NOT NULL DEFAULT (1),
	CONSTRAINT pk_dim_product PRIMARY KEY CLUSTERED (Product_key)
)

-- Insert unknown record
SET IDENTITY_INSERT dim_product ON

INSERT INTO dim_product (Product_key,Product_id,Product_name,Product_description,Product_Subcategory,Product_category,color,model_name,reorder_point,standard_cost,source_system_code,start_date,end_date,is_current)
VALUES      (0,0,'Unknown','Unknown','Unknown','Unknown','Unknown','Unknown',0,0,0,'1900-01-01',NULL,1)

SET IDENTITY_INSERT dim_product OFF

-- create foreign key
IF EXISTS (SELECT * FROM sys.tables WHERE NAME='fact_sales')

ALTER TABLE fact_sales 
ADD CONSTARINT fk_fact_sales_dim_product FOREIGN KEY(Product_key)
REFERENCES dim_product(Product_key);

--Create Index
IF EXISTS (SELECT * FROM sys.indexes WHERE NAME='dim_product_product_id'		
											AND object_id = Object_id('dim_product'))
DROP INDEX dim_product.dim_product_product_id;

CREATE INDEX dim_product_product_id ON dim_product(Product_id);


IF EXISTS (SELECT * FROM sys.indexes WHERE NAME='dim_prodct_product_category' 
											AND object_id = Object_id('dim_product'))
DROP INDEX dim_product.dim_prodct_product_category;

CREATE INDEX dim_prodct_product_category ON dim_product(Product_category);
