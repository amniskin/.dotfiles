#!/usr/bin/env bash

get_set=$(echo $1 | tr '[:upper:]' '[:lower:]')
max=$(cat /sys/class/backlight/intel_backlight/max_brightness)

function getter {
	current=$(cat /sys/class/backlight/intel_backlight/brightness)
	retVal=$(printf %.0f $(echo "scale=3; $current * 100 / $max" | bc))
	echo $retVal
}

function setter {
	pct=$1
	change_to=$(echo "1 + (($pct * $max - 1) / 100.0)" | bc)
	### The following cat-sudo nonsense is a horrible hack,
	### but I didn't want to figure out what was going on with the sudoers file
	cat ~/.dotfiles/passwd | sudo -S sh -c "echo $change_to > /sys/class/backlight/intel_backlight/brightness"
}


function upper () {
	current_pct=$1
	if [ $current_pct -ge 90 ]
	then
		new_pct=100
	elif [ $current_pct -lt 50 ]
	then
		if [ $current_pct -lt 20 ]
		then
			if [ $current_pct -lt 10 ]
			then
				if [ $current_pct -lt 0 ]
				then
					new_pct=0
				else
					new_pct=$(($current_pct + 1))
				fi
			else
				new_pct=$(($current_pct + 2))
			fi
		else
			new_pct=$(($current_pct + 5))
		fi
	else
		new_pct=$(($current_pct + 10))
	fi
	echo $new_pct
}

function downer {
	current_pct=$1
	if [ $current_pct -le 50 ]
	then
		if [ $current_pct -le 20 ]
		then
			if [ $current_pct -le 10 ]
			then
				if [ $current_pct -le 1 ]
				then
					new_pct=0
				else
					new_pct=$(($current_pct - 1))
				fi
			else
				new_pct=$(($current_pct - 2))
			fi
		else
			new_pct=$(($current_pct - 5))
		fi
	else
		new_pct=$(($current_pct - 10))
	fi
	echo $new_pct
}

if [ $get_set == "get" ]
then
	getter
elif [ $get_set == "set" ]
then
	direction=$(echo $2 | tr '[:upper:]' '[:lower:]')
	current_pct=$(getter)
	if [ $direction == "val" ]
	then
		new_pct=$3
		setter $new_pct
		echo "NULL ==> $new_pct%"
	elif [ $direction == "up" ]
	then
		new_pct=$(upper $current_pct)
		setter $new_pct
		echo "$current_pct% ==> $new_pct%"
	elif [ $direction == "down" ]
	then
		new_pct=$(downer $current_pct)
		setter $new_pct
		echo "$current_pct% ==> $new_pct%"
	else
		echo Unknown parameter $direction. Should be either \"VAL\", \"UP\", or \"DOWN\".
	fi
else
	echo Unknown parameter $get_set. Should be either \"GET\" or \"SET\".
	exit 1
fi
exit 0
