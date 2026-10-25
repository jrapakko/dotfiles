#!/bin/bash
# Claude Code status line: model · dir, plus a rainbow spinner verb
# ("Clauding…" etc.) while Claude is working (flag set by hooks/clauding.sh).

input=$(cat)
model=$(jq -r '.model.display_name // "?"' <<<"$input")
dir=$(jq -r '.workspace.current_dir // .cwd // ""' <<<"$input")
session=$(jq -r '.session_id // empty' <<<"$input")
flag="${XDG_RUNTIME_DIR:-/tmp}/claude-clauding/$session"

rainbow() {
    # red orange yellow green blue indigo violet (256-color)
    local colors=(196 208 226 46 33 93 201) text=$1 out="" i
    local offset=$(( $(date +%s) % ${#colors[@]} ))
    for (( i = 0; i < ${#text}; i++ )); do
        out+="\e[38;5;${colors[(i + offset) % ${#colors[@]}]}m${text:i:1}"
    done
    printf '%b\e[0m' "$out"
}

printf '%s · %s' "$model" "${dir/#"$HOME"/\~}"
if [[ -n $session && -e $flag ]]; then
    verb=$(<"$flag")
    printf ' · '
    rainbow "${verb:-Clauding}…"
fi
