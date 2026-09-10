USE DB1
go

CREATE SCHEMA departament
go

CREATE SCHEMA customerw
go

CREATE SCHEMA person
go

CREATE TABLE departament.usersForSchemas(id int, name char(20))
--CREATE TABLE customerw.users2ForSchemas2(id int, name char(20))
CREATE TABLE person.users3ForSchemas3(id int, name char(20))

ALTER SCHEMA costumerw
TRANSFER departament.person