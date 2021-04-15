# enable color support of ls and also add handy aliases
eval "$(dircolors -b ~/.dotfiles/home/.dir_colors)" || eval "$(dircolors -b)"

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

alias skype='chromium --app=https://web.skype.com'

function mp ()
{
	if [ ! -d "$2" ]; then
		mkdir -p $2
		echo "----"
		echo "making directory $2"
		echo "----"
	fi
	mv "$1" "$2"
}
function mkcd ()
{
	if [ ! -d "$1" ]; then
		mkdir -p "$1" && cd "$1" && echo "Made new directory at $(pwd)"
	fi
}

# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
export PYTHONPATH="$PYTHONPATH:$HOME/.pylibs/"


# Ruby exports
#
export GEM_HOME=$HOME/gems
export PATH=$HOME/gems/bin:$PATH

complete -C $(which aws_completer) aws

export PATH="$HOME/.bin:$PATH:$HOME/.local/bin:$HOME/.gem/ruby/2.5.0/bin"
export MANWIDTH=80
