# Set custom prompt
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt grb

#########################################
# MISC PROMPT SETTINGS
#########################################
# VIM bindings
# bindkey -v

# don't offer command corrections
unsetopt correct_all

# ls colors
autoload colors; colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Auto Escape URLS
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

#########################################
# USER $PATH
#########################################
export PATH=/usr/local/pear/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
export PATH="/usr/games/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export NODE_PATH="/usr/local/lib/node"
export PYTHONPATH=/usr/local/python
export PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

#########################################
# ALIASES
#########################################
alias ls='ls -G'
alias sr='screen -r'
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'
alias vs='vagrant ssh'

# find todos
alias todo='ack -i "todo"'

#########################################
# COMMAND HISTORY CONFIGURATION
#########################################
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

#########################################
# FILE/COMMAND COMPLETION
#########################################
autoload -U compinit
compinit

# case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# highlight directories and current selection
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:*:*:*' menu select

# up/down arrows search partially typed commands
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# Force RVM when entering screen
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ $TERM = "screen" ]] && rvm use default >> /dev/null

# added by travis gem
[ -f /Users/baylorrae/.travis/travis.sh ] && source /Users/baylorrae/.travis/travis.sh
