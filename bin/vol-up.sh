#!/usr/bin/env bash

# cd ~/.bash/bin/notes; aplay $(ls | shuf -n 1);
# aplay /usr/share/sounds/freedesktop/stereo/dialog-information.oga;
amixer -D pulse set Master nocap 5%+; #increase sound volume
