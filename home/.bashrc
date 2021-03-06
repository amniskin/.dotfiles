#!/bin/bash

set -o vi

# export QT_SELECT=4

# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/chromium-browser
export EDITOR=vim
export TERM="xterm-256color"
export GPG_TTY=$(tty)

# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# Don't know what it does yet {{{
##  xhost +local:root > /dev/null 2>&1

complete -cf sudo
#################}}}

# bash history {{{
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
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi

compDir="/usr/share/bash-completion/completions"
if [ -d $compDir ]; then
	for file in $compDir/* ; do
		source $file 2> /dev/null
	done
fi
unset compDir

# ignore __pycache__ from autocomplete
export GLOBIGNORE="$GLOBIGNORE"__pycache__

### }}}
use_color=true

unset use_color safe_term match_lhs sh
############ }}}

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

if [ ! -z $(which conda) ]; then
	_active_conda_env(){
		echo $CONDA_DEFAULT_ENV
	}
	PS1="$PS1 $sep [\e[1;35m\$(_active_conda_env)\e[0m]"
fi

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
