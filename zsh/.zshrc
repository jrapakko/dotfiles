# brew completions
if [[ $(uname) == 'Darwin' ]]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

# The following lines were added by compinstall

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select=0
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt $SScrolling active: current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/Users/jrapakko/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install


# Paths
#
# OS X paths and architecture
if [[ $(uname) == 'Darwin' ]]; then
  # path vars
  LOCALBIN=/usr/local/bin
  AVRBIN=/usr/local/avr/bin

  # ls colors
  export LSCOLORS=GxFxCxDxBxegedabagaced

  # Set architecture flags
  export ARCHFLAGS="-arch x86_64"

  # set path to use brew utils (more up-to-date than OS X system utils)
  # can be done in /etc/paths if needed system-wide
  # check if path already begins with /usr/local/bin
  echo $PATH | grep -q -s "^${LOCALBIN}"
  # if not, update path
  if [[ $? -eq 1 ]]; then
    PATH=$LOCALBIN:$PATH
    export PATH
  fi

  #### AVR BINUTILS/GCC/LIBC NOT BUILT FROM SOURCE ON THIS COMPUTER
  # # set path to use avr binutils, gcc & libc (built from source)
  # echo $PATH | grep -q -s "${AVRBIN}"
  # # if not, update path
  # if [[ $? -eq 1 ]]; then
  #   PATH=$AVRBIN:$PATH
  #   export PATH
  # fi
fi


# Aliases
source $HOME/.zsh/aliases.zsh
