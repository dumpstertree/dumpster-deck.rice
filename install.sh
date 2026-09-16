#!/bin/bash

set -e

sudo pacman -Syu

echo "Installing Hyprland Ecosystem"
sudo pacman -S --needed \
    hyprland \
    hyprpaper \
    hyprlock \
    hypridle \
    hyprlauncher

mkdir -p ~/.config

rm -rf ~/.config/hypr
cp -r hypr ~/.config/hypr

rm -rf ~/.config/sway
cp -r ./sway ~/.config/sway


# echo "Installing Applications"
sudo pacman -S --needed \
    kitty \
    librewolf \
    waybar \
    thunar \

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


