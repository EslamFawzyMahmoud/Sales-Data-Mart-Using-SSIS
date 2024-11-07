SELECT 
		Product_key,
		Product_id,
		standard_cost
FROM dim_product
WHERE is_current = 1;