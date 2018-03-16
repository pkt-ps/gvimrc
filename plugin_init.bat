cd /d %~dp0

mkdir .\vimfiles
cd .\vimfiles

mkdir .\pack\my\start
mkdir .\pack\my\opt
mkdir .\colors

rem Color Scheme
git clone https://github.com/tomasr/molokai.git
move .\molokai\colors\molokai.vim .\colors\molokai.vim
rmdir .\molokai /S /Q

rem Plugin
cd /d .\pack\my\start
git clone https://github.com/scrooloose/nerdtree.git

pause
