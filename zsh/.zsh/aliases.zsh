alias ll='ls -GFlash'
alias rm='rm -i'
alias cs='cd;ls'

# Get which system we're running on
uname=`uname -s`

# OS X Alias for macvim
if [[ $uname[0,6] == 'Darwin' ]]; then
  alias vi=mvim
  alias vim=mvim
  # -G not colors on many OSes
  alias ll='ls -GFlash'
elif [[ $uname[0,6] == 'CYGWIN']]; then
  alias ll='ls -Flash --color=always'
fi

alias frankly='cd $HOME/frankly'
