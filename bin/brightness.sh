#!/bin/bash

max=$(cat /sys/class/backlight/intel_backlight/max_brightness)
current=$(cat /sys/class/backlight/intel_backlight/brightness)
current_pct=$(printf %.0f $(echo "scale=3; $current * 100 / $max" | bc))

upper() {
  if [ $current_pct -lt 0 ]; then
    new_pct=0
  elif [ $current_pct -lt 10 ]; then
    new_pct=$(($current_pct + 1))
  elif [ $current_pct -lt 20 ]; then
    new_pct=$(($current_pct + 2))
  elif [ $current_pct -lt 50 ]; then
    new_pct=$(($current_pct + 5))
	elif [ $current_pct -lt 90 ]; then
    new_pct=$(($current_pct + 10))
  else
		new_pct=100
  fi
	echo $new_pct
}

downer() {
  if [ $current_pct -le 0 ]; then
    new_pct=0
  elif [ $current_pct -le 10 ]; then
    new_pct=$(($current_pct - 1))
  elif [ $current_pct -le 20 ]; then
    new_pct=$(($current_pct - 2))
  elif [ $current_pct -le 50 ]; then
    new_pct=$(($current_pct - 5))
	elif [ $current_pct -le 90 ]; then
    new_pct=$(($current_pct - 10))
  else
		new_pct=90
  fi
	echo $new_pct
}

case $1 in
  +) new_pct=$(upper $current_pct) ;;
  -) new_pct=$(downer $current_pct) ;;
  *) echo $current_pct && exit 0;;
esac

echo "$current_pct% ==> $new_pct%"
change_to=$(echo "1 + (($new_pct * $max - 1) / 100.0)" | bc)
### I didn't want to figure out what was going on with the sudoers file
cat ~/.dotfiles/passwd | \
  sudo -S sh -c "echo $change_to > /sys/class/backlight/intel_backlight/brightness"

exit 0
