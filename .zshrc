export ZSH=$HOME/.oh-my-zsh

# Theme settings
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE="nerdfont-complete"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="▶ "
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs)

# Plugins
plugins=(
    common-aliases
    docker
    git
    history-substring-search
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# Load all custom configurations from ~/.dotfiles
for config_file (~/.dotfiles/*.zsh(N)); do
  source $config_file
done
unset config_file
