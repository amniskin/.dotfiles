#!/usr/bin/env bash

_bashgit_prompt() {
	retcode=$?
    local         red='\e[0;31m'
    local       green='\e[0;32m'
    local      yellow='\e[0;33m'
    local   dark_gray='\e[1;30m'
    local  light_gray='\e[1;37m'
    local  color_none='\e[0m'

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
                    branch=${BASH_REMATCH[2]}   # Current branch in capture group 2
                    [ "${BASH_REMATCH[8]}" ] && rs="+${BASH_REMATCH[8]}"   # Ahead in capture group 8
                    [ "${BASH_REMATCH[12]}" ] && rs="+${BASH_REMATCH[12]}" # .. or capture group 12
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
    [ "$noglob_orig" ] || set +f # Make sure to restore user\'s noglob option state

    if [ -z "$branch" ]; then
        # git invocation failed, likely not inside a git work tree, cancel prompt injection.
		local bashgit="(no git)"
		echo -e "$bashgit"
		exit $retcode
    elif [ "$branch" = HEAD ]; then
        # Unknown branch/detached HEAD, try git describe
        branch="$(git describe HEAD --always --tags 2>/dev/null)" || branch=HEAD
    fi

    local remote=
    if [ "$rs" ] && [ "$showremote" = true ]; then
        remote="|${light_gray}${rs}${state}"
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
	echo -e "$bashgit"
	exit $retcode
}

export _bashgit_prompt
