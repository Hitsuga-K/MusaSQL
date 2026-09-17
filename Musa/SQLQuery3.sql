USE TestIndex;
GO

CREATE TABLE orders(
    id          uniqueidentifier,
    product_id  uniqueidentifier,
    customer_id uniqueidentifier,
    price       money
);
GO

INSERT INTO orders
VALUES ( NEWID(),
         NEWID(),
         NEWID(),
         DatePart(MICROSECOND, GetDate())
       );
GO 10000000

SELECT * FROM orders WHERE id = 'A617F24D-F602-4997-A0B3-2D06072203BF'