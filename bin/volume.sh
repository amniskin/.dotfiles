#!/usr/bin/env bash

case "$1" in
	"capped")
		case "$2" in
			"up")
        RESULT_=$(amixer -D pulse set Master nocap 5%+)
				;;
			"down")
        RESULT_=$(amixer -D pulse set Master nocap 5%-)
				;;
		esac
    RESULT=$(echo $RESULT_ | sed -E 's/.*\[([0-9]{,3})\%\].*/\1/g')
    ;;
	"uncapped")
		SINK=$(pactl list short sinks |grep RUNNING |awk '{print $1}')
    echo $SINK
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

echo "set to $RESULT"
