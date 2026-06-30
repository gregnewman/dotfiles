#!/bin/sh
CPU=$(top -l 2 -n 0 | awk '/CPU usage/ {print $3}' | tail -1 | tr -d '%')
RATIO=$(echo "scale=4; $CPU / 100" | bc)
sketchybar --set "$NAME" label="${CPU}%" \
           --push "$NAME" "$RATIO"
