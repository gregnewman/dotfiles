#!/bin/sh
FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null)
[ -n "$FOCUSED" ] && sketchybar --trigger aerospace_workspace_change FOCUSED="$FOCUSED"
