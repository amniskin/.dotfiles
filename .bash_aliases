# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias newterm='i3-sensible-terminal'

alias apt-up='sudo apt-get update && sudo apt-get upgrade'

alias git-up='git add --all && git commit'


alias j-pdf='jupyter nbconvert --to=pdf --template=latex.tplx'

alias cdd='cd /media/amniskin/Samsung\ USB/courses/2016-7_spring/'

# for a decent nautilus in i3
alias nauti='nautilus --no-desktop --new-window'


# Enhanced mv command
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

# mkdir and cd
function mkcd ()
{
	if [ ! -d "$1" ]; then
		mkdir "$1" && echo "Made new directory at " $(pwd)"/$1" && cd "$1"
	fi
}

# Jupyter-notebooks but opens new browser window first.
alias jupnot='chromium-browser && jupyter-notebook'
