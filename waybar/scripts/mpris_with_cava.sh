#!/usr/bin/env bash
# This is a simple example — polling playerctl for artist/title and reading cava output
while true; do
  artist=$(playerctl metadata --format "{{artist}}" 2>/dev/null)
  title=$(playerctl metadata --format "{{title}}" 2>/dev/null)
  # short cavastub: replace with real cava parsing or `~/.config/waybar/scripts/cava_wrapper.sh`
  cava="|||" 
  echo " ${artist} - ${title} ${cava}"
  sleep 1
done
