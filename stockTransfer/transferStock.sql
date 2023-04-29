
CREATE PROCEDURE [dbo].[transferStock]
@transferToZone char(2), -- CR/WR/WC/KR
@stockNumberFrom char(11), -- CCCNNNNNNNN
@stockNumberTo char(11), -- CCCNNNNNNNN
@transferDate datetime
AS
BEGIN
-- declare variables
DECLARE @stockFromZone CHAR(2) 
SELECT @stockFromZone = 'CR' -- TODO: Zone code of current database
DECLARE @type CHAR(1)
SELECT @type = 'U' -- TODO: Stock type of current database
-- check if transfer to zone matches either CR/WR/WC/KR/EC/EO/ER/KR/NC/NE/NF/NR/NW/SB/SC/SE/SR/SW
IF (@transferToZone NOT IN ('CR', 'WR', 'WC', 'KR', 'EC', 'EO', 'ER', 'KR', 'NC', 'NE', 'NF', 'NR', 'NW', 'SB', 'SC', 'SE', 'SR', 'SW'))
BEGIN
RAISERROR 20000,'Invalid zone code for Transfer'
RETURN 
END
-- stock from zone cannot be the same as transfer to zone
IF (@stockFromZone = @transferToZone)
BEGIN
RAISERROR 20000,'Cannot transfer to same Zone'
RETURN 
END
-- check if stock number is valid and matches CCCNNNNNNNN
IF (@stockNumberFrom NOT LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]' OR @stockNumberTo NOT LIKE '[A-Z][A-Z][A-Z][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
BEGIN
RAISERROR 20000,'Invalid stock number'
RETURN 
END
-- Check if the stock is in the correct zone
IF NOT EXISTS (SELECT * FROM [dbo].[ZONAL_STOCK_RANGE] WHERE [ZONE_CODE] = @stockFromZone AND [LOWER_RANGE] <= @stockNumberFrom AND [UPPER_RANGE] >= @stockNumberTo)
BEGIN
RAISERROR 20000,'Stock is not in the Current zone'
RETURN 1
END
-- Check if the stock is already transfered
IF EXISTS (SELECT * FROM [dbo].[TRANSFER_STOCK] WHERE [STOCK_FROM_NUMBER] <= @stockNumberFrom AND [STOCK_TO_NUMBER] >= @stockNumberTo)
BEGIN
RAISERROR 20000,'Stock is already transffered - Subset'
RETURN 1
END
-- Check if the stock is superset not superset of already transfered stock
IF EXISTS (SELECT * FROM [dbo].[TRANSFER_STOCK] WHERE [STOCK_FROM_NUMBER] >= @stockNumberFrom AND [STOCK_TO_NUMBER] <= @stockNumberTo)
BEGIN
RAISERROR 20000,'Stock is already transffered - Superset'
RETURN 1
END
-- check if the stock overlaps with already transferred stock
IF EXISTS (SELECT * FROM [dbo].[TRANSFER_STOCK] WHERE ([STOCK_FROM_NUMBER] >= @stockNumberFrom AND [STOCK_FROM_NUMBER] <= @stockNumberTo) OR ([STOCK_TO_NUMBER] >= @stockNumberFrom AND [STOCK_TO_NUMBER] <= @stockNumberTo))
BEGIN
RAISERROR 20000,'Stock is already transffered - Overlap'
RETURN 1
END
-- Insert the stock into the transfer table
-- TODO: Uncomment the below line to insert the stock into the transfer table
-- INSERT INTO [dbo].[TRANSFER_STOCK] ([STOCK_FROM_NUMBER], [STOCK_TO_NUMBER], [STOCK_TYPE], [ZONE_CODE], [TXN_TIME], [STATUS], [LAST_MODIFIED]) VALUES (@stockNumberFrom, @stockNumberTo, @type, @transferToZone, @transferDate, 1, getdate())
PRINT 'Stock transfered successfully '
RETURN 0
END