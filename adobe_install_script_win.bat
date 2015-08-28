@echo off
rem Set up the Windows path so that WinRAR can be run more easily from a script
rem then extract the adobe installer from the zip.

if not exist "C:\Program Files\WinRAR\winrar.exe" (
	echo You need to have WinRAR installed to run this install script.
	pause
	exit
) else (echo WinRAR is installed.)

cd .

rem unzip files.
"C:\Program Files\WinRAR\winrar.exe" x win_cc*.zip .
"C:\Program Files\WinRAR\winrar.exe" x cc20*win.zip .

rem Install Adobe.
cd win_cc*
.\Exceptions\ExceptionDeployer.exe --workflow=install --mode=pre
cd Build
setup.exe
cd..
.\Exceptions\ExceptionDeployer.exe --workflow=install --mode=post
cd ..
.\cc*serializ*\win\adobe_prtk.exe --tool=VolumeSerialize --provfile=.\cc*serializ*\win\prov_win.xml

echo Modifying registry...
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Adobe\Adobe Acrobat\DC\FeatureLockDown\cServices /v bToggleAdobeDocumentServices" /t REG_DWORD /d 00000001 /f

echo DONE!
pause