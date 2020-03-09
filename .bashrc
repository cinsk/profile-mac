
# /etc/profile read /etc/bashrc, so below paragraph is no longer necessary.
#
# Make bash check its window size after a process completes
# shopt -s checkwinsize
# if [ -f /etc/bashrc ]; then
#     . /etc/bashrc
# fi

#
# Copied from /etc/bash/bashrc of Gentoo Linux (bash-4.4_p12)
#

if type -P dircolors >/dev/null ; then
    # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
    LS_COLORS=
    if [[ -f ~/.dir_colors ]] ; then
        # Make sure that .dir_colors has an entry "TERM=dumb" for Emacs' M-x shell
        eval "$(dircolors -b ~/.dir_colors)"
    elif [[ -f /etc/DIR_COLORS ]] ; then
        eval "$(dircolors -b /etc/DIR_COLORS)"
    else
        eval "$(dircolors -b)"
    fi
    # Note: We always evaluate the LS_COLORS setting even when it's the
    # default.  If it isn't set, then `ls` will only colorize by default
    # based on file attributes and ignore extensions (even the compiled
    # in defaults of dircolors). #583814
    if [[ -n ${LS_COLORS:+set} ]] ; then
        use_color=true
    else
        # Delete it if it's empty as it's useless in that case.
        unset LS_COLORS
    fi
else
    # Some systems (e.g. BSD & embedded) don't typically come with
    # dircolors so we need to hardcode some terminals in here.
    case ${TERM} in
        dumb|eterm*|[aEkx]term*|rxvt*|gnome*|konsole*|screen|cons25|*color)
            use_color=true
        ;;
    esac
fi

PS1=
if [ "$TERM" != "dumb" ]; then
    #
    # Set window title to 'xxx':
    #    PS1="\033]0;xxx\007"
    #
    # Control sequences for setting window title may not work properly in Emacs
    PS1='\[\033]0;\u@\h\007\]'
fi

if [ -n "$use_color" -a "$TERM" != "dumb" ]; then
    # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
    if type -P dircolors >/dev/null ; then
        if [[ -f ~/.dir_colors ]] ; then
            eval $(dircolors -b ~/.dir_colors)
        elif [[ -f /etc/DIR_COLORS ]] ; then
            eval $(dircolors -b /etc/DIR_COLORS)
        fi
    fi

    if [[ ${EUID} == 0 ]] ; then
        #PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
        PS1="$PS1"'\[\033[01;31m\]\h\[\033[01;34m\]:\W\$\[\033[00m\] '
    else
        #PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
        PS1="$PS1"'\[\033[01;32m\]\h\[\033[01;34m\]:\w\$\[\033[00m\] '
    fi

else
    if [[ ${EUID} == 0 ]] ; then
        # show root@ when we don't have colors
        PS1="$PS1"'\h:\W\$ '
    else
        PS1="$PS1"'\h:\w\$ '
    fi
fi

if [ -n "$use_color" ]; then
    alias ls='ls --color=auto -F'
    alias grep='grep --colour=auto'
    alias egrep='egrep --colour=auto'
    alias fgrep='fgrep --colour=auto'
fi

unset use_color

#
# End: Color settings
#

if [ ! -x /usr/local/bin/emacs ]; then
    [ -x /Applications/Emacs.app/contents/MacOS/Emacs ] && \
        alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
fi

[ -x '/Applications/Adobe Reader.app/Contents/MacOS/AdobeReader' ] && \
    alias acroread='/Applications/Adobe\ Reader.app/Contents/MacOS/AdobeReader'

[ -x $HOME/bin/mvn.sh ] && alias mvn="$HOME/bin/mvn.sh"

# https://coderwall.com/p/xdox9a/running-ipython-cleanly-inside-a-virtualenv
alias ipy="python -c 'import IPython;IPython.terminal.ipapp.launch_new_instance()'"

mvim=$(realpath $(which mvim) 2>/dev/null)
if [ -n "$mvim" ]; then
    mvim=${mvim/bin\/mvim}MacVim.app/Contents/MacOS/Vim
    if [ -x "$mvim" ]; then
        alias vim="$mvim"
    fi
fi
unset mvim


export HOMEBREW_GITHUB_API_TOKEN="b888931bb7a1857d61cbb6cc968d9ba79b8d67d0"

if which terraform >&/dev/null; then
    alias tf=terraform
fi

alias c=pushd
alias p=popd
alias d='dirs -v'

if [ -x "$HOME/src/snippets/vless" ]; then
    alias vless="$HOME/src/snippets/vless"
fi

if [ -x "/usr/local/KindleGen/kindlegen" ]; then
    alias kindlegen='/usr/local/KindleGen/kindlegen'
fi

# Triton Docker setting
if [ -z "$TRITON_PROFILE" -a -x "$(which triton)" ]; then
    # TODO: better to get profile via `triton profile get` instead of
    # 'us-east-1'
    eval "$(triton env --triton --docker --smartdc us-east-1)"
fi

[ -r "$HOME/bin/tenv.sh" ] && source "$HOME/bin/tenv.sh"

alias t=triton
alias e='emacsclient -n'

# Manta setting
export MANTA_URL=https://us-east.manta.joyent.com
export MANTA_USER=csk
unset MANTA_SUBUSER # Unless you have subusers
export MANTA_KEY_ID=$(ssh-keygen -E md5 -l -f $HOME/.ssh/id_rsa.pub | sed 's/MD5://' | awk '{print $2}')



complete -C /Users/seong-kookshin/src/go/src/github.com/minio/mc/mc mc
