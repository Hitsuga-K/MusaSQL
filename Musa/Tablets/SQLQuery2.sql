USE BistroTabl
go

CREATE TABLE users (id int, name text) ON быстрые_таблицы

CREATE TABLE products (id int, name text) ON медленные_таблицы 
go

INSERT INTO users(id) VALUES(DATEPART(MINUTE, GETDATE())) go 100

INSERT INTO products(id) VALUES(DATEPART(MINUTE, GETDATE())) go 100