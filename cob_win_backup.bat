@echo off &setlocal
REM This script is nowhere near finished. Run at your own peril.


REM Set vars here:
REM The 1%VAR%-100 is to prevent error when a month/day has a leading 0.

:set /a year = %DATE:~10,10%
:set /a month = 1%DATE:~4,2%-100
:set /a day = 1%DATE:~7,2%-100


echo Begin backup.

REM Possibly find a better way to store exception files/folders
:robocopy %USERPROFILE% D:\%year%.%month%.%day%_%USERNAME% /S /COPYALL /DCOPY:DAT /XF ntuser.dat* /XD "Application Data" AppData "Local Settings" /R:25 /W:10

D:

set /a count = 0
for /d %%i in (*.*) do set /a count+=1
echo %count%

if %count% GTR 5 (
	echo "Pruning old backups..."

	for /d %%i in (*.*) do (
		set fold_date = %%i
		echo %fold_date%
	)
)
