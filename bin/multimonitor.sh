#!/usr/bin/env bash

dp2="$(cat /sys/class/drm/card0-DP-2/status)"

if [ $dp2 = "connected" ]
then
	xrandr --output eDP-1 --auto --primary --output DP-2 --auto --right-of eDP-1
else
	xrandr --output eDP-1 --auto --primary --output DP-2 --off
fi
