@echo off 
echo 删除3天前的备分文件和日志

set "ymd=%date:~0,4%%date:~5,2%%date:~8,2%"
set "fdir=D:\OraBak\66.18"

forfiles /p "%fdir%" /m *.zip /d -3 /c "cmd /c del @path" 
forfiles /p "%fdir%" /m *.log /d -3 /c "cmd /c del @path"

echo 远程删除66.18db, 3天前的数据
set "rfdir=\\10.192.66.211\Public\OraBak\66.18"
set /a PassDays=%ymd%-3
del %rfdir%\sis_%PassDays%.zip

echo 正在备份 Oracle 数据库，请稍等…… 
C:\oracle10g\BIN\exp sis/sis@10.192.66.18/sis file=%fdir%/sis_%ymd%.dmp log=%fdir%/sis_%ymd%.log owner=(sis,dnlms,reap,SIS_HIS_PERFEVAL)

"C:\Program Files\7-Zip\7z.exe" a %fdir%\sis_%ymd%.zip %fdir%\sis_%ymd%.dmp

del %fdir%\sis_%ymd%.dmp

xcopy %fdir%\sis_%ymd%.zip  \\10.192.66.211\Public\OraBak\66.18\ /Y
echo 任务完成!
