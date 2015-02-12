" Mouse might work
if has('mouse')
  set mouse =a
endif

" Gui mode ftw?
if has ("gui_running")
  set guioptions-=T
  set guioptions-=e
  set t_Co=256
  set guitablabel=%M\ %t
endif

" Set font according to system
if has("mac") || has("macunix")
  set gfn=Source\ Code\ Pro:h12,Menlo:h12
elseif has("win16") || has("win32")
  set gfn=Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("linux")
  set gfn=Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("unix")
  set gfn=Monospace\ 11
endif

" MacVim fullscreen
if has("gui_macvim")
  set fuoptions=maxvert,maxhorz
  au GUIEnter * set fullscreen
endif

" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L

