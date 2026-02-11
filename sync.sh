#!/bin/bash

declare -A folders

# config folder directories
folders[i3]="$HOME/.config/i3"
folders[hypr]="$HOME/.config/hypr"
folders[ashell]="$HOME/.config/ashell/"
folders[i3status]="$HOME/.config/i3status"
folders[picom]="$HOME/.config/picom"
folders[rofi]="$HOME/.config/rofi"
folders[kitty]="$HOME/.config/kitty"
folders[CustomBinary]="$HOME/.local/bin"
folders[wallpapers]="$HOME/.wallpapers"

for folder in "${folders[@]}"; do
    cp -r "$folder" ./
    echo "Copied: ${folder}"
done

# Git add and commit
function gitcommit() {
    git add .
    git commit -m "$1"
    git push -u origin
}

while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do
    case "$1" in
    -m | --message)
        shift
        gitcommit "$1"
        ;;
    -v | --version)
        echo "1.0"
        ;;
    esac
    shift
done
if [[ "$1" == '--' ]]; then shift; fi
