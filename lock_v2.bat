REM version 2 uses 7z utility and AES encryption
REM reliance on 7z cli utility

@echo off
cls
set passw=borgir
title Folder Private
if EXIST Locked.7z goto UNLOCK
if NOT EXIST Private goto MDLOCKER

:CONFIRM
echo Are you sure you want to lock the folder(Y/N)
set/p "cho=>"
if %cho%==Y goto LOCK
if %cho%==y goto LOCK
if %cho%==n goto END
if %cho%==N goto END
echo Invalid choice.
goto CONFIRM

:LOCK
7z a -p%passw% -mhe=on Locked.7z Private > nul
attrib +h +s Locked.7z > nul
rmdir /Q /S "Private" > nul
echo Folder has been locked
goto End

:UNLOCK
echo Enter password to unlock folder
set/p "pass=>"
IF NOT "%pass%"=="%passw%" goto FAIL 
rmdir /Q /S "Private" > nul
7z x -p%pass% Locked.7z > nul
attrib -h -s Locked.7z > nul
del /f Locked.7z > nul
echo Folder Unlocked successfully
goto End 

:FAIL
echo Invalid password
goto end

:MDLOCKER
md Private
echo Private created successfully
goto End

:End
pause