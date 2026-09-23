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
    cava \
    pipewire-pulse \ 
    wireplumber \
    keyd \
    grim \
    slurp \
    dunst \
    libnotify \
    gnome-system-monitor

systemctl --user enable --now dunst  

mkdir -p ~/.config

rm -rf ~/.local/bin/screenshot
cp -r bin/screenshot ~/.local/bin/screenshot

chmod +x ~/.local/bin/screenshot


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

rm -rf /etc/keyd/default.conf
cp keyd.conf /etc/keyd/default.conf

sudo systemctl enable --now keyd


rm -rf ~/.local/share/applications/rice
cp -r .local/share/applications ~/.local/share/applications/rice

chmod +x ~/.config/rofi/scripts/*.sh

git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer

sudo auto-cpufreq --install
systemctl enable --now auto-cpufreq

# remove thunar-bulk-rename
cp /usr/share/applications/thunar-bulk-rename.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/thunar-bulk-rename.desktop

# remove thunar
cp /usr/share/applications/thunar.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/thunar.desktop

# remove librewolf
cp /usr/share/applications/librewolf.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/librewolf.desktop

# remove rofi application
cp /usr/share/applications/rofi.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/rofi.desktop

# remove rofi-theme-selector
cp /usr/share/applications/rofi-theme-selector.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/rofi-theme-selector.desktop

# remove thunar application
cp /usr/share/applications/avahi-discover.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/avahi-discover.desktop

# remove thunar application
cp /usr/share/applications/btrfs-assistant.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/btrfs-assistant.desktop

# remove thunar application
cp /usr/share/applications/xgps.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/xgps.desktop

# remove thunar application
cp /usr/share/applications/xgpsspeed.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/xgpsspeed.desktop

cp /usr/share/applications/thunar-settings.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/thunar-settings.desktop

cp /usr/share/applications/qv4l2.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/qv4l2.desktop

cp /usr/share/applications/qvidcap.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/qvidcap.desktop

cp /usr/share/applications/cmake-gui.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/cmake-gui.desktop


cp /usr/share/applications/org-gnome-SystemMonitor.desktop ~/.local/share/applications/
sed -i '/^\[Desktop Entry\]$/a Hidden=true' ~/.local/share/applications/org-gnome-SystemMonitor.desktop



# need to install zsh first
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions


