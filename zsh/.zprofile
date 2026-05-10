# .zprofile — runs at login shell start (before .zshrc)
# Only for login-specific setup. Interactive config goes in .zshrc.

[[ -o login ]] || return

# ── Ensure XDG dirs exist ──────────────────────────────────
mkdir -p \
  "$XDG_CONFIG_HOME" \
  "$XDG_DATA_HOME" \
  "$XDG_STATE_HOME" \
  "$XDG_STATE_HOME/less" \
  "$XDG_CACHE_HOME" \
  2>/dev/null

# ─── Start gnome-keyring / ssh-agent ──────────────────────
# if command -v gnome-keyring-daemon >/dev/null 2>&1; then
#   eval "$(gnome-keyring-daemon --start --components=secrets,ssh)" >/dev/null
# fi

# ─── Pyenv / nodenv / rbenv (if you use them) ─────────────
# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null && eval "$(pyenv init -)"

# export NODENV_ROOT="$HOME/.nodenv"
# command -v nodenv >/dev/null && eval "$(nodenv init -)"

# ─── Start dbus (only needed on some WMs/ttys) ────────────
# if [[ -z $DBUS_SESSION_BUS_ADDRESS ]]; then
#   dbus-launch --autolaunch >/dev/null 2>&1
# fi

# ─── Start pulseaudio / pipewire (login scope) ────────────
# if command -v pactl >/dev/null 2>&1 && ! pactl info >/dev/null 2>&1; then
#   pulseaudio --start 2>/dev/null
# fi

# ─── Set screen DPI for HiDPI displays ────────────────────
# export GDK_DPI_SCALE=2
# export QT_AUTO_SCREEN_SET_FACTOR=0
# export QT_SCALE_FACTOR=2
