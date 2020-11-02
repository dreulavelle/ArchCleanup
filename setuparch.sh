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
sudo yay -Syu
sudo yay -Yc

# Install Apps (customize this list before running!)
echo "Installing Your Apps"
sudo pacman -S terminator kodi zsh zsh-autosuggestions zsh-syntax-highlighting
echo "Installing Recommended Apps"
sudo pacman -S vlc libreoffice p7zip p7zip-plugins unrar tar rsync git neofetch

# Install Google Chrome
echo "Installing Chrome"
yay -S google-chrome

# Install Spotify (from source - takes a second or two..)
echo "Installing Spotify"
sudo pacman -S fakeroot
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -
yay -S spotify

# Install zsh + powerlevel10k
echo "Installing Zsh + p10k"
sudo pacman -S zsh
yay -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>! ~/.zshrc
sudo chsh $user -s /bin/zsh

# Installing Meslo NF Fonts
echo "Installing Meslo NF Fonts"
cp assets/fonts/Meslo* /usr/share/fonts

# Configuring Zsh
echo "Adding Zsh Config"
rm -f ~/.zshrc
cp Configs/zsh.zshrc ~/.zshrc

# Configuring Neofetch
echo "Adding Neofetch Config"
rm -f ~/.config/neofetch/config.conf
cp Configs/neofetch.conf ~/.config/neofetch/config.conf

# Tidying Up (leave at eof)
echo "Tidying up a little"
rm -rf ~/.cache/*
sudo paccache -rk 1
sudo paccache -ruk0
sudo pacman -Sc
rm -rf ~/.local/share/Trash/*
rm -f ~/.local/share/user-places*
rm -f ~/rmlint.*

# Bleachbit Cleaning <3
sudo pacman -S Bleachbit
bleachbit -c system.trash
bleachbit -c system.tmp
bleachbit -c system.recent_documents
bleachbit -c system.clipboard
bleachbit -c google_chrome.cache google_chrome.vacuum
bleachbit -c firefox.cache firefox.crash_reports
bleachbit -c deepscan.tmp deepscan.thumbs_db
bleachbit -c dnf.autoremove dnf.clean_all

# Clearing logs (Only keeps recent 10mb worth of logs)
sudo journalctl --vacuum-size=10M