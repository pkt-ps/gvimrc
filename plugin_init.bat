cd /d %userprofile%
rmdir /S /Q .\vimfiles
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
git clone https://github.com/scrooloose/nerdtree.git
rem git clone https://github.com/jistr/vim-nerdtree-tabs.git
git clone https://github.com/nathanaelkane/vim-indent-guides.git
git clone https://github.com/thinca/vim-singleton.git
git clone https://github.com/itchyny/vim-highlighturl.git
git clone https://github.com/mopp/next-alter.vim

REM unite
git clone https://github.com/Shougo/unite.vim.git
git clone https://github.com/Shougo/neomru.vim.git
git clone https://github.com/Shougo/neoyank.vim.git