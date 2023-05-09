CREATE PROCEDURE ld_Stock_Core_Tables
AS
INSERT INTO dbo.Core_ActivityData (
	SYMBOL
	,SERIES
	,STOCK_DATE
	,PREV_CLOSE
	,OPEN_PRICE
	,HIGH_PRICE
	,LOW_PRICE
	,LAST_PRICE
	,CLOSE_PRICE
	,AVG_PRICE
	,TTL_TRD_QNTY
	,TURNOVER_LACS
	,NO_OF_TRADES
	,DELIV_QTY
	,DELIV_PER
	,ROW_INSRT_TMS
	,ROW_UPDT_TMS
	,ROW_INS_USR
	,ROW_UPD_USR
	)
SELECT s.SYMBOL
	,s.SERIES
	,s.DATE
	,s.PREV_CLOSE
	,s.OPEN_PRICE
	,s.HIGH_PRICE
	,s.LOW_PRICE
	,s.LAST_PRICE
	,s.CLOSE_PRICE
	,s.AVG_PRICE
	,s.TTL_TRD_QNTY
	,s.TURNOVER_LACS
	,s.NO_OF_TRADES
	,s.DELIV_QTY
	,s.DELIV_PER
	,getdate()
	,getdate()
	,user
	,user
FROM dbo.STG_ActivityData s
LEFT OUTER JOIN dbo.Core_ActivityData c ON s.DATE = c.STOCK_DATE
	AND s.SYMBOL = c.SYMBOL
WHERE c.STOCK_DATE IS NULL

INSERT INTO dbo.Core_DailyPrice (
	SYMBOL
	,SERIES
	,[OPEN]
	,HIGH
	,LOW
	,[CLOSE]
	,LAST
	,PREVCLOSE
	,TOTTRDQTY
	,TOTTRDVAL
	,STOCK_DATE
	,TOTALTRADES
	,ISIN
	,ROW_INSRT_TMS
	,ROW_UPDT_TMS
	,ROW_INS_USR
	,ROW_UPD_USR
	)
SELECT s.SYMBOL
	,s.SERIES
	,s.[OPEN]
	,s.HIGH
	,s.LOW
	,s.[CLOSE]
	,s.LAST
	,s.PREVCLOSE
	,s.TOTTRDQTY
	,s.TOTTRDVAL
	,s.TIMESTAMP
	,s.TOTALTRADES
	,s.ISIN
	,GETDATE()
	,GETDATE()
	,user
	,user
FROM dbo.Stg_DailyPrice s
LEFT OUTER JOIN dbo.Core_DailyPrice c ON s.TIMESTAMP = c.STOCK_DATE
	AND s.SYMBOL = c.SYMBOL
WHERE c.STOCK_DATE IS NULL GO;
