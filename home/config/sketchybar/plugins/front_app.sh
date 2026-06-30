#!/usr/bin/env bash

if [ "$SENDER" = "front_app_switched" ]; then
  source "$CONFIG_DIR/icon_map.sh"
  __icon_map "$INFO"
  sketchybar --set "$NAME" icon="$icon_result" label="$INFO"
fi
