SELECT	SalesOrderID,
		SalesOrderDetailID,
		OrderQty,
		ProductID,
		UnitPrice,
		UnitPriceDiscount,
		LineTotal
FROM Sales.SalesOrderDetail
ORDER BY SalesOrderID