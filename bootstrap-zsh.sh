#!/usr/bin/env bash
# ==============================================================
# Rabbit's ZSH Environment Bootstrap
# Installs & configures: zinit, fzf, atuin, zoxide, starship
# Universally works on Arch, Debian, Fedora, openSUSE, Alpine...
#
# Usage:  curl -fsSL <url> | bash
#         ./bootstrap-zsh.sh
# ==============================================================
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
ZDOTDIR="${ZDOTDIR:-$HOME/.config/zsh}"

# Colors
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; NC='\033[0m'
info()  { printf "${CYAN}[INFO]${NC}  %s\n" "$*"; }
ok()    { printf "${GREEN}[OK]${NC}    %s\n" "$*"; }
warn()  { printf "${YELLOW}[WARN]${NC}  %s\n" "$*"; }
fail()  { printf "${RED}[FAIL]${NC}  %s\n" "$*"; exit 1; }

# ── Detect package manager ──────────────────────────────────
detect_pm() {
  if   command -v pacman &>/dev/null; then echo "pacman"
  elif command -v apt-get &>/dev/null; then echo "apt"
  elif command -v dnf    &>/dev/null; then echo "dnf"
  elif command -v zypper &>/dev/null; then echo "zypper"
  elif command -v apk    &>/dev/null; then echo "apk"
  elif command -v xbps-install &>/dev/null; then echo "xbps"
  else echo "unknown"; fi
}

PM=$(detect_pm)

# ── Package mapping: tool -> distro-specific package names ──
pkg_map() {
  local tool=$1
  case $PM in
    pacman)  case $tool in
               starship) echo "starship" ;; atuin) echo "atuin" ;;
               fzf) echo "fzf" ;; bat) echo "bat" ;;
               eza) echo "eza" ;; duf) echo "duf" ;;
               rg) echo "ripgrep" ;; fd) echo "fd" ;;
               fastfetch) echo "fastfetch" ;;
               git) echo "git" ;; zsh) echo "zsh" ;;
               curl) echo "curl" ;; esac ;;
    apt) case $tool in
           starship) echo "starship" ;; atuin) echo "atuin" ;;
           fzf) echo "fzf" ;; bat) echo "bat" ;;
           eza) echo "eza" ;; duf) echo "duf" ;;
           rg) echo "ripgrep" ;; fd) echo "fd-find" ;;
           fastfetch) echo "fastfetch" ;;
           git) echo "git" ;; zsh) echo "zsh" ;;
           curl) echo "curl" ;; esac ;;
    dnf) case $tool in
           starship) echo "starship" ;; atuin) echo "atuin" ;;
           fzf) echo "fzf" ;; bat) echo "bat" ;;
           eza) echo "eza" ;; duf) echo "duf" ;;
           rg) echo "ripgrep" ;; fd) echo "fd-find" ;;
           fastfetch) echo "fastfetch" ;;
           git) echo "git" ;; zsh) echo "zsh" ;;
           curl) echo "curl" ;; esac ;;
    zypper) case $tool in
              starship) echo "starship" ;; atuin) echo "atuin" ;;
              fzf) echo "fzf" ;; bat) echo "bat" ;;
              eza) echo "eza" ;; duf) echo "duf" ;;
              rg) echo "ripgrep" ;; fd) echo "fd" ;;
              fastfetch) echo "fastfetch" ;;
              git) echo "git" ;; zsh) echo "zsh" ;;
              curl) echo "curl" ;; esac ;;
    apk) case $tool in
           starship) echo "starship" ;; atuin) echo "atuin" ;;
           fzf) echo "fzf" ;; bat) echo "bat" ;;
           eza) echo "eza" ;; duf) echo "duf" ;;
           rg) echo "ripgrep" ;; fd) echo "fd" ;;
           fastfetch) echo "fastfetch" ;;
           git) echo "git" ;; zsh) echo "zsh" ;;
           curl) echo "curl" ;; esac ;;
    xbps) case $tool in
            starship) echo "starship" ;; atuin) echo "atuin-bin" ;;
            fzf) echo "fzf" ;; bat) echo "bat" ;;
            eza) echo "eza" ;; duf) echo "duf" ;;
            rg) echo "ripgrep" ;; fd) echo "fd" ;;
            fastfetch) echo "fastfetch" ;;
            git) echo "git" ;; zsh) echo "zsh" ;;
            curl) echo "curl" ;; esac ;;
    esac
}

