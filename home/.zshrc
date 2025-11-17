# zmodload zsh/zprof

DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Pyenv stuff
export PYENV_ROOT="$HOME/.pyenv"

# PATH
export PATH="$HOME/.pyenv/shims:$PATH"
export PATH="$HOME/.config/emacs/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="/opt/homebrew/Cellar/libgccjit/13.1.0:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"

# Path to your oh-my-zsh installation.
export ZSH="/Users/greg/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="apple"

plugins=(
        docker
	docker-compose
	dotenv
	git
	git-prompt
#	colorize
	pip
	python
)

source $ZSH/oh-my-zsh.sh

export EDITOR="emacsclient -t"                  # $EDITOR opens in terminal
export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI mode

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# custom configurations and aliases
alias pyclear='find . -type d -name __pycache__ -exec rm -r {} \+'
alias mux='tmuxinator'
# alias emacs='emacs -nw'

# lisp and rlwrap
alias lisp="rlwrap sbcl --load quicklisp.lisp"

source ~/.bash_aliases

# convenience aliases
alias r="cd $(git root)"

# Docker specific
alias dcu="docker-compose up"
alias dcd="docker-compose down"
alias dcb="docker-compose build"

# Alias for exa instead of ls
alias ls='exa --long --grid --header --git'

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/greg/.bin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/greg/.bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/greg/.bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/greg/.bin/google-cloud-sdk/completion.zsh.inc'; fi

# Kubernetes & Helm specific
export TILLER_NAMESPACE=tiller
USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Starship prompt
eval "$(starship init zsh)"

# direnv
eval "$(direnv hook zsh)"

# zoxide
eval "$(zoxide init zsh)"

# thefuck
eval $(thefuck --alias)

# Git customization
alias r='cd $(git root)'
function red() {
  fd "$1" $(git root)
}

# completions for pipx
autoload -U bashcompinit
bashcompinit

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Exa Dracula theme
# ------------------------------
# exa - Color Scheme Definitions
# ------------------------------
export EXA_COLORS="\
uu=36:\
gu=37:\
sn=32:\
sb=32:\
da=34:\
ur=34:\
uw=35:\
ux=36:\
ue=36:\
gr=34:\
gw=35:\
gx=36:\
tr=34:\
tw=35:\
tx=36:"

# map eza commands to normal ls commands
alias ll="eza -l -g --icons"
alias ls="eza --icons"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"

# zprof
