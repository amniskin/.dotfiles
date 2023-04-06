#!/bin/bash

# general settings and exports {{{
set -o vi

# export QT_SELECT=4

# fix "xdg-open fork-bomb" export your preferred browser from here
# export BROWSER=/usr/bin/chromium-browser
export EDITOR=vim
export TERM="xterm-256color"
export GPG_TTY=$(tty)

# enable color support of ls and also add handy aliases
# eval "$(dircolors -b ~/.dotfiles/home/.dir_colors)" || eval "$(dircolors -b)"
# to make new colors, run `dircolors -b ~/.dotfiles/dir_colors`
export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:';
export BOTO_DISABLE_COMMONNAME=true
export PATH="$HOME/.local/bin:$PATH"
export MANWIDTH=80

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

mp() {
	if [ ! -d "$2" ]; then
		mkdir -p $2
		echo "----"
		echo "making directory $2"
		echo "----"
	fi
	mv "$1" "$2"
}

mkcd() {
	if [ ! -d "$1" ]; then
		mkdir -p "$1" && cd "$1" && echo "Made new directory at $(pwd)"
	fi
}

# # ex - archive extractor
# # usage: ex <file>
ex () {
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

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTSIZE=1000
# shopt -s histappend
shopt -s checkwinsize
shopt -s expand_aliases

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

################# }}}

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f $HOME/.bash_aliases ]; then
	. $HOME/.bash_aliases
fi

# zerkenv {{{
export ZERKENV_BUCKET=amniskin-zerkenv-modules  # set this to your s3 bucket name
export ZERKENV_REGION=us-west-2
export ZERKENV_DIR=$HOME/.config/zerkenv  # optional: default is ~/.zerkenv
. <(zerkenv -i bash)

zerkload() {
  local OPTIND OPTARG o newshell=false
  while getopts "hn" o; do
    case "${o}" in
      h) echo "USAGE: zerkload [-hn] <module>..." ; return ;;
      n) newshell=true ;;
      ?) return 1 ;;
    esac
  done
  shift $((OPTIND-1))
  [ $# -eq 0 ] && return
  if $newshell; then
    eval "( zerkload $* ; exec $BASH )"
  else
    . <(colors=true zerkenv -d "$@")
  fi
}
_zerkenv() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  local ses=$(zerkenv -c "${COMP_WORDS[@]}")
  COMPREPLY=( $(compgen -W "$ses" -- $cur) )
}
_zerkload() {
  COMPREPLY=( $(compgen -W "-h -n $(zerkenv -l)" -- ${COMP_WORDS[COMP_CWORD]}) )
}
complete -F _zerkenv zerkenv
complete -F _zerkload zerkload
# }}}

# bash completion {{{
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
# 	if [ -f /usr/share/bash-completion/bash_completion ]; then
# 		. /usr/share/bash-completion/bash_completion
# 	elif [ -f /etc/bash_completion ]; then
# 		. /etc/bash_completion
# 	fi
# fi

# compDir="/usr/share/bash-completion/completions"
# if [ -d $compDir ]; then
# 	for file in $compDir/* ; do
# 		source $file 2> /dev/null
# 	done
# fi
# unset compDir

compDir="$HOME/.local/completions"
if [ -d $compDir ]; then
	for file in $compDir/* ; do
		source $file 2> /dev/null
	done
fi
unset compDir

complete -cf sudo

complete -o default -C $(which aws_completer) aws

if [ $(which kubectl) ]; then
  source <(kubectl completion bash)
fi

if [ -f /usr/bin/nomad ]; then
	complete -C /usr/bin/nomad nomad
fi

# ignore __pycache__ from autocomplete
export GLOBIGNORE="$GLOBIGNORE"__pycache__

### }}}
use_color=true

unset use_color safe_term match_lhs sh

# PS1 {{{
sep="\e[0m\e[1m|\e[0m"
_last_status_prompt() {
	local ret_stat=$?
	if [ $ret_stat = 0 ]; then
		echo -e "\e[32m^_^\e[0m"
	else
		echo -e "\e[31m\e[1mO_O $ret_stat\e[0m"
	fi
}

PS1="\$(_last_status_prompt)"

_active_conda_env(){
  echo ${CONDA_DEFAULT_ENV:-NA}
}
PS1="$PS1 $sep [\e[1;35m\$(_active_conda_env)\e[0m]"

PS1="$PS1 $sep \[\e[01;34m\]\w\[\e[0m\] $sep \e[36mjobs:\j \e[0m"

if [ $(which zerkenv) ]; then
	_zerkenv_prompt() {
		local out=""
		for e in $(zerkenv); do
			out="$out[\e[1;35m$e\e[0m]"
		done
		echo -e $out
	}
	PS1="$PS1 $sep \$(_zerkenv_prompt)"
fi

if [ -f ~/.dotfiles/bin/_bashgit.sh ]; then
	. ~/.dotfiles/bin/_bashgit.sh
fi
PS1="$PS1 $sep \$(_bashgit_prompt)"
PS1="$PS1\n\\$ "

unset sep

############ }}}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [ -f "$HOME/.bashrc.ext" ]; then
	source "$HOME/.bashrc.ext"
fi