install_pkg() {
  local cmd=$1 name
  name=$(pkg_map "$cmd") || name=$cmd
  if command -v "$cmd" &>/dev/null; then
    ok "$cmd already installed"; return 0
  fi
  info "Installing $cmd ($name via $PM)..."
  case $PM in
    pacman) sudo pacman -Sy --noconfirm --needed "$name" ;;
    apt)    sudo apt-get install -y "$name" ;;
    dnf)    sudo dnf install -y "$name" ;;
    zypper) sudo zypper install -y "$name" ;;
    apk)    sudo apk add "$name" ;;
    xbps)   sudo xbps-install -Sy "$name" ;;
    *) warn "Unsupported: $PM. Please install $cmd manually"; return 1 ;;
  esac
}

# ── Copy config file, with mkdir -p ─────────────────────────
install_config() {
  local src="$REPO_DIR/$1" dst="$2"
  mkdir -p "$(dirname "$dst")"
  if [[ -f "$src" ]]; then
    cp "$src" "$dst"
    ok "Installed $dst"
  else
    warn "Missing source: $src (skipping)"
  fi
}

# ═══════════════════════════════════════════════════════════
# MAIN
# ═══════════════════════════════════════════════════════════

main() {
  echo ""
  info "Rabbit's ZSH Environment Bootstrap"
  info "Detected PM: $PM"
  echo ""

  # 1 — Install system packages
  info "=== Step 1: System packages ==="
  install_pkg git
  install_pkg zsh
  install_pkg curl
  install_pkg starship
  install_pkg atuin
  install_pkg fzf
  install_pkg bat
  install_pkg eza
  install_pkg duf
  install_pkg rg
  install_pkg fd
  install_pkg fastfetch

  # 2 — Create ZDOTDIR
  info "=== Step 2: ZDOTDIR structure ==="
  mkdir -p "$ZDOTDIR"/env
  mkdir -p "$ZDOTDIR/zcompdump"
  mkdir -p "$HOME/.config/atuin"
  mkdir -p "$HOME/.config/kitty"

  # 3 — Install zinit
  info "=== Step 3: zinit ==="
  ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
  if [[ ! -d "$ZINIT_HOME" ]]; then
    git clone --depth 1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    ok "zinit installed"
  else
    ok "zinit already present"
  fi

  # 4 — Copy config files
  info "=== Step 4: Config files ==="

  # .zshenv (at $HOME)
  install_config "zsh/.zshenv" "$HOME/.zshenv"

  # ZDOTDIR files
  install_config "zsh/.zshrc"        "$ZDOTDIR/.zshrc"
  install_config "zsh/.zprofile"     "$ZDOTDIR/.zprofile"
  install_config "zsh/.zshenv"       "$ZDOTDIR/.zshenv"
  install_config "zsh/.zprompt"      "$ZDOTDIR/.zprompt"
  install_config "zsh/.zuser"        "$ZDOTDIR/.zuser"
  install_config "zsh/.zbanner"      "$ZDOTDIR/.zbanner"
  install_config "zsh/.zlogin"       "$ZDOTDIR/.zlogin"
  install_config "zsh/.zlogout"      "$ZDOTDIR/.zlogout"

  install_config "zsh/env/paths.zsh" "$ZDOTDIR/env/paths.zsh"
  install_config "zsh/env/apps.zsh"  "$ZDOTDIR/env/apps.zsh"

  install_config "zsh/.zplugin"   "$ZDOTDIR/.zplugin"
  install_config "zsh/.zfunction" "$ZDOTDIR/.zfunction"
  install_config "zsh/.zalias"    "$ZDOTDIR/.zalias"

  # Starship
  install_config "starship.toml" "$HOME/.config/starship.toml"

  # Atuin
  install_config "atuin/config.toml" "$HOME/.config/atuin/config.toml"

  # Kitty (copy if bundled, but don't overwrite existing)
  if [[ -f "$REPO_DIR/kitty.conf" ]] && [[ ! -f "$HOME/.config/kitty/kitty.conf" ]]; then
    install_config "kitty.conf" "$HOME/.config/kitty/kitty.conf"
  fi
  install_config "kitty/current-theme.conf" "$HOME/.config/kitty/current-theme.conf"
  install_config "kitty/open-actions.conf"  "$HOME/.config/kitty/open-actions.conf"
  install_config "kitty/launch-actions.conf" "$HOME/.config/kitty/launch-actions.conf"

  # ZDOTDIR extras
  install_config "zsh/colors-sourceoftruth.conf" "$ZDOTDIR/colors-sourceoftruth.conf"

  # 5 — Change default shell to zsh
  info "=== Step 5: Default shell ==="
  if [[ "$SHELL" != *zsh ]]; then
    if command -v chsh &>/dev/null; then
      chsh -s "$(command -v zsh)" 2>/dev/null || \
        warn "Could not change shell. Run: chsh -s $(command -v zsh)"
    fi
  else
    ok "zsh is already the default shell"
  fi

  echo ""
  ok "Bootstrap complete!"
  info "Restart your shell or run: exec zsh"
}
main "$@"
