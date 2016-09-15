#!/usr/bin/env bash

STAMP=$(date +"%Y-%m-%d_%H:%M");

gnome-screenshot -w -f ~/Pictures/Screenshots/$STAMP.png
