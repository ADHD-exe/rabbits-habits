# .zlogin — runs once at login shell start (after .zshrc)
# Uncomment any lines you want to enable.

# ── SSH agent ───────────────────────────────────────────────
# if command -v ssh-agent >/dev/null 2>&1 && [[ -z $SSH_AUTH_SOCK ]]; then
#   eval "$(ssh-agent -s)" >/dev/null
# fi

# ── GPG agent ───────────────────────────────────────────────
# if command -v gpgconf >/dev/null 2>&1; then
#   gpgconf --launch gpg-agent
# fi

# ── Tmux auto-attach ────────────────────────────────────────
# if command -v tmux >/dev/null 2>&1 && [[ -z $TMUX ]]; then
#   tmux new-session -A -s main
# fi

# ── Systemd user services ───────────────────────────────────
# if command -v systemctl >/dev/null 2>&1; then
#   systemctl --user start pipewire wireplumber 2>/dev/null
# fi

# ── Display login message ───────────────────────────────────
# echo "Welcome back, $(whoami) @ $(date '+%A, %B %d, %Y')"
