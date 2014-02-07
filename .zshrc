# Set custom prompt
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt grb

# Initialize completion
autoload -U compinit
compinit

export PATH=/usr/local/pear/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
export PATH="/usr/games/bin:$PATH"
export NODE_PATH="/usr/local/lib/node"
export PYTHONPATH=/usr/local/python
export PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"
export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'
alias todo='ack "todo" -i'
# alias vim='mvim -v'

unsetopt correct_all

# bindkey -v

# case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

## Command history configuration
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

# Completion
# highlight directories and current selection
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:*:*:*' menu select

# up/down arrows search partially typed commands
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# ls colors
autoload colors; colors
export LSCOLORS="Gxfxcxdxbxegedabagacad"
alias ls='ls -G'
alias sr='screen -r'

#Auto Escape URLS
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
[[ $TERM = "screen" ]] && rvm use default >> /dev/null
