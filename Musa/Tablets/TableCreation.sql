USE DB2

--CREATE TABLE users(
--	id int,
--	first_name nchar(20),
--	age tinyint,
--	balance real
--);

--CREATE TABLE users2(
----- IDENTITY - аналог autoincrement \ можно указать аргумент (X, Y) - (с начать с 10, шаг 2) т.е. начнётся с числа 10 и будет увеличиваться на 2 > 12 > 14...
--	id int primary key identity,
----- primary key - ключ дающий владельцу доступ к связанной информации из других источников\таблиц
---- например у Goro ключ "1" и он может взять пароль из столбца "1" в соседней таблице

--	first_name nchar(20) not null,
--	email varchar(20) unique,
--	age tinyint,
--	balance real
--);

CREATE TABLE userw(
	id int,
	first_name nchar(20),
	age tinyint,
	balance real
);