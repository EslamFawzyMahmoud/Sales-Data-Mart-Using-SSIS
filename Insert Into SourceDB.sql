USE AdventureWorks2019
GO

SET IDENTITY_INSERT Sales.SalesOrderHeader on

insert into Sales.SalesOrderHeader 
(SalesOrderID , OrderDate , DueDate , ShipDate , CustomerID ,BillToAddressID , ShipToAddressID ,ShipMethodID)

VALUES  (1,'20190918','20190918','20190918',11019,921,921,5),
		(2,'20190918','20190918','20190918',11019,921,921,5),
		(3,'20190918','20190918','20190918',11019,921,921,5),
		(4,'20190918','20190918','20190918',11019,921,921,5),
		(5,'20190918','20190918','20190918',11019,921,921,5)
SET IDENTITY_INSERT Sales.SalesOrderHeader off


SET IDENTITY_INSERT Sales.SalesOrderDetail on

insert into Sales.SalesOrderDetail 
(SalesOrderID , SalesOrderDetailID , ProductID , OrderQty , UnitPrice ,SpecialOfferID)

VALUES  (1,1,771,1,1,1),
		(2,1,771,1,1,1),
		(3,1,771,1,1,1),
		(4,1,771,1,1,1),
		(5,1,771,1,1,1)
SET IDENTITY_INSERT Sales.SalesOrderDetail off