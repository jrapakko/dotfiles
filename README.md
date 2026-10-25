Dotfiles (jrapakko)
=====

A place to keep my dotfiles so that I can easily set up a new dev machine and make configuration changes across all dev machines I use quickly

To install, run ./install.sh ** Careful, it will overwrite any dotfiles in your home directory

VIM
====
To install, copy dir to ~/.vim & run vim and :PluginInstall when vim boots up

Claude Code
====
`claude/` holds user-level Claude Code config. `install.sh` links it into `~/.claude/` file by file, never replacing `~/.claude` itself (it holds credentials and session state). Existing files you made outside the repo, like an agent created with `/agents`, are left alone.

| Repo path | Linked as | What it is |
| --- | --- | --- |
| `claude/CLAUDE.md` | `~/.claude/CLAUDE.md` | Global instructions for every project |
| `claude/agents/<name>.md` | `~/.claude/agents/<name>.md` | Subagents (architect, implementer, verifier, red-team) |
| `claude/commands/<name>.md` | `~/.claude/commands/<name>.md` | Custom slash commands |
| `claude/skills/<name>/` | `~/.claude/skills/<name>/` | Skills, one linked directory each |
| `claude/hooks/<script>` | `~/.claude/hooks/<script>` | Hook scripts used by agents or settings |
| `claude/statusline.sh` | `~/.claude/statusline.sh` | Status line script |

Rerun `./install.sh` after adding a new file or directory; edits to already-linked files take effect immediately.

### Commands
Each `claude/commands/<name>.md` becomes `/<name>`. The file body is the prompt; `$ARGUMENTS` is replaced by whatever follows the command. Optional frontmatter:

```markdown
---
description: Plan a change with the architect agent
argument-hint: <task>
---
Use the architect agent to plan: $ARGUMENTS
```

### Skills
Each skill is a directory `claude/skills/<name>/` containing a `SKILL.md`, plus any scripts or reference files it uses. Claude loads a skill when its description matches the task:

```markdown
---
name: <name>
description: What the skill does and when to use it
---
Instructions...
```

### Status line
`statusline.sh` shows the model and directory, plus a rainbow spinner verb (`Clauding…`, `Percolating…`, `Moonwalking…` and the rest of Claude Code's list, one picked per prompt) while Claude is working. Claude Code doesn't tell the status line when it's busy, so `hooks/clauding.sh` sets a per-session flag in `$XDG_RUNTIME_DIR/claude-clauding/` on `UserPromptSubmit` and clears it on `Stop` and `SessionEnd`. It needs `jq` and these entries in `~/.claude/settings.json` (not linked, since Claude Code writes to that file itself):

```json
"statusLine": { "type": "command", "command": "$HOME/.claude/statusline.sh", "refreshInterval": 1 },
"hooks": {
  "UserPromptSubmit": [{ "hooks": [{ "type": "command", "command": "$HOME/.claude/hooks/clauding.sh on" }] }],
  "Stop":             [{ "hooks": [{ "type": "command", "command": "$HOME/.claude/hooks/clauding.sh off" }] }],
  "SessionEnd":       [{ "hooks": [{ "type": "command", "command": "$HOME/.claude/hooks/clauding.sh off" }] }]
}
```

`refreshInterval: 1` redraws every second so the colours cycle.

### Hooks
- `hooks/clauding.sh`: sets and clears the busy flag for the status line (above).
- `hooks/readonly-bash.sh`: a PreToolUse hook the architect agent uses to allow only read-only Bash commands (an allowlist of programs such as `ls`, `grep`, `find` and read-only `git` subcommands; redirection and command substitution are blocked).

Check scripts with `shellcheck claude/statusline.sh claude/hooks/*.sh install.sh`.

### scree
The agents can use the [scree](https://github.com/jrapakko/scree) MCP tools (`search_docs`, `read_doc`). scree is enabled per repo, not at user scope: from a repo's root run `scree run doctor -v`, then `claude mcp add scree --scope project -- scree mcp`.
