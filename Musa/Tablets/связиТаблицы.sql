USE DB5
GO

CREATE TABLE categories(
	id int PRIMARY KEY IDENTITY(1,1),
	name varchar(50) NOT NULL,
)
GO

CREATE TABLE brands(
	id int PRIMARY KEY IDENTITY(1,1),
	name varchar (50) NOT NULL,
	category_id INT FOREIGN KEY REFERENCES categories(id)
);
GO
CREATE TABLE supplies(
	id int PRIMARY KEY IDENTITY(1,1),
	name varchar(100) NOT NULL,
	phone varchar(20)  NULL,
	brands_id INT FOREIGN KEY REFERENCES brands(id)
);
GO
CREATE TABLE warehouses(
	id int PRIMARY KEY IDENTITY(1,1),
	address varchar(200) NOT NULL,
	supplies_id INT FOREIGN KEY REFERENCES supplies(id),
)
GO
CREATE TABLE products(
	id int PRIMARY KEY IDENTITY(1,1),
	name varchar(252) NOT NULL,
	price DECIMAL(10,2) NOT NULL,
	category_id INT FOREIGN KEY REFERENCES categories(id),
	brands_id INT FOREIGN KEY REFERENCES brands(id),
	supplies_id INT FOREIGN KEY REFERENCES supplies(id),
	warehouses_id INT FOREIGN KEY REFERENCES warehouses(id),
)
GO
INSERT INTO categories (name) VALUES
('Бред'),
('Шизофрения'),
('Ну блин хз');
GO
INSERT INTO brands (name, category_id) VALUES
('F22.0  ', 1),
('Психушка', 2),
('Найти', 3);
GO


INSERT INTO supplies (name, phone, brands_id) VALUES
('Имя', '+73652271040', 1),
('Лоуренс Уоткинс', '+79860890184', 2),
('Найти.', '88003013154', 3);
GO

INSERT INTO warehouses (address, supplies_id) VALUES
('г. СИмферополь, ул. Александра Невского, д. 27', 1),
('г. СИмферополь, пр-кт Кирова, д. 37', 2),
('Найти.', 3);
GO

INSERT INTO products (name, price, category_id, brands_id, supplies_id, warehouses_id) VALUES
('Бредовое расстройство', 899999.0, 1, 1, 1, 1),
('Острое Шизофреническое расстройство', 78999.0, 2, 2, 2, 2),
('Найти', 99999999, 3, 3, 3, 3)
GO

SELECT * FROM categories;
SELECT * FROM brands;
SELECT * FROM supplies;
SELECT * FROM warehouses;
SELECT * FROM products;



