#!/usr/bin/env bash

amixer -D pulse set Master toggle;    #mute or unmute sound
# cd ~/.bash/bin/notes; aplay $(ls | shuf -n 1); #play pseudo-random sound
