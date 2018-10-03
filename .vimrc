"Windows対策
set runtimepath+=~/.vim

"------------------------------------
" Dein Setup
"------------------------------------
if &compatible
  set nocompatible
endif

"dein.vimディレクトリをruntimepathに追加する
set runtimepath+=~/.vim/bundles/repos/github.com/Shougo/dein.vim

"以下定型文
if dein#load_state("~/.vim/bundles")
	call dein#begin("~/.vim/bundles")
		" プラグイン
		call dein#add("~/.vim/bundles/repos/github.com/Shougo/dein.vim")

		call dein#add('vim-airline/vim-airline')
		call dein#add('scrooloose/nerdtree')
		call dein#add('tomasr/molokai')
		"call dein#add('justmao945/vim-clang')
		call dein#add('Shougo/vimproc.vim', {'build': 'make'})
		call dein#add('Shougo/neocomplete.vim')
		call dein#add('Shougo/neosnippet.vim')
		call dein#add('Shougo/neosnippet-snippets')
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
autocmd ColorScheme * highlight Comment ctermfg=22 guifg=#00b500 guibg=#300060
" カラースキーム
colorscheme molokai

" pluginで
" https://sites.google.com/site/fudist/Home/vim-nihongo-ban/-vimrc-sample
""""""""""""""""""""""""""""""
" 挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
"let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'
"
"if has('syntax')
"  augroup InsertHook
"    autocmd!
"    autocmd InsertEnter * call s:StatusLine('Enter')
"    autocmd InsertLeave * call s:StatusLine('Leave')
"  augroup END
"endif
"
"let s:slhlcmd = ''
"function! s:StatusLine(mode)
"  if a:mode == 'Enter'
"    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
"    silent exec g:hi_insert
"  else
"    highlight clear StatusLine
"    silent exec s:slhlcmd
"  endif
"endfunction
"
"function! s:GetHighlight(hi)
"  redir => hl
"  exec 'highlight '.a:hi
"  redir END
"  let hl = substitute(hl, '[\r\n]', '', 'g')
"  let hl = substitute(hl, 'xxx', '', '')
"  return hl
"endfunction
"""""""""""""""""""""""""""""""

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
" ビープ音削除
set visualbell t_vb=
" 折り返しなし
set nowrap
" カレントディレクトリ同期
set autochdir
autocmd BufEnter * lcd %:p:h
command! -nargs=0 CdCurrent cd %:p:h
" 大文字小文字無視
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
nnoremap <C-n> gt<CR>
nnoremap <C-p> gT<CR>
nnoremap sr :bro ol<CR>
nnoremap se :!start .<CR>
nnoremap <ESC><ESC> :noh<CR>
nnoremap <C-o><C-o> <ESC>a<C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR><ESC>
nnoremap /  /\v
nnoremap st :tabe<CR>
nnoremap <C-t> :tabe<CR>

"-----------------------------------------------
" カスタムコマンド.
"----------------------------------------------
command! Cpp :set filetype=cpp
command! Ruby :set filetype=ruby
command! Java :set filetype=java
command! Python :set filetype=python
"command! Openrc :tabe ~/.vimrc   つい書き換えてしまうのでこれは消す
command! Refleshrc :source ~/_gvimrc

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

" NeoComplete
"起動時に有効
let g:neocomplete#enable_at_startup = 1
" ポップアップメニューで表示される候補の数
let g:neocomplete#max_list = 50
"キーワードの長さ、デフォルトで80
let g:neocomplete#max_keyword_width = 80
let g:neocomplete#enable_ignore_case = 1
highlight Pmenu ctermbg=6
highlight PmenuSel ctermbg=3
highlight PMenuSbar ctermbg=0
inoremap <expr><CR>  pumvisible() ? neocomplete#close_popup() : "<CR>"

" NeoSnippet
imap <expr><CR> neosnippet#expandable() ? "\<Plug>(neosnippet_expand)" : "\<CR>"

imap  <expr><TAB>
    \ pumvisible() ? "\<C-n>" :
    \ neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
 
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
