--- char(X) указывает конкретное кол-во символов
DECLARE @char char(2) = 'asd';

--nchar N'' это "расширенная версия" и поддерживает все особые языки
DECLARE @nchar nchar(5) = N'?????'

--varchar расширенный char \ обычно без разницы char или varchar \ можно указать просто MAX вместо 5000. работает и в других переменах
DECLARE @vchar varchar(5000) = 'asd123qwe'
-- varchar можно комбинировать с n - nwarchar

-- text Устаревший тип, может уже не работает
--DECLARE @text text = 'qweewq'

-- SELECT * FROM означает "всё в этой директориии"
--SELECT * FROM sys.messages

--SELECT @char as Symbols

PRINT @char