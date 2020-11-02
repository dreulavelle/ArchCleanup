#!/bin/bash

# Updating Mirrors
echo "Updating Mirrors"
curl -vs "https://www.archlinux.org/mirrorlist/?use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -vn 0 - > ~/mirrors.txt
sudo cp ~/mirrors.txt /etc/pacman.d/mirrorlist

# Running initial updates 
echo "Updating System"
sudo pacman -Syu

# Remove Orphaned files
echo "Removing Orphans"
sudo pacman -Rns $(pacman -Qtdq)

# Optimize Pacman database and servers
echo "Optimize Pacman"
sudo pacman-optimize

# Remove Bloatware Apps
echo "Removing Bloat Apps"
sudo pacman -Rsu konsole xfce4-terminal fontforge

# Install Yay (AUR package manager)
echo "Installing Yay"
sudo pacman -S git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
yay -Syu

# Install Apps (customize this list before running!)
echo "Installing Your Apps"
sudo pacman -S terminator kodi zsh zsh-autosuggestions zsh-syntax-highlighting
echo "Installing Recommended Apps"
sudo pacman -S vlc libreoffice p7zip p7zip-plugins unrar tar rsync git

# Install Google Chrome
echo "Installing Chrome"
yay -S google-chrome

# Tidying Up
echo "Tidying up a little"
rm -rf ~/.cache/*
rm -f ~/.local/share/RecentDocuments/*
rm -f ~/rmlint.*

# Install zsh
sudo pacman -S zsh

# Install powerlevel10k
yay -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc