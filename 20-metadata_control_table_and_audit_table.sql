USE EO_AdentureWorks2019
GO

-- Create Control Table
IF EXISTS ( SELECT * 
			FROM sys.tables 
			where NAME = 'meta_control_table '
			AND TYPE = 'u'
)
DROP TABLE meta_control_table ;

CREATE TABLE meta_control_table (
	id					INT IDENTITY(1,1),
	source_table		nvarchar(50) not null,
	last_load_date		datetime
);

INSERT INTO meta_control_table (source_table , last_load_date)
VALUES ('sales order header' , '1900-01-01');

SELECT * FROM meta_control_table;
