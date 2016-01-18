
export LC_MESSAGES=C LC_TIME=C

export GOPATH=$HOME/.go
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH:$GOPATH/bin:$HOME/bin"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

if [ -d "/Applications/Racket v6.2" ]; then
    export PATH="/Applications/Racket v6.2/bin:$PATH"
    export MANPATH="/Applications/Racket v6.2/man:$MANPATH"
fi

if [ -d "/Applications/Emacs.app/Contents/MacOS/bin" ]; then
    export PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH"
fi

if [ -z "$JAVA_HOME" -a -x "/usr/libexec/java_home" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc



[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
