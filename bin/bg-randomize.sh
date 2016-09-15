#!/usr/bin/env bash

BIT=$(($RANDOM % 2))
echo $BIT

if [ $BIT -gt 0 ]
then
  feh --randomize --bg-scale ~/Pictures/My-Best/*
else
  feh --randomize --bg-scale ~/Pictures/Wallpapers/*
fi

#feh --randomize --bg-scale $FLDR #~/Pictures/Wallpapers/*
