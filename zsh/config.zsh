# shellcheck disable=SC2034
HISTFILE=$HOME/.zsh_history
SAVEHIST=10000
HISTSIZE=9999

setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt auto_cd

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[^[[D' backward-word
bindkey '^[^[[C' forward-word
bindkey '^[[H'   beginning-of-line
bindkey '^[[F'   end-of-line

zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
