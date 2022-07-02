#
# .zshenv 
# Commands are first read from /etc/zshenv; this cannot be overridden.
#

# This prompt will be overriden by the setting in .zshrc.  Please
# modify this there if you want to change the prompt.
PS1='%# '

export LC_MESSAGES=C LC_TIME=C
export PATH=$PATH:$HOME/bin

export GOPATH=$HOME/src/go
export PATH=$PATH:$GOPATH/bin


update-path() {
    local OPTIND=1 manpath binpath
    
    while getopts "m:" opt; do
        case "$opt" in
            m)
                manpath="$OPTARG"
                if [[ "$manpath" != /* ]]; then
                    echo "${FUNCNAME[0]}: -m requires an absolute path" 1>&2
                    return 1
                fi
        esac
    done
    shift $((OPTIND-1))
    binpath="$1"
    if [[ "$binpath" != /* ]]; then
        echo "${FUNCNAME[0]}: requires an absolute path" 1>&2
        return 1
    fi
    
    if [ -d "$binpath" ]; then
        export PATH="$binpath:$PATH"
    fi
    if [ -n "$manpath" -a -d "$manpath" ]; then
        export MANPATH="$manpath:$MANPATH"
    fi
}


update-path -m /usr/local/opt/coreutils/libexec/gnuman /usr/local/opt/coreutils/libexec/gnubin
update-path -m /usr/local/opt/make/libexec/gnuman /usr/local/opt/make/libexec/gnubin
update-path -m /usr/local/opt/openssl/share/man /usr/local/opt/openssl/bin
#update-path /Applications/Aquamacs.app/Contents/MacOS/bin
update-path /Applications/Emacs.app/Contents/MacOS/bin
update-path -m '/Applications/Racket v6.12/man' /Applications/Racket v6.12/bin
update-path /Applications/calibre.app/Contents/MacOS
# update-path ${HOME}/.please
update-path /usr/local/opt/bc/bin

unset -f update-path


if [ -z "$JAVA_HOME" -a -x "/usr/libexec/java_home" ]; then
    export JAVA_HOME=$(/usr/libexec/java_home)
fi

# if [ -d "/usr/local/opt/python/libexec/bin" ]; then
#     # Prefer homebrewed version of python over system default
#     export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# fi

# Initialization for FDK command line tools.Thu Aug 24 14:19:01 2017
FDK_EXE="/Users/seong-kookshin/bin/FDK/Tools/osx"
PATH=${PATH}:"/Users/seong-kookshin/bin/FDK/Tools/osx"
export PATH
export FDK_EXE

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if which rbenv &>/dev/null; then
    eval "$(rbenv init -)"
    #export RBENV_VERSION=2.5.0
fi

if which pyenv &>/dev/null; then
    eval "$(pyenv init -)"
    #export PYENV_VERSION=3.6.8
fi

