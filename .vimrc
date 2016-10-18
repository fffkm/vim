" #####################
" 操作系
" ####################
set nocompatible "vi非互換モード
set whichwrap=b,s,h,l,<,>,[,] "カーソルを行頭，行末で止まらないようにする
"BSで削除できるものを指定する
" indent  : 行頭の空白
" eol     : 改行
" start   : 挿入モード開始位置より手前の文字
set backspace=indent,eol,start

"#######################
" 表示系
"#######################
set number "行番号表示
set showmode "モード表示
set title "編集中のファイル名を表示
set ruler "ルーラーの表示
set showcmd "入力中のコマンドをステータスに表示する
set showmatch "括弧入力時の対応する括弧を表示
set laststatus=2 "ステータスラインを常に表示

"#######################
" プログラミングヘルプ系
"#######################
syntax on "カラー表示
set smartindent "オートインデント
" tab関連
set expandtab "タブの代わりに空白文字挿入
set ts=4 sw=4 sts=0 "タブは半角4文字分のスペース
" ファイルを開いた際に、前回終了時の行で起動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif
" HTML 閉じタグ補完
augroup MyXML
    autocmd!
    autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
    autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
    autocmd Filetype tpl inoremap <buffer> </ </<C-x><C-o>
augroup END
" 各種括弧補完
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>


"#######################
" 検索系
"#######################
set ignorecase "検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set noincsearch "検索文字列入力時に順次対象文字列にヒットさせない
set nohlsearch "検索結果文字列の非ハイライト表示

" クリップボードからペーストする際に自動インデントをOFFにする
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif


"#######################
" PHP
"######################
let g:php_baselib       = 1
let g:php_htmlInStrings = 1
let g:php_noShortTags   = 1
let g:php_sql_query     = 1

"#######################
" DB
"######################
let g:sql_type_default = 'mysql' " MySQLの場合

"#####################
" NeoBundle
"####################
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif
if has('vim_starting')
    if &compatible
    set nocompatible               " Be iMproved
    endif

" Required:
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    endif

" Required:
    call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
    NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!

" 同期処理
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
    \ },
\ }
NeoBundle 'Shougo/neocomplete.vim' " コード補完機能
NeoBundle 'Shougo/neosnippet.vim' " コード補完機能
NeoBundle 'Shougo/neosnippet-snippets' " コード補完機能
NeoBundle 'violetyk/neocomplete-php.vim' " PHPコード補完
NeoBundle 'scrooloose/syntastic.git' " ファイルの構文エラーをチェック
NeoBundle 'scrooloose/nerdtree' " ディレクトリのツリー構造を表示
NeoBundle 'PDV--phpDocumentor-for-Vim' " PHPDoc用のコメントを生成
NeoBundle 'othree/html5.vim' " html5を補完
NeoBundle 'hail2u/vim-css3-syntax' " CSS3を補完
NeoBundle 'mattn/emmet-vim' " emmet
NeoBundle 'jelera/vim-javascript-syntax' " jsのシンタックスを追加
NeoBundle 'jpo/vim-railscasts-theme' " カラースキーマ
NeoBundle 'plasticboy/vim-markdown' " Markdownシンタックスハイライト
NeoBundle 'kannokanno/previm' " Markdownプレビュー
NeoBundle 'tyru/open-browser.vim' " Markdownブラウザオープン
NeoBundle 'dhruvasagar/vim-table-mode' " Markdownテーブルプラグイン

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" ##############################
" キーバインド
" ##############################
nnoremap <silent><C-t> :NERDTreeToggle

" ##############################
" カラースキーマ
" http://cocopon.me/app/vim-color-gallery/index.html?welcome=1
" ###############################
colorscheme RailsCasts

" ##############################
" Markdown オプション
" #############################
let g:vim_markdown_folding_disabled = 1
au BufRead,BufNewFile *.md set filetype=markdown
let g:table_mode_corner="|" 
nnoremap <silent><C-p> :PrevimOpen

" ##############################
" neocomplete オプション
" #############################
"Note: This option must be set in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
"" Disable AutoComplPop.
let g:acp_enableAtStartup = 0

" Use neocomplete.
let g:neocomplete#enable_at_startup = 1

" Use smartcase.
let g:neocomplete#enable_smart_case = 1

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "   "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

"AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"
"
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
""let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" ##############################
" neocomplete-php オプション
" #############################

let g:neocomplete_php_locale = 'ja'

" 起動時にNERDTree
autocmd vimenter * NERDTree
