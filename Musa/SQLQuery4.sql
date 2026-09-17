USE TestIndex
GO

CREATE CLUSTERED INDEX ind_1
ON orders(id)

CREATE  INDEX ind_2
ON orders(product_id)
