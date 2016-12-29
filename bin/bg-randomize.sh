#!/usr/bin/env bash

digit=$(($RANDOM % 10))
echo $digit
rootdir="/media/amniskin/Samsung USB/Pictures"

if [ $digit -gt 0 ]
then
	feh --randomize --bg-scale "$rootdir"/Wallpapers/*
else
  feh --randomize --bg-scale "$rootdir"/My-Best/*
fi

#feh --randomize --bg-scale $FLDR #~/Pictures/Wallpapers/*
