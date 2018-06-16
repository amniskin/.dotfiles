# export QT_SELECT=4

##  # Enable history appending instead of overwriting.  #139609
##  shopt -s histappend

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

# fix "xdg-open fork-bomb" export your preferred browser from here
export BROWSER=/usr/bin/chromium
export EDITOR=vim
export TERM="xterm-256color"
# export COLORTERM="rxvt-256color"


# If not running interactively, don't do anything
case $- in
	*i*) ;;
	*) return;;
esac

# Don't know what it does yet {{{
##  xhost +local:root > /dev/null 2>&1

##  complete -cf sudo
#################}}}

# bash history {{{
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
HISTSIZE=1000
shopt -s histappend
shopt -s checkwinsize
shopt -s expand_aliases

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

################# }}}

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# PS1 {{{

# force_color_prompt=yes

PS1=""

### git status in command prompt
if [ -f ~/.dotfiles/bin/bashgit.sh ]; then
	. ~/.dotfiles/bin/bashgit.sh
fi

case "$TERM" in
	xterm-color) color_prompt=yes;;
	*256color*) color_prompt=yes;;
	screen) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

psTxt="\W"

if [ "$color_prompt" = yes ]; then
	# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
	PS1="$PS1\[\e[01;34m\]$psTxt\[\e[0m\]"
else
	#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
	PS1="$PS1$psTxt"
fi

PS1="$PS1\$ "
unset color_prompt force_color_prompt psTxt

##  # If this is an xterm set the title to user@host:dir
##  case "$TERM" in
##  	xterm*|rxvt*)
##  		# PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
##  		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
##  		;;
##  	*)
##  		;;
##  esac

############ }}}



if [ -f ~/.dotfiles/home/.bash_aliases ]; then
	. ~/.dotfiles/home/.bash_aliases
fi

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

# changing window titles {{{
# Change the window title of X terminals
##  case ${TERM} in
##  	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
##  		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
##  		;;
##  	screen*)
##  		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
##  		;;
##  esac

##  use_color=true
##  
##  # Set colorful PS1 only on colorful terminals.
##  # dircolors --print-database uses its own built-in database
##  # instead of using /etc/DIR_COLORS.  Try to use the external file
##  # first to take advantage of user additions.  Use internal bash
##  # globbing instead of external grep binary.
##  safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
##  match_lhs=""
##  [[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
##  [[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
##  [[ -z ${match_lhs}    ]] \
##  	&& type -P dircolors >/dev/null \
##  	&& match_lhs=$(dircolors --print-database)
##  [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true
##  
##  if ${use_color} ; then
##  	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
##  	if type -P dircolors >/dev/null ; then
##  		if [[ -f ~/.dir_colors ]] ; then
##  			eval $(dircolors -b ~/.dir_colors)
##  		elif [[ -f /etc/DIR_COLORS ]] ; then
##  			eval $(dircolors -b /etc/DIR_COLORS)
##  		fi
##  	fi
##  fi
##  
##  unset use_color safe_term match_lhs sh
##  



############ }}}



### path  {{{
export PATH="$PATH:~/.local/bin:~/.gem/ruby/2.5.0/bin"

### }}}
