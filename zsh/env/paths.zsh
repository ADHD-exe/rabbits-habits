#env/paths.zsh
# Additional PATH management

typeset -U path

path+=(
  $HOME/.local/bin
  $HOME/Documents/Scripts
  $HOME/.spicetify
  $HOME/.local/share/nvim/site
  $HOME/.npm-global/bin)

export PATH
