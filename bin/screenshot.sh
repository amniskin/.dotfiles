#!/usr/bin/env bash
WINDOW=$1

STAMP=$(date +"%Y-%m-%d_%H:%M");

if [ $WINDOW -eq "-w" ]
	gnome-screenshot -w -f ~/Pictures/Screenshots/windowshot-$STAMP.png
else
	gnome-screenshot -f ~/Pictures/Screenshots/screenshot-$STAMP.png
