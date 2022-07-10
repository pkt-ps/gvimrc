"Windows対策
set runtimepath+=~/.vim
set packpath^=~/.vim

"------------------------------------
" Dein Setup
"------------------------------------
if &compatible
  set nocompatible
endif

"dein.vimディレクトリをruntimepathに追加する
set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim
if dein#load_state("~/.vim/bundles")
	call dein#begin("~/.vim/bundles")
		call dein#load_toml("~/.vim/toml/plugin.toml", {'lazy': 0})
		call dein#load_toml("~/.vim/toml/plugin_lazy.toml", {'lazy': 1})
	call dein#end()
	call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
"------------------------------------
"------------------------------------

"　コメントの色を変更.
autocmd ColorScheme * highlight Comment ctermfg=40 guifg=#00b500 guibg=#300060
" カラースキーム
colorscheme molokai

"-----------------------------------------------
" パラメータ.
"----------------------------------------------
set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

" これをしないとencoding=utf-8にした場合にメニュー等々が文字化けする.
source $VIMRUNTIME/delmenu.vim
set langmenu=ja_jp.utf-8
source $VIMRUNTIME/menu.vim
"format
 set fencs=utf-8,sjis,cp932,euc-jp,iso-2022-jp,ucs-bom,ucs-2le,ucs-2
 set fileformats=unix,dos,mac
"不可視文字表示.
set list
set listchars=tab:>.,trail:_,extends:>,precedes:<,nbsp:%
"タブ設定"
set showtabline=2
"行番号表示"
set number
"インクリメンタル検索
set incsearch
set wildmenu wildmode=list:full
" シンタックスハイライト
syntax on
" カーソルライン
"set cursorline
set nocursorline " 一部のファイルのシンタックスハイライトが聞くとカーソルが重いのでこっちを消す.
"swap ファイルを生成しない
set noswapfile
set noundofile
set nobackup
" タブ幅
set tabstop=4
set shiftwidth=4
" ビープ音削除
set visualbell t_vb=
" 折り返しなし
set nowrap
" 大文字小文字無視
set ignorecase
" backspace
set backspace=indent,eol,start

"-----------------------------------------------
" キーマップ.
"----------------------------------------------
" X削除でレジスタを侵食しない.
nnoremap x "_x
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap s <Nop>
nnoremap sx :tabclose<CR>
nnoremap sn gt<CR>
nnoremap sp gT<CR>
nnoremap <C-p> :bp<CR>
nnoremap <C-c> :ccl<CR>
nnoremap sr :bro ol<CR>
nnoremap se :!start .<CR>
nnoremap st :tabe<CR>
nnoremap <C-t> :tabe<CR>
"CamelCase to snake_case
nnoremap s_ viw :s/\v([A-Z])/_\L\1/g<CR>:noh<CR>
"snake_case to CamelCase
nnoremap s} viw :s/\v_(.)/\u\1/g<CR>:noh<CR>

nnoremap <expr> gr ':vimgrep ;\<' . expand('<cword>') . '\>; **/* \| cw<CR>'
nnoremap <ESC><ESC> :noh<CR>
"nnoremap <C-o><C-o> <ESC>a<C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR><ESC>
nnoremap /  /\v

"-----------------------------------------------
" カスタムコマンド.
"----------------------------------------------
command! Cpp :set filetype=cpp
command! Ruby :set filetype=ruby
command! Java :set filetype=java
command! Python :set filetype=python
command! -nargs=0 Cur cd %:p:h
command! Snake :s/\v_(.)/\u\1/g
command! Camel :s/\v([A-Z])/_\L\1/g
command! -nargs=0 CdCurrent cd %:p:h
command! CopyFileName :call s:CopyFileName()
function! s:CopyFileName()
  let @* = expand('%:p')
  let @" = expand('%:p')
endfunction

"-----------------------------------------------
" プラグイン.
"----------------------------------------------
" NERDTree
" 隠しファイルを表示する
let NERDTreeShowHidden = 1
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"HSP
autocmd BufRead *.hsp call FileTypeHsp()
function! FileTypeHsp()
  compiler hsp
  set filetype=hsp
endfunction
au QuickfixCmdPost make,grep,grepadd,vimgrep copen
"let $LANG='ja_JP.SJIS'
set shellpipe=2>\&1\|nkf32.exe\ -uw>%s
