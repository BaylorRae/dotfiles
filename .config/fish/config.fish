set -g -x fish_greeting ''

set PATH $PATH ~/.rvm/bin
set PATH $PATH ~/bin
set PATH $PATH /Applications/Postgres93.app/Contents/MacOS/bin

rvm use default >> /dev/null

alias sr "screen -r"
