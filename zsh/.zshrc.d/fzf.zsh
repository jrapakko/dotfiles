# fzf: Ctrl-R history search, Ctrl-T file picker, Alt-C cd. fd for listing (respects .gitignore), bat for previews.
if command -v fzf >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :200 {}'"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
  source <(fzf --zsh)
fi
