# Rabbit's ZSH Environment

Portable, cross-distro ZSH environment with zinit plugin manager, fzf, atuin, zoxide, and starship.

## Quick Start

```bash
curl -fsSL https://<url>/bootstrap-zsh.sh | bash
# or
./bootstrap-zsh.sh
```

## What It Sets Up

| Tool | Purpose |
|------|---------|
| **zinit** | Plugin manager (parallel loading, turbo mode) |
| **fzf** | Fuzzy finder (CTRL-T for files, CTRL-H for history) |
| **atuin** | Shell history daemon with AI search |
| **zoxide** | Smart directory jumper (`z <fragment>`) |
| **starship** | Prompt with git status, timings, battery |
| **bat** | `cat` replacement with syntax highlighting |
| **eza** | `ls` replacement with icons and git status |
| **fastfetch** | System info on shell start |

## Project Structure

```
rabbits-defaults/
├── bootstrap-zsh.sh          # Cross-distro installer
├── starship.toml             # Prompt theme
├── kitty.conf                # Terminal config
├── kitty/
│   ├── current-theme.conf
│   ├── open-actions.conf
│   └── launch-actions.conf
├── atuin/
│   └── config.toml           # History daemon config
└── zsh/
    ├── .zshenv               # PATH, XDG dirs, locale (every shell)
    ├── .zprofile             # Login-only: mkdir -p, app configs
    ├── .zshrc                # Pure source-loader (19 lines)
    ├── .zplugin              # zinit, plugins, keybindings, fzf, syntax
    ├── .zfunction            # Custom functions (fzf widgets, screenshots, etc.)
    ├── .zalias               # Aliases (docker, git, arch, etc.)
    ├── .zprompt              # starship init + fastfetch
    ├── .zlogin               # Commented login hooks (ssh-agent, tmux, gpg)
    ├── .zlogout              # Commented cleanup hooks
    ├── .zuser                # User overrides (HyDE compat)
    ├── .zbanner              # Custom banner placeholder
    ├── colors-sourceoftruth.conf  # Terminal color definitions
    └── env/
        ├── apps.zsh          # EDITOR, VISUAL, TERM, app env vars
        └── paths.zsh         # PATH additions
```

## Supported Distros

Arch, Debian/Ubuntu, Fedora, openSUSE, Alpine, Void.

Package manager is auto-detected: pacman, apt, dnf, zypper, apk, xbps.

## Zsh Startup Flow

```
.zshenv  →  .zprofile  →  .zshrc  →  .zlogin  →  .zlogout
  (env)      (login)     (interactive) (login)     (login exit)
```

- **`.zshenv`**: Early bootstrap — ZDOTDIR, XDG vars, locale, less
- **`.zprofile`**: Login-only — creates XDG dirs, app configs
- **`.zshrc`**: Sources env → plugins → functions → aliases → prompt → user
- **`.zlogin`**: Hook placeholder (ssh-agent, tmux, gpg)
- **`.zlogout`**: Cleanup placeholder

## Key Bindings

| Binding | Action |
|---------|--------|
| `CTRL-H` | fzf history search |
| `CTRL-T` | fzf file search |
| `CTRL-Z` | Complete word |
| `↑` | atuin history TUI |
| `CTRL-R` | atuin (not fzf — fzf uses CTRL-H) |

Custom fzf functions (bound by user preference):
- `_fuzzy_change_directory` — find directory with fzf
- `_fuzzy_edit_search_file` — find file with fzf
- `_fuzzy_edit_search_file_content` — rg + fzf content search
- `_fuzzy_search_cmd_history` — fzf history search

## Screenshot Functions (Wayland)

Available when `grim` + `slurp` are installed:

- `ssfull` — Fullscreen screenshot to clipboard
- `sssel` — Selection screenshot to clipboard
- `ssedit` — Selection screenshot → swappy editor
- `ssfile` — Selection screenshot → `~/Pictures/Screenshots/`

## Extending

Add your personal overrides to `.zuser` (sourced last). The env files are loaded
in order: `env/apps.zsh` → `env/paths.zsh` → plugins → functions → aliases → prompt.
