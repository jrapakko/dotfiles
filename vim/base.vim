" UI
"
"" Color Scheme
colorscheme Obsidian

" scroll by 7
set so=7

" english pl0x
let $LANG='en'
set langmenu=en

"position pl0x
set ruler
set rulerformat=%25(%n%m%r:\ %Y\ [%l,%v]\ %p%%%)

" line nums!
set number

" comand bar height
set cmdheight=2

" Abandoned buffer hidden
set hid

" Yay backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" try to say in same place on line
set nostartofline

" case-insensitive searching
set ignorecase

" smart about case when searching?
set smartcase

" highlight search results
set hlsearch

" search like highlights words
set incsearch

" Don't redraw while executing macros
set lazyredraw

" REGEX! wooooooo
set magic

" Show mataching brackets
set showmatch
" tenths of sec blink bracket match
set mat=2

" Sounds hurt ears
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" more left margin
set foldcolumn=1

" Syntax highlighting
syntax enable

" encoding
set encoding=utf8

" Unix file type
set ffs=unix,dos,mac

" Backup off (never used it)
set nobackup

set nospell " off by DEFAULTS

set isk+=_,$,@,%,#,-

set grepprg=ack
set grepformat=%f:%l:%m

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ----- Tab, Space Behavior
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Spaces ftw

set expandtab
set smarttab

set shiftwidth=2
set tabstop=2
set softtabstop=2
set listchars=tab:▸\ ,eol:¶,trail:•,nbsp:•

" Linebreaks at 150 ch
set lbr
set tw=150

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

set nosmarttab
set formatoptions+=n
set virtualedit=block

set complete=.,t
set showcmd
set showmode
set list

set history=50

syntax on
:syntax on

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ----- Buffer Behavior
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2  " always show tab line
endtry

" Return to last edit position when opening files
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") < line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Remeber info about open buffers on close
set viminfo^=%

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ----- Status Line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ----- Persistent Undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
  set undodir=~/.vim/tmp/undodir
  set undofile
catch
endtry
