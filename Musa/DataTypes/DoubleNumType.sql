-- real фиксированная точность
DECLARE @num1 real = 100.01231
-- float можно указать точность
DECLARE @num2 float(3) = 0.12321

SELECT @num1 AS Rel, @num2 AS Flot