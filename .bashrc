#
# Copied from /etc/bash/bashrc of Gentoo Linux
#
use_color=false

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
        && type -P dircolors >/dev/null \
        && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

PS1='\[\033]0;\u@\h\007\]'

if [ "$TERM" = "dumb" ]; then
    # Emacs M-x shell uses dumb terminal, and it can handle colors.
    use_color=true
    PS1=''
fi

if ${use_color} ; then
        # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
        if type -P dircolors >/dev/null ; then
                if [[ -f ~/.dir_colors ]] ; then
                        eval $(dircolors -b ~/.dir_colors)
                elif [[ -f /etc/DIR_COLORS ]] ; then
                        eval $(dircolors -b /etc/DIR_COLORS)
                fi
        fi

        #
        # Set window title to 'xxx':
        #    PS1="\033]0;xxx\007"
        #
        if [[ ${EUID} == 0 ]] ; then
                #PS1='\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
                PS1="$PS1"'\[\033[01;31m\]\h\[\033[01;34m\]:\W\$\[\033[00m\] '
        else
                #PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w \$\[\033[00m\] '
                PS1="$PS1"'\[\033[01;32m\]\h\[\033[01;34m\]:\w\$\[\033[00m\] '
        fi

        alias ls='ls --color=auto -F'
        alias grep='grep --colour=auto'
        alias egrep='egrep --colour=auto'
        alias fgrep='fgrep --colour=auto'
else
        if [[ ${EUID} == 0 ]] ; then
                # show root@ when we don't have colors
                PS1='\h:\W\$ '
        else
                PS1='\h:\w\$ '
        fi
fi
unset use_color safe_term match_lhs

#
# End: Color settings
#

[ -x /Applications/Emacs.app/contents/MacOS/Emacs ] && \
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'

[ -x '/Applications/Adobe Reader.app/Contents/MacOS/AdobeReader' ] && \
    alias acroread='/Applications/Adobe\ Reader.app/Contents/MacOS/AdobeReader'

[ -x $HOME/bin/mvn.sh ] && alias mvn="$HOME/bin/mvn.sh"

if which pyenv >&/dev/null; then
    eval "$(pyenv init -)"
    if which pyenv-virtualenv >&/dev/null; then
        eval "$(pyenv virtualenv-init -)"
    fi
fi

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

    

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting