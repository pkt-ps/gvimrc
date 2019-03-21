@echo off
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
    REM echo detect
	echo !it!
    hspc -dwrCi !it!
    exit
  )
  set /A i+=1
  goto :BEGIN
)
 echo "not found main.hsp"
 exit

