# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias less='less -R'
alias tree='tree -C'

# some more ls aliases
alias ll='ls -alF --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto'
alias la='ls -A'
alias lal='ls -lAh --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias l='ls -CF'

alias cp="cp -i"     # confirm before overwriting something
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB
# alias np='nano -w PKGBUILD'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
