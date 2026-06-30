#!/bin/sh

# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

LOCAL=$(date '+%a %b %e %H:%M')
UTC=$(date -u '+%H:%M UTC')
sketchybar --set "$NAME" label="$LOCAL  $UTC"

