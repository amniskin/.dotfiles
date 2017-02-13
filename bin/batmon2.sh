#!/usr/bin/env bash

THRESHOLD=35 # percent

batmon_log='/tmp/batmon.log'
lock_path='/tmp/batmon.lock'
log_message="batmon.sh - file lock succeeded on $(date '+%d/%m/%Y %H:%M:%S')"

#lockfile -r 0 $lock_path 2>/dev/null || exit
flock -n $lock_path echo $log_message > /dev/null || exit

acpi_path=$(find /sys/class/power_supply/ -name 'BAT0' | head -1)
energy_now=$(cat "$acpi_path/energy_now")
energy_full=$(cat "$acpi_path/energy_full_design")
energy_status=$(cat "$acpi_path/status")
energy_percent=$(printf '%.0f' $(echo "$energy_now / $energy_full * 100" | bc -l))

if [[ $energy_status != 'Charging' ]] && [[ $energy_percent -le $THRESHOLD ]]; then
# if [[ $energy_status != 'Charging' ]] && [[ $energy_percent -le $THRESHOLD ]]; then
	paplay --volume=65536 -p /usr/share/sounds/gnome/default/alerts/bark.ogg
	DISPLAY=:0.0 /usr/bin/i3-nagbar -t warning -m "Battery running critically low at $energy_percent%!"
fi

rm -f $lock_path
