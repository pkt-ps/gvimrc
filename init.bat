@echo off

cd %~dp0
rem 差分が発生して面倒くさいので廃止
rem copy .\_gvimrc %userprofile%\_gvimrc /Y 

rem シンボリックリンクだとダメ(mklinkで作るっぽい？)
rem mklink %userprofile%\_gvimrc .\_gvimrc

rem ハードリンクする
del %userprofile%\_gvimrc
fsutil hardlink create %userprofile%\_gvimrc .\_gvimrc

rem プラグインのcloneとか配置とか
call plugin_init.bat

pause
