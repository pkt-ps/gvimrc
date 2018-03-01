﻿" フォントサイズ
if has('win32')
  " Windows用
  set guifont=MS_Gothic:h9:cSHIFTJIS
  "set guifont=Consolas:h10,Lucida_Console:h10:w5 guifontwide=MS_Gothic:h10
  " 行間隔の設定
  set linespace=1
  " 一部のUCS文字の幅を自動計測して決める
  if has('kaoriya')
    set ambiwidth=auto
  endif
elseif has('mac')
  set guifont=Osaka－等幅:h14
elseif has('xfontset')
  " UNIX用 (xfontsetを使用)
  set guifontset=a14,r14,k14
endi

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

" 個別のタブの表示設定をします
function! GuiTabLabel()
  " タブで表示する文字列の初期化をします
  let l:label = ''

  " タブに含まれるバッファ(ウィンドウ)についての情報をとっておきます。
  let l:bufnrlist = tabpagebuflist(v:lnum)

  " 表示文字列にバッファ名を追加します
  " パスを全部表示させると長いのでファイル名だけを使います 詳しくは help fnamemodify()
  let l:bufname = fnamemodify(bufname(l:bufnrlist[tabpagewinnr(v:lnum) - 1]), ':t')
  " バッファ名がなければ No title としておきます。ここではマルチバイト文字を使わないほうが無難です
  let l:label .= l:bufname == '' ? 'No title' : l:bufname

  " タブ内にウィンドウが複数あるときにはその数を追加します(デフォルトで一応あるので)
  let l:wincount = tabpagewinnr(v:lnum, '$')
  if l:wincount > 1
    let l:label .= '[' . l:wincount . ']'
  endif

  " このタブページに変更のあるバッファがるときには '[+]' を追加します(デフォルトで一応あるので)
  for bufnr in l:bufnrlist
    if getbufvar(bufnr, "&modified")
      let l:label .= '[+]'
      break
    endif
  endfor

  " 表示文字列を返します
  return l:label
endfunction

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
" タブにフルパスでなく、ファイル名のみを表示する                                
set tabline=%N:\ %{GuiTabLabel()}
set guitablabel=%N:\ %{GuiTabLabel()}
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
nnoremap so :OpenNAlter<CR>
nnoremap se :!start .<CR>
nnoremap <ESC><ESC> :noh<CR>
nnoremap <C-o><C-o> <ESC>a<C-r>=strftime("%Y-%m-%d %H:%M:%S")<CR><ESC>
nnoremap /  /\v

" Unite
let g:unite_source_history_yank_enable =1  "history/yankの有効化
noremap sy :Unite history/yank<CR>
noremap sf :Unite -buffer-name=file file<CR>
noremap sr :Unite file_mru<CR> 

"-----------------------------------------------
" カスタムコマンド.
"----------------------------------------------
command! Cpp :set filetype=cpp
command! Ruby :set filetype=ruby
command! Java :set filetype=java
command! Python :set filetype=python
command! Openrc :tabe ~/_gvimrc
command! Refleshrc :source ~/_gvimrc
command! Openbin :%!xxd
command! Revertbin :%!xxd -r

"-----------------------------------------------
" プラグイン.
"----------------------------------------------
" vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
call indent_guides#enable()

" NERDTree
" 隠しファイルを表示する
let NERDTreeShowHidden = 1
function! NERDTreeToggleCustom()
	CdCurrent
	NERDTreeToggle
endfunction
nnoremap <silent><C-e> :call NERDTreeToggleCustom()<CR>
" デフォルトでツリーを表示させる
"if argc() == 0
"	let g:nerdtree_tabs_open_on_console_startup = 1
"end
"参考
"set number
"function Setnumber()
"  if &number
"    setlocal nonumber
"  else
"    setlocal number
"  endif
"endfunction
"nnoremap <silent> <C-m> :call Setnumber()<CR>

" 他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
autocmd BufEnter * lcd %:p:h

