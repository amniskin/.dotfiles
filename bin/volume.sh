#!/usr/bin/env bash

case "$1" in
	"capped")
		case "$2" in
			"up")
				amixer -D pulse set Master nocap 5%+
				;;
			"down")
				amixer -D pulse set Master nocap 5%-
				;;
		esac ;;
	"uncapped")
		SINK=$(pactl list short sinks |grep RUNNING |awk '{print $1}')
		if [ -n "$SINK" ]; then
			case "$2" in
				"up")
					pactl set-sink-volume $SINK +5%
					;;
				"down")
					pactl set-sink-volume $SINK -5%
					;;
			esac;
		fi ;;
	"mute")
		amixer -D pulse set Master toggle
		;;
esac
