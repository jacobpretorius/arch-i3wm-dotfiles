#!/bin/bash

BRIGHTNESS_FILE="/sys/class/backlight/amdgpu_bl1/brightness"
MAX_BRIGHTNESS_FILE="/sys/class/backlight/amdgpu_bl1/max_brightness"

if [ -f "$BRIGHTNESS_FILE" ] && [ -f "$MAX_BRIGHTNESS_FILE" ]; then
    current=$(cat "$BRIGHTNESS_FILE")
    max=$(cat "$MAX_BRIGHTNESS_FILE")
    percent=$((current * 100 / max))
    echo "💡 ${percent}%"
else
    echo "💡 N/A"
fi
