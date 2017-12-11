cd /d %userprofile%
rmdir /S /Q .\vimfiles
mkdir .\vimfiles
mkdir .\vimfiles\pack
mkdir .\vimfiles\pack\colors
mkdir .\vimfiles\pack\my
mkdir .\vimfiles\pack\my\opt
mkdir .\vimfiles\pack\my\start

rem --------------------------------------------
rem Color Scheme
rem --------------------------------------------
cd /d %userprofile%\vimfiles
git clone https://github.com/tomasr/molokai.git
move .\molokai\colors\molokai.vim .\colors
git clone https://github.com/vim-scripts/hybrid.vim.git
move .\hybrid.vim\colors\hybrid.vim .\colors

rem --------------------------------------------
rem Syntax
rem --------------------------------------------
cd /d %userprofile%\vimfiles\pack\my\start

rem --------------------------------------------
rem Plugin
rem --------------------------------------------
cd /d %userprofile%\vimfiles\pack\my\start
git clone https://github.com/scrooloose/nerdtree.git
rem git clone https://github.com/jistr/vim-nerdtree-tabs.git
git clone https://github.com/nathanaelkane/vim-indent-guides.git
git clone https://github.com/thinca/vim-singleton.git
git clone https://github.com/itchyny/vim-highlighturl.git
git clone https://github.com/mopp/next-alter.vim

rem --------------------------------------------
rem Plugin Unite
rem --------------------------------------------
git clone https://github.com/Shougo/unite.vim.git
git clone https://github.com/Shougo/neomru.vim.git
git clone https://github.com/Shougo/neoyank.vim.git
