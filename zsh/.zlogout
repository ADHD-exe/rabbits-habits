# .zlogout — runs at login shell exit
# Uncomment any lines you want to enable.

# ── Clear terminal ──────────────────────────────────────────
# clear

# ── Log session end ─────────────────────────────────────────
# echo "$(date '+%F %T') - session ended" >> "$HOME/.local/state/session.log"

# ── Kill ssh-agent on logout (paranoid) ─────────────────────
# if [[ -n $SSH_AGENT_PID ]]; then
#   ssh-agent -k >/dev/null
# fi
