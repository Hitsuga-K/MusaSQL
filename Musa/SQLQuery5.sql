USE TestIndex
GO 

CREATE NONCLUSTERED INDEX ncl1_index
	on orders2(product_id)
GO

DROP INDEX ncl1_index
	on orders2
GO

SELECT * 
FROM orders2
WHERE id = 'A617F24D-F602-4997-A0B3-2D06072203BF'
