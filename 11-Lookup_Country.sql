USE EO_AdentureWorks2019
GO

IF EXISTS (SELECT * 
			FROM sys.tables 
			WHERE NAME= 'Lookup_Country')
DROP TABLE Lookup_Country;

CREATE TABLE Lookup_Country(
	country_id		INT NOT NULL IDENTITY(1,1),
	country_name	VARCHAR(50) NOT NULL,
	country_code	VARCHAR(5) NOT NULL,
	country_region	VARCHAR(50)
);

INSERT INTO Lookup_Country (country_name, country_code, country_region) 
VALUES	('United States', 'US', 'North America'), 
        ('Canada', 'CA', 'North America'), 
        ('France', 'FR', 'Europe'), 
        ('Germany', 'DE', 'Europe'), 
        ('Australia', 'AU', 'Pacific'), 
        ('United Kingdom', 'GB', 'Europe'); 

ALTER TABLE Lookup_Country
ALTER COLUMN country_code NVARCHAR(5);

ALTER TABLE Lookup_Country
ALTER COLUMN country_name NVARCHAR(50);

ALTER TABLE Lookup_Country
ALTER COLUMN country_region NVARCHAR(50);