# Download Znap, if it's not there yet.
[[ -f ~/.zsh-plugins/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.zsh-plugins/zsh-snap

source ~/.zsh-plugins/zsh-snap/znap.zsh

setopt SHARE_HISTORY
HISTFILE=$HOME/.zsh_history
SAVEHIST=10000
HISTSIZE=9999
setopt HIST_EXPIRE_DUPS_FIRST

setopt auto_cd

znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-history-substring-search
znap source zsh-users/zsh-autosuggestions
znap source agkozak/zsh-z

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '^[^[[D^' backward-word
bindkey '^[^[[C^' forward-word

zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'

# Load all custom configurations from ~/.dotfiles
for config_file (~/.dotfiles/**/*.zsh(N)); do
  source $config_file
done
unset config_file

() {
  local -a plugins=(
      common-aliases
      docker
      git
      nvm
  )
  znap source ohmyzsh/ohmyzsh plugins/$^plugins
}

znap prompt romkatv/powerlevel10k

export SDKMAN_DIR="/Users/paulby/.sdkman"
[[ -s "~/.sdkman/bin/sdkman-init.sh" ]] && source "~/.sdkman/bin/sdkman-init.sh"

git