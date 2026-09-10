DECLARE @DT datetime = GetDate()
DECLARE @D date = '2000-11-04'
DECLARE @T time(0) = GetDate()

DECLARE @DT2 datetime2 = SysDateTime()
DECLARE @DT0 datetimeoffset = '2020-11-12'

SET DATEFORMAT mdy;
SELECT @DTO
go
SET DATEFORMAT dmy;
SELECT @DTO