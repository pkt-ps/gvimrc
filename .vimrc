"Windows対策
set runtimepath+=~/.vim

"　コメントの色を変更.
autocmd ColorScheme * highlight Comment ctermfg=22 guifg=#00b500 guibg=#300060
" カラースキーム
colorscheme molokai
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""

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
" Git for Windows
set grepprg=grep\ -n
let $PATH .= ';C:\Program Files\Git\usr\bin'
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
" Windowsキーバインド
"source $VIMRUNTIME/mswin.vim
" Windowsキーバインドをやめて、コピー先レジスタを無名レジスタにする.
set clipboard=unnamed,autoselect
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
" これで補完が自動で出るらしい
"set completeopt=menuone
"for k in split("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_",'\zs')
"  exec "imap <expr> " . k . " pumvisible() ? '" . k . "' : '" . k . "\<C-X>\<C-P>\<C-N>'"
"endfor
" ビープ音削除
set visualbell t_vb=
" 折り返しなし
set nowrap
" カレントディレクトリ同期
set autochdir
set ignorecase

"-----------------------------------------------
" キーマップ.
"----------------------------------------------
" X削除でヤンクしない.
nnoremap x "_x
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap s <Nop>
nnoremap sx :tabclose<CR>
nnoremap sn gt<CR>
nnoremap sp gT<CR>
nnoremap sr :bro ol<CR>
nnoremap se :!start .<CR>
nnoremap <ESC><ESC> :noh<CR>
nnoremap <C-o><C-o> <ESC>a<C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR><ESC>
nnoremap /  /\v
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

"-----------------------------------------------
" カスタムコマンド.
"----------------------------------------------
command! Cpp :set filetype=cpp
command! Ruby :set filetype=ruby
command! Java :set filetype=java
command! Python :set filetype=python
command! Openrc :tabe ~/.vimrc
command! Refleshrc :source ~/_gvimrc
command! -nargs=0 CdCurrent cd %:p:h

"-----------------------------------------------
" プラグイン.
"----------------------------------------------
" NERDTree
" 隠しファイルを表示する
let NERDTreeShowHidden = 1
function! NERDTreeToggleCustom()
	CdCurrent
	NERDTreeToggle
endfunction
nnoremap <silent><C-e> :call NERDTreeToggleCustom()<CR>

autocmd BufEnter * lcd %:p:h

