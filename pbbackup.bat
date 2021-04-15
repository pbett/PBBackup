@echo off
REM PB Backup script - windows batch script.
REM 
REM Put this in the Send To folder:
REM %AppData%\Microsoft\Windows\SendTo
REM Then run from Explorer by right-clicking and selecting the script in the Send To menu.
REM
REM Filename is first argument %1  
REM Could have other arguments %2, ...


REM %DATE% gives the date in dd/mm/yyyy format (according to the locale settings)
REM %DATE:~a,b% gives the substring from char a with length b.
REM set BUSTR=_BU%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2%-%TIME:~0,2%%TIME:~3,2%
rem echo %BUSTR%
REM e.g. _BU20210410-1059
REM But we can end up with spaces instead of leading zeros...
REM 
REM Alternatively, this method is more general.
REM The 'wmic OS Get localdatetime' commend gives output like
REM    20210415093056.256000+060
REM which we parse into the required components:
for /f "delims=" %%a in ('wmic OS Get localdatetime  ^| find "."') do set dt=%%a
set YYYY=%dt:~0,4%
set MM=%dt:~4,2%
set DD=%dt:~6,2%
set HH=%dt:~8,2%
set Min=%dt:~10,2%
set Sec=%dt:~12,2%
REM echo %YYYY% %MM% %DD% %HH% %Min% %Sec%
set BUSTR=_BU%YYYY%-%MM%-%DD%-%HH%%Min%

rem Pick bits of the filename in %1
rem echo %~n1    file without extension
rem echo %~x1    extension
rem echo %~dpnx1 full filename with path and extension
rem echo %~dpn1  full filename with path without extension
rem set BUFILE=%~n1%BUSTR%%~x1 
set BUFILE=%~dpn1%BUSTR%%~x1 
rem echo %BUFILE%
copy  %1  "%BUFILE%"
