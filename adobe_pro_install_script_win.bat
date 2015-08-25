rem Set up the Windows path so that WinRAR can be run more easily from a script
rem then extract the adobe installer from the zip.

setx path "%path%;C:\Program Files\WinRAR"
winrar x cc_win_Acrobat_x64_2014-09.zip .

rem Install Adobe Pro.
cd cc_win_Acrobat_x64*
.\Exceptions\ExceptionDeployer.exe --workflow=install --mode=pre
cd Build
setup.exe
cd..
.\Exceptions\ExceptionDeployer.exe --workflow=install --mode=post
cd ..
.\cc_serialize2014\win\adobe_prtk.exe --tool=VolumeSerialize --provfile=.\cc_serialize2014\win\prov_win.xml

echo DONE!
pause