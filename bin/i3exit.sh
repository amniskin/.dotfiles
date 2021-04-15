#!/usr/bin/env bash

case "$1" in
	lock)
    i3lock -n -ti /home/amniskin/Pictures/black_white_background_theTree.png
		;;
	logout)
		i3-msg exit
		;;
	suspend)
		gksu pm-suspend
		;;
	hibernate)
		systemctl hibernate
		;;
	reboot)
		systemctl reboot
		;;
	shutdown)
		#dbus-send --system --print-reply --dest="org.freedesktop.ConsoleKit" /org/freedesktop/ConsoleKit/Manager org.freedesktop.ConsoleKit.Manager.Stop
		/sbin/poweroff
		;;
	*)
		echo "Usage: $0 {lock|logout|suspend|hibernate|reboot|shutdown}"
		exit 2
esac

exit 0
