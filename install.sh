#!/bin/bash

set -e

sudo pacman -Syu

echo "Installing Hyprland Ecosystem"
sudo pacman -S --needed \
    hyprland \
    hyprpaper \
    hyprlock \
    hypridle \
    hyprsunset \
    hyprpm \
    rofi \
    fastfetch \
    kitty \
    librewolf \
    waybar \
    thunar \

mkdir -p ~/.config

rm -rf ~/.config/hypr
cp -r hypr ~/.config/hypr

rm -rf ~/.config/waybar
cp -r waybar ~/.config/waybar

rm -rf ~/.config/rofi
cp -r rofi ~/.config/rofi

rm -rf ~/.config/kitty
cp -r rofi ~/.config/kitty

rm -rf ~/.bashrc
cp -r .bashrc ~/.bashrc

rm -rf ~/.local/share/applications/rice
cp -r .local/share/applications ~/.local/share/applications/rice


# echo "Installing Applications"

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


