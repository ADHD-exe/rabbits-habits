# .zshenv — sourced on EVERY shell invocation (login, interactive, scripts)
# Only put the absolute minimum here — it runs before .zshrc, .zprofile, etc.

export ZDOTDIR="$HOME/.config/zsh"
export PATH="$HOME/.local/bin:$PATH"

# ── XDG dirs (early, so everything below inherits them) ────
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# ── Language / locale (must be set early) ──────────────────
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ── Less (early because MANPAGER may inherit) ──────────────
export PAGER=less
export LESS='-R -F -X'

# ── npm / pip user installs ────────────────────────────────
# export PATH="$HOME/.npm-global/bin:$PATH"
# export PATH="$HOME/.local/share/nvim/site/bin:$PATH"
