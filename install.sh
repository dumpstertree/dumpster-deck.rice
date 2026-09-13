#!/bin/bash

set -e

pacman -Syu

echo "Installing Hyprland Ecosystem"
sudo pacman -S --needed \
    hyprland \
    hyprpaper \
    hyprlock \
    hypridle \
    hyprlauncher


mkdir -p ~/.config

cp -r hypr ~/.config/


# echo "Installing Applications"
# sudo pacman -S --needed \
#     waybar \
#     kitty \
#     thunar \
#     librewolf

# echo "Installing System Dependencies"
# sudo pacman -S --needed \
#     mako \
#     wl-clipboard \
#     grim \
#     slurp \
#     brightnessctl \
#     pipewire \
#     wireplumber \
#     NetworkManager 

# echo "Installing Hyprland Plugins"

# echo "Linking Configs"


