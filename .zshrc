# if whence -p dircolors >/dev/null ; then
#     # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
#     LS_COLORS=
#     if [[ -f ~/.dir_colors ]] ; then
#         # Make sure that .dir_colors has an entry "TERM=dumb" for Emacs' M-x shell
#         eval "$(dircolors -b ~/.dir_colors)"
#     elif [[ -f /etc/DIR_COLORS ]] ; then
#         eval "$(dircolors -b /etc/DIR_COLORS)"
#     else
#         eval "$(dircolors -b)"
#     fi
#     # Note: We always evaluate the LS_COLORS setting even when it's the
#     # default.  If it isn't set, then `ls` will only colorize by default
#     # based on file attributes and ignore extensions (even the compiled
#     # in defaults of dircolors). #583814
#     if [[ -n ${LS_COLORS:+set} ]] ; then
#         use_color=true
#     else
#         # Delete it if it's empty as it's useless in that case.
#         unset LS_COLORS
#     fi
# else
#     # Some systems (e.g. BSD & embedded) don't typically come with
#     # dircolors so we need to hardcode some terminals in here.
#     case ${TERM} in
#         dumb|eterm*|[aEkx]term*|rxvt*|gnome*|konsole*|screen|cons25|*color)
#             use_color=true
#         ;;
#     esac
# fi


if ls --color=auto >/dev/null 2>&1; then
    # Some old ls(1) does not support "--color" option.
    alias ls="ls --color=auto"
    PS1='%B%F{green}%m%F{default}%b:%B%F{blue}%~%(?.%F{green}.%F{red})%#%f%b '
else
    PS1='%m:%~%# '
fi

