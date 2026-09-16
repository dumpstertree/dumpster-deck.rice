#!/bin/bash

set -e

sudo pacman -Syu

echo "Installing Hyprland Ecosystem"
sudo pacman -S --needed \
    hyprland \
    hyprpaper \
    hyprlock \
    hypridle \
    hyprlauncher \
    hyprpm

mkdir -p ~/.config

rm -rf ~/.config/hypr
cp -r hypr ~/.config/hypr

rm -rf ~/.config/waybar
cp -r waybar ~/.config/waybar




# echo "Installing Applications"
sudo pacman -S --needed \
    kitty \
    librewolf \
    waybar \
    thunar

# hyprpm update
# hyprpm add https://github.com/gfhdhytghd/hymission
# hyprpm enable hymission
# hyprpm reload

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


