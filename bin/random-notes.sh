#!/usr/bin/env bash

cd ~/.bash/bin/notes; aplay $(ls | shuf -n 1);
amixer -D pulse sset Master 5%-; #increase sound volume
