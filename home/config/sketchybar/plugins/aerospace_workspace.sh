#!/bin/sh
WS="${NAME#ws.}"
# Use the workspace AeroSpace passed with the trigger; only query when it's
# missing (e.g. on `sketchybar --update`) to avoid racing the AeroSpace server.
CURRENT="${FOCUSED:-$(/opt/homebrew/bin/aerospace list-workspaces --focused 2>/dev/null)}"
if [ "$WS" = "$CURRENT" ]; then
  sketchybar --set "$NAME" background.drawing=on \
                           background.color=0xff52b788 \
                           icon.color=0xff000000
else
  sketchybar --set "$NAME" background.drawing=off \
                           icon.color=0x88ffffff
fi
