set nocompatible                  " be iMproved, required for Vundle
filetype off                      " Vundle

" Vundle runtime path + initialization
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" path for Vundle to install plugins
"
" Vundle manages Vundle
Plugin 'gmarik/Vundle.vim'

"                                          "
" ================ Plugins =============== "
"                                          "
" -------- NERD Tree (filesystem) -------- "
"                                          "
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'
"                                          "
" -------------- ctrlp.vim --------------- "
"                                          "
Plugin 'kien/ctrlp.vim'
"                                          "
" ------- Syntastic (syntax/lint) -------- "
"                                          "
Plugin 'scrooloose/syntastic'
"                                          "
" ------ EasyMotion (file movement) ------ "
"                                          "
Plugin 'Lokaltog/vim-easymotion'
"                                          "
" -------------- vim-endwise ------------- "
"                                          "
Plugin 'tpope/vim-endwise'
"                                          "
" ------------- vim-fugitive ------------- "
"                                          "
Plugin 'tpope/vim-fugitive'
"                                          "
" ------------- vim-surround ------------- "
"                                          "
Plugin 'tpope/vim-surround'
"                                          "
" ------------ NERD Commenter ------------ "
"                                          "
Plugin 'scrooloose/nerdcommenter'
"                                          "
" ------------- vim-airline -------------- "
Plugin 'bling/vim-airline'
"                                          "
" --------------- tagbar ----------------- "
Plugin 'majutsushi/tagbar'
Plugin 'itchyny/lightline.vim'
"                                          "
" ------------- SuperTab ------------------"
Plugin 'ervandew/supertab'
"                                          "
" --------------- vimproc ---------------- "
Plugin 'Shougo/vimproc.vim'
"                                          "
" ------------- repeat.vim --------------- "
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-eunuch'
"                                           "
" --------------- Tabular ----------------- "
Plugin 'godlygeek/tabular'
Plugin 'Align'
"""" ============ VimShell ============= """"
Plugin 'Shougo/vimshell.vim'
Plugin 'Shougo/vimfiler.vim'
"" minibufexpl
Plugin 'fholgado/minibufexpl.vim'
"" YouCompleteMe
Plugin 'Valloric/YouCompleteMe'
"" neocomplcache
Plugin 'Shougo/neocomplcache.vim'
Plugin 'AutoComplPop'
Plugin 'OmniCppComplete'
Plugin 'yuratomo/java-api-complete'
Plugin 'm2mdas/phpcomplete-extended'
"" indent guides
Plugin 'nathanaelkane/vim-indent-guides'
"" tmux
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'
"" gitgutter
Plugin 'airblade/vim-gitgutter'
"" gist
Plugin 'mattn/gist-vim'
"" sudo.vim
Plugin 'sudo.vim'
"" gundo.vim
Plugin 'sjl/gundo.vim'
"" unite
Plugin 'Shougo/unite.vim'
Plugin 'h1mesuke/unite-outline'
"" unimpaired-vim
Plugin 'tpope/vim-unimpaired'
"" commentary
Plugin 'tpope/vim-commentary'
"" a.vim
Plugin 'a.vim'
"" vim-indent-object
Plugin 'michaeljsmith/vim-indent-object'
Plugin 'junegunn/vim-easy-align'
"" makeshift
Plugin 'johnsyweb/vim-makeshift'
"" AsyncCommand
Plugin 'idbrii/AsyncCommand'

Plugin 'chrisbra/changesPlugin'

"" autoswap
Plugin 'autoswap.vim'
"" Vim Shell Executor
Plugin 'JarrodCTaylor/vim-shell-executor'

Plugin 'chrisbra/Colorizer'
Plugin 'kana/vim-smartinput'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'the-lambda-church/merlin'
Plugin 'noahfrederick/vim-skeleton'
Plugin 'c9s/perlomni.vim'
Plugin 'rip-rip/clang_complete'

""""""   ======== DEFAULTS ========   """"""
Plugin 'L9'
Plugin 'tomtom/tlib_vim'
Plugin 'tpope/vim-sensible'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'rizzatti/funcoo.vim'
Plugin 'vim-jp/vital.vim'
Plugin 'tpope/vim-sleuth'
Plugin 'google/vim-maktaba'
Plugin 'vasconcelloslf/vim-foldfocus'

" ack.vim
Plugin 'mileszs/ack.vim'
"                                          "
" ---------------------------------------- "
" ----------- Syntax Plugins ------------- "
" JS, etc.
Plugin 'kchmck/vim-coffee-script'
Plugin 'pangloss/vim-javascript'
Plugin 'marijnh/tern_for_vim'
Plugin 'hail2u/vim-css3-syntax'
Plugin 'tpope/vim-haml'
Plugin 'groenewege/vim-less'
Plugin 'othree/html5.vim'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'derekwyatt/vim-scala'
Plugin 'elzr/vim-json'
Plugin 'jnwhiteh/vim-golang'
Plugin 'ap/vim-css-color'
Plugin 'gregsexton/MatchTag'
Plugin 'sjl/badwolf'
Plugin 'bronson/vim-trailing-whitespace'
" Ruby/Rails
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
" Markdown
Plugin 'tpope/vim-markdown'
" Python
Plugin 'hdima/python-syntax'

" ======================================== "
" ============ Color Schemes ============= "
"" vim-colorschemes
Plugin 'flazz/vim-colorschemes'
"" jellybeans
Plugin 'nanotech/jellybeans.vim'
"" Lucius
Plugin 'jonathanfilip/vim-lucius'
"" Zenburn
Plugin 'jnurmine/Zenburn'
Plugin 'morhetz/gruvbox'
Plugin 'junegunn/seoul256.vim'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'reedes/vim-pencil'
Plugin 'romainl/Apprentice'
Plugin 'MaxSt/FlatColor'
Plugin 'amdt/sunset'
Plugin 'molok/vim-vombato-colorscheme'

" CSApprox (gvim v vim)
Plugin 'godlygeek/csapprox'

call vundle#end()
filetype plugin indent on " turned off for vundle

" Sunset
let g:sunset_latitude = 37.3
let g:sunset_longitude = -121.9
let g:sunset_utc_offset = -8

let g:loaded_sunset = 1

" Sunset > colorscheme
function! g:sunset_daytime_callback()
  colorscheme 'Obsidian'
endfunction

function! g:sunset_nighttime_callback()
  colorscheme 'Pencil'
endfunction

" Sunset > Powerline
function! g:sunset_daytime_callback()
  if exists(':PowerlineReloadColorScheme')
    let g:Powerline_colorscheme = 'Obsidian'
    PowerlineReloadColorscheme
  endif
endfunction

function! g:sunset_nighttime_callback()
  if exists(':PowerlineReloadColorScheme')
    let g:Powerline_colorscheme = 'Pencil'
    PowerlineReloadColorscheme
  endif
endfunction

