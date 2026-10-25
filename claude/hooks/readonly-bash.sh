#!/bin/bash
# PreToolUse hook for Bash: allow only read-only commands.
# Exit 2 blocks the call and shows stderr to the agent.

cmd=$(jq -r '.tool_input.command // empty')

block() {
    echo "readonly-bash: blocked ($1). This agent may only run read-only commands." >&2
    exit 2
}

# harmless redirections
stripped=$(sed -E 's/[0-9]*>&[0-9]+//g; s/[0-9]*>+ *\/dev\/null//g' <<<"$cmd")

[[ $stripped == *'>'* ]] && block "output redirection"
# shellcheck disable=SC2016 # literal $( and backtick, not expansions
[[ $stripped == *'$('* || $stripped == *'`'* ]] && block "command substitution"
[[ $stripped == *'<('* ]] && block "process substitution"

allowed=" ls cat head tail less wc grep rg find fd tree file stat du df
          diff cmp sort cut tr basename dirname realpath readlink pwd
          echo printf which type date jq git true false test "
git_allowed=" log show diff status blame grep ls-files ls-tree rev-parse
              branch describe shortlog cat-file remote config "

# split on ; & | and newlines, then check each simple command
while IFS= read -r seg; do
    read -r -a words <<<"$seg"
    [[ ${#words[@]} -eq 0 ]] && continue
    # skip leading VAR=value assignments
    i=0
    while [[ ${words[i]} == *=* && ${words[i]} != -* ]]; do ((i++)); done
    prog=${words[i]##*/}
    [[ -z $prog ]] && continue
    [[ $allowed == *" $prog "* ]] || block "'$prog' is not on the read-only list"
    # options that write files or run other programs
    for w in "${words[@]:i+1}"; do
        case $prog:$w in
            sort:-o*|sort:--output*|tree:-o|file:-C|rg:--pre*|fd:-x|fd:-X|fd:--exec*|git:--output*|git:-O*|git:--open-files-in-pager*|date:-s*|date:--set*)
                block "$prog $w" ;;
        esac
    done
    case $prog in
        find)
            for w in "${words[@]}"; do
                case $w in -delete|-exec|-execdir|-ok|-okdir|-fprint*|-fls) block "find $w" ;; esac
            done ;;
        git)
            # skip global options like -C dir / --no-pager
            j=$((i+1))
            while [[ ${words[j]} == -* ]]; do
                [[ ${words[j]} == -c* || ${words[j]} == --config-env* || ${words[j]} == --exec-path* ]] && block "git ${words[j]}"
                [[ ${words[j]} == -C ]] && ((j++))
                ((j++))
            done
            sub=${words[j]}
            [[ $git_allowed == *" $sub "* ]] || block "git $sub"
            case $sub in
                branch|remote|config)
                    for w in "${words[@]:j+1}"; do
                        case $w in -d|-D|-m|-M|-c|-C|--delete|--move|--copy|--unset*|--add|--replace-all|add|remove|rm|rename|set-url) block "git $sub $w" ;; esac
                    done
                    [[ $sub == config && ! " ${words[*]:j+1} " =~ \ (--get|--get-all|--list|-l|--get-regexp)\  ]] && block "git config without --get/--list"
                    ;;
            esac ;;
    esac
done < <(sed -E 's/\|\||&&|[;|&]/\n/g' <<<"$cmd")

exit 0
