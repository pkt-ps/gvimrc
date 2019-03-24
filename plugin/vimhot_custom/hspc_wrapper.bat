@echo off
echo %1

setlocal enabledelayedexpansion

set ARR_0=%1\main.hsp
set ARR_1=%1\..\main.hsp
set ARR_2=%1\..\..\main.hsp
set ARR_3=%1\..\..\..\main.hsp
set ARR_4=%1\..\..\..\..\main.hsp
set ARR_5=%1\..\..\..\..\..\main.hsp

set i=0
:BEGIN
call set it=%%ARR_!i!%%
if defined it (
  REM echo !it!
  if exist !it! (
    echo detect:!it!
	call :COMPILE !it!
    REM exit
	pause
  )
  set /A i+=1
  goto :BEGIN
)
echo "not found main.hsp"
exit

:COMPILE
echo %1
echo %~dp1
cd %~dp1
echo on
hspc -vdwriC %1
exit

