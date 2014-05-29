" UI

syntax on
set number
set guicursor=a:blinkon0
set visualbell t_vb=
set nospell
set nostartofline
set mouse=a
set backspace=indent,eol,start
set laststatus=2
set ch=2
set ruler
set rulerformat=%25(%n%m%r:\ %Y\ [%l,%v]\ %p%%%)
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1,default
set isk+=_,$,@,%,#,-

set nocompatible
set grepprg=ack
set grepformat=%f:%l:%m

" Text Formatting
set autoindent
set smartindent
set smarttab
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab
set formatoptions+=n
set virtualedit=block

set completeopt=longest,menu
set wildmode=list:longest,list:full
set wildmenu
set complete=.,t
set hidden
set showcmd
set showmode
set ignorecase
set hlsearch
set incsearch
set showmatch
set mat=5

if &term =~ "xterm"
  if has("terminfo")
      set t_Co=8
      set t_Sf=[3%p1%dm
      set t_Sb=[4%p1%dm
  else
      set t_Co=8
      set t_Sf=[3%dm
      set t_Sb=[4%dm
  endif
endif

if &t_Co > 22 || has("gui_running")
    :syntax on
    :highlight Comment  term=bold ctermfg=cyan guifg=cyan
    :highlight Special  term=bold ctermfc=cyan guifg=cyan
    :highlight Constant term=bold ctermfg=red  guifg=cyan
endif

" set bg=dark

:set nowrap
:set nowrapscan

set list

set nowrap
set expandtab

set listchars=tab:.\ ,eol:¬,trail:»,nbsp:•

if has ("autocmd")
  filetype plugin indent on
  autocmd FileType c set omnifunc=ccompleteComplete
  autocmd FileType c set omnifunc=ccomplete#Complete
  autocmd FileType text setlocal textwidth=80
endif " has("autocmd")

set term=builtin_ansi

set smartcase

set nostartofline
set history=50

map Q qq
syntax on

:autocmd BufNewFile,BufRead *.s set tabstop=8
:autocmd BufNewFile,BufRead *.s set shiftwidth=8
:autocmd BufNewFile,BufRead *.s set softtabstop=8

:autocmd BufNewFile,BufRead [Mm]akefile* set noexpandtab
:syntax on
