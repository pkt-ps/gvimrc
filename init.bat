cd /d %userprofile%
mkdir .\vimfiles
mkdir .\vimfiles\pack
mkdir .\vimfiles\pack\colors
mkdir .\vimfiles\pack\my
mkdir .\vimfiles\pack\my\opt
mkdir .\vimfiles\pack\my\start
cd /d %userprofile%\vimfiles
git clone https://github.com/tomasr/molokai.git
move .\molokai\colors .\colors
cd /d %userprofile%\vimfiles\pack\my\start
REM git clone https://github.com/scrooloose/nerdtree.git
REM git clone https://github.com/jistr/vim-nerdtree-tabs.git
REM git clone https://github.com/nathanaelkane/vim-indent-guides.git
REM git clone https://github.com/thinca/vim-singleton.git
git clone https://github.com/itchyny/vim-highlighturl.git

pause
