
export LC_MESSAGES=C LC_TIME=C

export GOPATH=$HOME/src/go

if [ -d "/usr/local/opt/coreutils/libexec/gnubin" ]; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH:$GOPATH/bin:$HOME/bin"
fi

export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

if [ -d "/Applications/Racket v6.2" ]; then
    export PATH="/Applications/Racket v6.2/bin:$PATH"
    export MANPATH="/Applications/Racket v6.2/man:$MANPATH"
fi

if [ -d "/Applications/Emacs.app/Contents/MacOS/bin" ]; then
    export PATH="/Applications/Emacs.app/Contents/MacOS/bin:$PATH"
fi

if [ -d "/Applications/Aquamacs.app/Contents/MacOS/bin" ]; then
    export PATH="/Applications/Aquamacs.app/Contents/MacOS/bin:$PATH"
fi

if [ -z "$JAVA_HOME" -a -x "/usr/libexec/java_home" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

if [ -d "/usr/local/opt/python/libexec/bin" ]; then
    # Prefer homebrewed version of python over system default
    export PATH="/usr/local/opt/python/libexec/bin:$PATH"
fi

# Initialization for FDK command line tools.Thu Aug 24 14:19:01 2017
FDK_EXE="/Users/seong-kookshin/bin/FDK/Tools/osx"
PATH=${PATH}:"/Users/seong-kookshin/bin/FDK/Tools/osx"
export PATH
export FDK_EXE

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
[[ -f ~/.bashrc ]] && . ~/.bashrc

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

