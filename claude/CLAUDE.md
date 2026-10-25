# Global Claude Code instructions

These apply to every project on this machine. Linked into ~/.claude/CLAUDE.md
by install.sh from the dotfiles repo — edit it there, not here.

## Environment
- Fedora Linux; use `dnf` for system packages.
- Shells: bash and zsh (configs live in ~/dotfiles). Editor: vim.

## Working style
- Keep changes minimal and match the surrounding code's style.
- Ask before adding new dependencies.
- Don't commit or push unless asked.

## Git
- Short, imperative, lowercase commit subjects (e.g. "fix PS1 colors").

## Dependencies
Prefer well-maintained, pre-built libraries and modules over rolling custom implementations. Only write custom code when no suitable option exists or the dependency cost clearly outweighs the benefit.
EOF

## Agentic workflow

Roles are defined in dotfiles `claude/agents/*.md` and symlinked into `~/.claude/agents/`: architect, implementer, verifier, red-team.
Each runs in its own context. Hand off through written artifacts (plan, diff, findings), not shared reasoning.

Flow: architect → implementer → verifier → red-team → fix loop.
- Architect returns a plan; save it (e.g. `docs/plans/<task>.md`) and pass it to later roles.
- Only the implementer edits source. Verifier and red-team are read-only.
- Red-team findings go back to the implementer as repros; the verifier re-runs afterward.
- Cap the fix loop at 3 rounds, then escalate to me.
- Skip the architect for trivial changes (typos, one-line fixes).
