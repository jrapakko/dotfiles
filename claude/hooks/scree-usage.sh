#!/bin/bash
# Logs where scree (the markdown docs MCP server) is used, and where docs were
# searched without it, to judge where scree is useful.
#
# As a PostToolUse hook (hook JSON on stdin), it appends one JSON line per event
# to $SCREE_USAGE_LOG:
#   - every scree call (mcp__scree__*), with the query, mode and hit count
#   - markdown lookups that went around scree: Read of a .md file, Grep/Glob
#     aimed at markdown, and grep/rg/cat/head/sed on .md files in Bash
# Each line records whether scree is enabled in that project (.mcp.json) and
# which agent made the call. Anything else is ignored.
#
# Usage: scree-usage.sh            (hook mode)
#        scree-usage.sh report     (summary per project)

log="${SCREE_USAGE_LOG:-${XDG_STATE_HOME:-$HOME/.local/state}/claude/scree-usage.jsonl}"

if [[ ${1:-} == report ]]
then
    [[ -s $log ]] || { echo "no scree usage logged yet ($log)"; exit 0; }
    jq -rs '
      group_by(.project)[] |
      (map(select(.kind == "scree"))) as $s |
      (map(select(.kind == "md-other"))) as $m |
      (map(select(.kind == "md-other" and .scree_enabled))) as $missed |
      "== \(.[0].project) (scree \(if any(.[]; .scree_enabled) then "enabled" else "not enabled" end))",
      "  scree calls: \($s | length)  searches: \($s | map(select(.tool == "search_docs")) | length)  read_doc: \($s | map(select(.tool == "read_doc")) | length)",
      "  searches with no hits: \($s | map(select(.tool == "search_docs" and .hits == 0)) | length)",
      ($s | map(select(.tool == "search_docs" and .hits == 0)) | .[-5:][] | "    - \(.query)"),
      "  docs read via scree: \($s | map(select(.tool == "read_doc") | .path) | group_by(.) | map("\(.[0]) (\(length))") | join(", "))",
      "  markdown lookups without scree: \($m | length)  (while scree was enabled: \($missed | length))",
      ($missed | group_by(.tool)[] | "    \(.[0].tool): \(length)"),
      ($missed | .[-5:][] | "    - \(.agent) \(.tool): \(.target)"),
      "  by agent (scree / markdown without scree): \(group_by(.agent) | map("\(.[0].agent) \(map(select(.kind == "scree")) | length)/\(map(select(.kind == "md-other")) | length)") | join(", "))"
    ' "$log"
    exit 0
fi

input=$(cat)
tool=$(jq -r '.tool_name // empty' <<<"$input")
[[ -z $tool ]] && exit 0

project_dir="${CLAUDE_PROJECT_DIR:-$(jq -r '.cwd // empty' <<<"$input")}"
scree_enabled=false
[[ -f $project_dir/.mcp.json ]] && grep -q '"scree"' "$project_dir/.mcp.json" && scree_enabled=true

kind="" target="" query="" mode="" hits=null path=""
case $tool in
    mcp__scree__*)
        kind=scree
        query=$(jq -r '.tool_input.query // empty' <<<"$input")
        mode=$(jq -r '.tool_input.mode // empty' <<<"$input")
        path=$(jq -r '.tool_input.path // empty' <<<"$input")
        # search_docs returns <hit> elements; count them in the raw response
        [[ $tool == mcp__scree__search_docs ]] &&
            hits=$(jq -r '.tool_response | tostring' <<<"$input" | grep -o '<hit[ >]' | wc -l)
        ;;
    Read)
        target=$(jq -r '.tool_input.file_path // empty' <<<"$input")
        [[ $target == *.md || $target == *.markdown ]] && kind=md-other
        ;;
    Grep|Glob)
        target=$(jq -r '[.tool_input.pattern, .tool_input.path, .tool_input.glob, .tool_input.type] | map(select(. != null)) | join(" ")' <<<"$input")
        [[ $target =~ \.md|\.markdown|(^| )md$|(^| )markdown$ ]] && kind=md-other
        ;;
    Bash)
        target=$(jq -r '.tool_input.command // empty' <<<"$input")
        [[ $target =~ (^|[|;&[:space:]])(grep|rg|cat|head|tail|sed|less)[[:space:]] && $target =~ \.md([^a-z]|$) ]] && kind=md-other
        target=${target:0:200}
        ;;
esac
[[ -z $kind ]] && exit 0

mkdir -p "$(dirname "$log")"
jq -cn \
    --arg ts "$(date -Iseconds)" \
    --arg session "$(jq -r '.session_id // empty' <<<"$input")" \
    --arg agent "$(jq -r '.agent_type // "main"' <<<"$input")" \
    --arg project "$(basename "$project_dir")" \
    --argjson scree_enabled "$scree_enabled" \
    --arg kind "$kind" \
    --arg tool "${tool#mcp__scree__}" \
    --arg query "$query" --arg mode "$mode" --arg path "$path" \
    --argjson hits "$hits" \
    --arg target "${target#"$project_dir"/}" \
    '{ts: $ts, session: $session, agent: $agent, project: $project, scree_enabled: $scree_enabled,
      kind: $kind, tool: $tool, query: $query, mode: $mode, path: $path, hits: $hits, target: $target}
     | with_entries(select(.value != "" and .value != null))' >> "$log"
exit 0
