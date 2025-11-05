#!/bin/bash

# Detect monitors
monitors=$(hyprctl monitors -j | jq -r '.[].name' | sort)
# desc of laptop monitor
LAPTOP_DESC="BOE 0x0A1C"

laptop=$(hyprctl monitors -j | jq --arg laptop "$LAPTOP_DESC" -r '.[] | select(.description | contains($laptop)) | .name')
external=$(echo "$monitors" | grep -v "$laptop" || echo "")

if [ -z "$external" ]; then
  # Only laptop: all workspaces on laptop
  hyprctl keyword workspace 1,monitor:$laptop
  for i in {1..9}; do
    hyprctl keyword workspace $i,monitor:$laptop
  done
else
  # Dual monitor: laptop → workspace 10, external → workspaces 1-9
  hyprctl keyword workspace 10,monitor:$laptop,default:true
  for i in {1..9}; do
    hyprctl keyword workspace $i,monitor:$external
  done
  # this fixes bug with waybar where it shows 9 instances on external monitor
  # when plugging a second monitor
  # TODO: find a better fix
  sleep .5
  killall -SIGUSR2 waybar
fi
