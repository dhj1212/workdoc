@echo off 
echo ɾ��3��ǰ�ı����ļ�����־


set "ymd=%date:~0,4%%date:~5,2%%date:~8,2%"
set "fdir=D:\OraBak\66.106"
forfiles /p "%fdir%" /m *.zip /d -3 /c "cmd /c del @path" 

echo Զ��ɾ��66.106db, 3��ǰ������
set "rfdir=\\10.192.66.211\Public\OraBak\66.106"
set /a PassDays=%ymd%-3
del %rfdir%\sjaeip_%PassDays%.zip

echo ���ڱ��� mysql ���ݿ⣬���Եȡ��� 
mysqldump --opt -h10.192.66.106  -urunkeen -prunkeen123$ sjaeip>%fdir%\sjaeip_%ymd%.sql
"C:\Program Files\7-Zip\7z.exe" a %fdir%\sjaeip_%ymd%.zip %fdir%\sjaeip_%ymd%.sql
del %fdir%\sjaeip_%ymd%.sql

xcopy %fdir%\sjaeip_%ymd%.zip  \\10.192.66.211\Public\OraBak\66.106\ /Y
echo �������!
