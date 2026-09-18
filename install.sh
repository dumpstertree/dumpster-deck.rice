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

rm -rf ~/.config/fastfetch
cp -r fastfetch ~/.config/fastfetch

rm -rf ~/.bashrc
cp -r .bashrc ~/.bashrc

rm -rf ~/.zshrc
cp -r .zshrc ~/.zshrc


rm -rf ~/.local/share/applications/rice
cp -r .local/share/applications ~/.local/share/applications/rice

chmod +x ~/.config/rofi/scripts/*.sh

git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer

sudo auto-cpufreq --install
systemctl enable --now auto-cpufreq

# need to install zsh first
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions


