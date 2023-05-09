select *
from dbo.DateDimension
where TheDate='2022-11-10'


CREATE UNIQUE CLUSTERED INDEX PK_DateDimension ON dbo.DateDimension(TheDate);



select *
from ProcessData




Create Table RefNSEHoliday
(
    HolidayDate VARCHAR(50),
    HolidayDay VARCHAR(50),
    HolidayDesc VARCHAR(50)
)
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('26-Jan-2022', 'Wednesday', 'Republic Day');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('01-Mar-2022', 'Tuesday', 'Mahashivratri');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('18-Mar-2022', 'Friday', 'Holi');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('10-Apr-2022', 'Sunday', 'Ram Navami');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('14-Apr-2022', 'Thursday', 'Dr.Baba Saheb Ambedkar Jayanti/Mahavir Jayanti');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('15-Apr-2022', 'Friday', 'Good Friday');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('01-May-2022', 'Sunday', 'Maharashtra Day');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('03-May-2022', 'Tuesday', 'Id-Ul-Fitr (Ramzan ID)');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('10-Jul-2022', 'Sunday', 'Bakri Id');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('09-Aug-2022', 'Tuesday', 'Moharram');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('15-Aug-2022', 'Monday', 'Independence Day');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('31-Aug-2022', 'Wednesday', 'Ganesh Chaturthi');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('02-Oct-2022', 'Sunday', 'Mahatma Gandhi Jayanti');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('05-Oct-2022', 'Wednesday', 'Dussehra');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('26-Oct-2022', 'Wednesday', 'Diwali-Balipratipada');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('08-Nov-2022', 'Tuesday', 'Gurunanak Jayanti');
insert into RefNseHoliday
    (HolidayDate,HolidayDay,HolidayDesc)
values('25-Dec-2022', 'Sunday', 'Christmas');



select *
from RefNseHoliday


select convert(varchar(50), HolidayDay,  13),
    format(HolidayDay, 'dd-MMM-yyyy')
from RefNseHoliday
select CONVERT(VARCHAR(11),REPLACE(CONVERT(VARCHAR(11),HolidayDay, 106), ' ', '-'))
from RefNseHoliday


SELECT cast(HolidayDate as date)

from RefNseHoliday

select cast('12-Jan-2019' as date)

select *
from ProcessData

drop table TaskData
Create table TaskData
(
    TAKSK_ID uniqueidentifier NOT NULL DEFAULT NEWID() ROWGUIDCOL ,
    TASK_NAME varchar(50),
    FILE_DATE VARCHAR(50),
    TASK_STATUS VARCHAR(50),
    ROW_INS_TMS date,
    ROW_UPD_TMS date
)
delete from TaskData
insert into TaskData
    (TASK_NAME,FILE_DATE,TASK_STATUS,ROW_INS_TMS)
SELECT 'DailyActivity' as TASK_NAME , case when TheDayOfWeek=6 then DATEADD(day,3,TheDate)
when nh.HolidayDate is not null then DATEADD(day,2,TheDate)
 else DATEADD(day,1,TheDate) end as FILE_DATE, 'STARTED', Getdate() as ROW_INS_TMS
FROM DateDimension  dd
    left outer join RefNseHoliday nh
    ON dd.TheDate=coalesce(DATEADD(day,-1,cast(nh.HolidayDate as date)),'2022-11-03')
WHERE TheDate=(Select coalesce(max(FILE_DATE),'2022-11-03')
    from TaskData)
    and TheDayOfWeek not in (1,7)


 select * from TaskData
delete from TaskData where TASK_STATUS='STARTED'
update TaskData
set
ROW_UPD_TMS=GETDATE(),
TASK_STATUS='FAILED'
where TASK_STATUS='STARTED'


SELECT CONCAT(Task_Name,'_',replace(FILE_DATE,'-','_'),'.csv') as FileName,
    RIGHT(concat(0,DAY(FILE_DATE)),2) AS day,
    RIGHT(concat(0,month(FILE_DATE)),2) AS month,
    year(FILE_DATE) as year
from TaskData
where TASK_STATUS='STARTED'

select year(FILE_DATE)
from TaskData
where TASK_STATUS='STARTED'

select CONCAT(Task_Name,'_',replace(FILE_DATE,'-','_'),'.csv')
select * from Ref_Process_Information

drop table PARAM_INFO;
CREATE TABLE PARAM_INFO
(

    PARAM_ID INTEGER,
    PARAM_NAME VARCHAR(50),
    PARAM_VALUE VARCHAR(50)
)

INSERT INTO PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES (1,'PROCESS_NAME','Activity');
INSERT INTO PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES (1,'CONTAINER_NAME','stockdata');
INSERT INTO PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES (1,'DIRECTORY_NAME','DailyActivity');
INSERT INTO PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES (1,'FUNCTION_NAME','GetDailyActivityStockData');
insert into PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES(1,'SCHEMA_NAME','dbo');
insert into PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES(1,'TABLE_NAME','ActivityData');

INSERT INTO PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES (2,'PROCESS_NAME','Price');
INSERT INTO PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES (2,'CONTAINER_NAME','stockdata');
INSERT INTO PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES (2,'DIRECTORY_NAME','DailyPriceList');
INSERT INTO PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES (2,'FUNCTION_NAME','GetDailyPriceList');
insert into PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES(2,'SCHEMA_NAME','dbo');
insert into PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES(2,'TABLE_NAME','DailyPrice');

INSERT INTO PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES (3,'PROCESS_NAME','Nifty');
INSERT INTO PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES (3,'CONTAINER_NAME','stockdata');
INSERT INTO PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES (3,'DIRECTORY_NAME','Nifty');
INSERT INTO PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES (3,'FUNCTION_NAME','GetNifty50');
insert into PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES(3,'SCHEMA_NAME','dbo');
insert into PARAM_INFO (PARAM_ID,PARAM_NAME,PARAM_VALUE) VALUES(3,'TABLE_NAME','Nifty_Details');



from PARAM_INFO
) as SOURCETABLE
PIVOT
(
    MAX(PARAM_VALUE)
     FOR [PARAM_NAME] IN ([PROCESS_NAME],[CONTAINER_NAME],[DIRECTORY_NAME],[FUNCTION_NAME])
) AS PT
where PT.PARAM_ID=1


@activity('ReadParamFromDB').output.resultSets[0].rows[0].PROCESS_NAME
@activity('ReadParamFromDB').output.resultSets[0].rows[0].DIRECTORY_NAME
@activity('ReadParamFromDB').output.resultSets[0].rows[0].TABLE_NAME
@activity('ReadParamFromDB').output.resultSets[0].rows[0].SCHEMA_NAME