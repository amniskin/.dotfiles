#!/usr/bin/env bash

SINK=$(pactl list short sinks |grep RUNNING |awk '{print $1}')

if [ -n "$SINK" ]; then
  case "$1" in
    "up")
      pactl set-sink-volume $SINK +5%
      ;;
    "down")
      pactl set-sink-volume $SINK -5%
      ;;
    "mute")
      pactl set-sink-mute $SINK toggle
      ;;
  esac
fi
