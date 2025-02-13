#!/bin/bash

volume_info=$(pactl get-sink-volume @DEFAULT_SINK@ | head -n1)
mute_info=$(pactl get-sink-mute @DEFAULT_SINK@)

if [[ $volume_info =~ ([0-9]+)% ]]; then
    volume="${BASH_REMATCH[1]}"
else
    volume="?"
fi

if [[ $mute_info == *"yes"* ]]; then
    echo "🔇 Muted"
else
    echo "🔊 ${volume}%"
fi
