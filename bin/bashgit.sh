# Simple colored git branch status in Bash prompt.
# Version: 1.1
#
# Requires Git >= 1.7.2, Bash and terminal with color support. This file should
# be source'd from ~/.bashrc or similar *after* your initial PS1 prompt setup.
# It may not be able to inject status before your prompt suffix ('$ ', etc),
# depending on use of colors and non-standard formatting. In that case, the git
# status is simply appended.
#
# Tries to be reasonably efficient by minimizing git calls (forks) and using
# shell builtins.
#
# Displays color coded name of current branch (or best description if detached
# HEAD or tag), and optionally number of commits ahead/behind a remote tracking
# branch. Green for clean, red for uncomitted changes etc., yellow for work tree
# modifications and/or unknowns. Does branch name truncation to keep prompt from
# growing too much.
#
# Examples: [master|1,-2]          # 1 ahead, 2 behind remote tracking branch
#           [bug/branch-na..]      # truncated form for branch "bugfix/branch-name".
#
# The following git config options are understood by bashgit:
# - bashgit.showremote    (boolean) show remote ahead/behind status in prompt or not
# - bashgit.branchlimit   (integer) max branch name length in prompt
# - bashgit.untracked     (boolean) include untracked files as dirty state, false
#                         gives better performance with large repositories.
#
# Author: Øyvind Stegard <oyvind.stegard@ifi.uio.no>

# Globals
declare _BASHGIT_PS1_ORIG    # Original PS1
declare _BASHGIT_PS1_PREV    # Previous PS1, may include injected bashgit status.

_bashgit_update_ps1() {
    type git &>/dev/null || return 1

    local         red='\[\e[0;31m\]'
    local       green='\[\e[0;32m\]'
    local      yellow='\[\e[0;33m\]'
    local   dark_gray='\[\e[1;30m\]'
    local  color_none='\[\e[0m\]'

    if [ -z "${_BASHGIT_PS1_PREV+x}" ] || [ "$PS1" != "$_BASHGIT_PS1_PREV" ]; then
        _BASHGIT_PS1_ORIG=$PS1
        _BASHGIT_PS1_PREV=$PS1
    fi

    local IFS=$'\n' line state="$green" branch= rs= pattern noglob_orig=
    [ "${-/f}" = "$-" ] && set -f || noglob_orig=1

    # User options
    local untracked=true untracked_param=normal showremote=true branchlimit=22
    for line in $(git config --get-regexp '^bashgit\.' 2>/dev/null); do
        case $line in
            'bashgit.untracked '*) untracked=${line#* } ;;
            'bashgit.branchlimit '*) branchlimit=${line#* } ;;
            'bashgit.showremote '*) showremote=${line#* } ;;
        esac
    done
    [ "$untracked" = false ] && untracked_param=no

    # Invoke git status and extract info
    for line in $(git status --porcelain -bs -u${untracked_param} 2>/dev/null); do
        case $line in
            [\ ?][MD?]' '*)
                state="$yellow" # Work tree changes and/or untracked files
                # Have to keep scanning, because "red" state items may appear later in output
                ;;
            '## '*)
                pattern='^## (Initial commit on )?((\.?[^ .])+)(\.\.\.([^ ]+) *(\[(ahead ([0-9]+)|(behind ([0-9]+))|(ahead ([0-9]+), behind ([0-9]+)))\])?)?'
                if [[ $line =~ $pattern ]]; then
                    branch=${BASH_REMATCH[2]}                             # Current branch in capture group 2
                    [ "${BASH_REMATCH[8]}" ] && rs=${BASH_REMATCH[8]}     # Ahead in capture group 8
                    [ "${BASH_REMATCH[12]}" ] && rs=${BASH_REMATCH[12]}   # .. or capture group 12
                    [ "${BASH_REMATCH[10]}" ] && rs="${rs:+$rs,}-${BASH_REMATCH[10]}" # Behind in capture group 10
                    [ "${BASH_REMATCH[13]}" ] && rs="${rs:+$rs,}-${BASH_REMATCH[13]}" # .. or capture group 13
                fi
                ;;
            [MARCDU]?' '*)
                state="$red"
                break
                ;;
        esac
    done
    IFS=$' \t\n'
    [ "$noglob_orig" ] || set +f # Make sure to restore user's noglob option state

    if [ -z "$branch" ]; then
        # git invocation failed, likely not inside a git work tree, cancel prompt injection.
        [ "$_BASHGIT_PS1_ORIG" ] && PS1=$_BASHGIT_PS1_ORIG
        return 2
    elif [ "$branch" = HEAD ]; then
        # Unknown branch/detached HEAD, try git describe
        branch="$(git describe HEAD --always --tags 2>/dev/null)" || branch=HEAD
    fi

    local remote=
    if [ "$rs" ] && [ "$showremote" = true ]; then
        remote="|${dark_gray}${rs}${state}"
    fi

    # Branch name truncation
    if [ $branchlimit -gt 0 ] 2>/dev/null && [ ${#branch} -gt $branchlimit ]; then
        pattern='^([^/]*)/(.*)$'
        if [[ ${branch} =~ $pattern ]]; then
            local branch_prefix=${BASH_REMATCH[1]}
            local branch_name=${BASH_REMATCH[2]}
            if [ ${#branch_prefix} -gt 3 ]; then
                branch="${branch_prefix:0:3}/${branch_name}"
            fi
        fi
        if [ ${#branch} -gt $branchlimit ]; then
            branch="${branch:0:${branchlimit}}.."
        fi
    fi

    # Update current PS1
    local bashgit="${state}[${branch}${remote}]${color_none}"
    case $_BASHGIT_PS1_ORIG in
        *'\$ ') PS1="${_BASHGIT_PS1_ORIG%\\\$ }${bashgit}\\\$ " ;;
        *'$ ') PS1="${_BASHGIT_PS1_ORIG%\$ }${bashgit}\$ " ;;
        *'# ') PS1="${_BASHGIT_PS1_ORIG%# }${bashgit}# " ;;
        *'% ') PS1="${_BASHGIT_PS1_ORIG%[%] }${bashgit}% " ;;
        *'> ') PS1="${_BASHGIT_PS1_ORIG%> }${bashgit}> " ;;
        *) PS1="${_BASHGIT_PS1_ORIG}${bashgit} " ;;
    esac
    _BASHGIT_PS1_PREV=$PS1
}

# Invoke git status before prompt display:
if [ "${PROMPT_COMMAND//_bashgit_update_ps1}" = "$PROMPT_COMMAND" ]; then
    PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND%;}; }_bashgit_update_ps1;"
fi
