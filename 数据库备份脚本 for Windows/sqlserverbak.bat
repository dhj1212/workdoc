EXEC sp_configure 'show advanced options', 1
GO
-- To update the currently configured value for advanced options.
RECONFIGURE
GO
-- To enable the feature.
EXEC sp_configure 'xp_cmdshell', 1
GO
-- To update the currently configured value for this feature.
RECONFIGURE
GO
-- To disallow advanced options to be changed.
EXEC sp_configure 'show advanced options', 0
GO
-- To update the currently configured value for advanced options.
RECONFIGURE
GO

--------------------------------------------------------------------------------------------------------------------------------
exec xp_cmdshell 'net use Y: \\10.192.66.113\OraBak 6376 /User:10.192.66.113\Administrator'
exec xp_cmdshell 'net use Z: \\10.192.66.211\Public\OraBak'
DECLARE @strPath NVARCHAR(200)
DECLARE @otherstrPath NVARCHAR(200)
DECLARE @xpcmds NVARCHAR(500)
DECLARE @xpcmdd NVARCHAR(500)
DECLARE @rdell211 NVARCHAR(500)
DECLARE @rxcopy NVARCHAR(500)
DECLARE @rdell113 NVARCHAR(500)

set @strPath = convert(NVARCHAR(10),getdate(),120)
set @strPath = REPLACE(@strPath, '-' , '')
set @otherstrPath = REPLACE(@strPath, '-' , '')
set @strPath = 'Z:\66.48\BudgetSA_' + @strPath + '.bak'
set @xpcmds= 'D:\WinRAR\WinRAR.exe A -R Z:\66.48\BudgetSA_' + @otherstrPath + '.zip Z:\66.48\BudgetSA_' + @otherstrPath + '.bak'
set @rxcopy='xcopy Z:\66.48\BudgetSA_' + @otherstrPath + '.zip  Y:\66.48 /Y'
set @xpcmdd='del Z:\66.48\BudgetSA_' + @otherstrPath + '.bak'
set @rdell211='forfiles /p "Z:\66.48" /m *.zip /d -3 /c "cmd /c del @path"'
set @rdell113='forfiles /p "Y:\66.48" /m *.zip /d -3 /c "cmd /c del @path" '

BACKUP DATABASE [BudgetSA] TO DISK = @strPath WITH NOINIT , NOUNLOAD , NOSKIP , STATS = 10, NOFORMAT

EXEC xp_cmdshell  @xpcmds
EXEC xp_cmdshell  @rxcopy
EXEC xp_cmdshell  @xpcmdd
EXEC xp_cmdshell  @rdell211
EXEC xp_cmdshell  @rdell113

--exec xp_cmdshell 'net use Z: /del'
--exec xp_cmdshell 'net use Y: /del'
--------------------------------------------------------------------------------------------------------------------------------


EXEC sp_configure 'show advanced options', 1
GO
-- To update the currently configured value for advanced options.
RECONFIGURE
GO
-- To disable the feature.
EXEC sp_configure 'xp_cmdshell', 0
GO
-- To update the currently configured value for this feature.
RECONFIGURE
GO
-- To disallow advanced options to be changed.
EXEC sp_configure 'show advanced options', 0
GO
-- To update the currently configured value for advanced options.
RECONFIGURE
GO