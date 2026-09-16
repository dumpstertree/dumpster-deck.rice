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
    hyprpm \
    rofi

mkdir -p ~/.config

rm -rf ~/.config/hypr
cp -r hypr ~/.config/hypr

rm -rf ~/.config/waybar
cp -r waybar ~/.config/waybar

rm -rf ~/.config/rofi
cp -r rofi ~/.config/rofi



# echo "Installing Applications"
sudo pacman -S --needed \
    kitty \
    librewolf \
    waybar \
    thunar \

 # hyprpm update
 
 # hyprpm add https://github.com/KZDKM/Hyprspace
 # hyprpm add https://github.com/hyprwm/hyprland-plugins/tree/main/hyprbars

 # hyprpm enable hyprspace
 # hyprpm enable hyprbars
 
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


