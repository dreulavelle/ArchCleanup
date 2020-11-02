#!/bin/bash

echo "Tidying up a little"
rm -rf ~/.cache/*
rm -f ~/.local/share/RecentDocuments/*
rm -f ~/rmlint.*

sudo pacman -Syuu
