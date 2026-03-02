#!/bin/bash

# Define a dictionary to store folder paths
declare -A folders

# Specify config folder directories
folders[i3]="$HOME/.config/i3"
folders[hypr]="$HOME/.config/hypr"
folders[ashell]="$HOME/.config/ashell"
folders[i3status]="$HOME/.config/i3status"
folders[picom]="$HOME/.config/picom"
folders[rofi]="$HOME/.config/rofi"
folders[kitty]="$HOME/.config/kitty"
folders[oh - my - posh]="$HOME/.config/oh-my-posh"
folders[CustomBinary]="$HOME/.local/bin"
folders[wallpapers]="$HOME/.wallpapers"

# Iterate over folders and copy their contents to the current directory
for folder in "${folders[@]}"; do
  # Use rsync for a more efficient and robust copying mechanism
  rsync -r "$folder" ./
  echo "Copied: $folder"
done

# Define a function to perform Git operations
git_commit() {
  local message="$1"

  # Stage all changes in the current directory
  git add .

  # Commit changes with the provided message
  git commit -m "$message"

  # Push changes to the origin repository
  git push -u origin master
}

# Parse command-line arguments
while [[ "$#" =~ ^- ]]; do
  case "$1" in
  -m | --message)
    shift
    # Call the git_commit function with the message as an argument
    git_commit "$1"
    ;;
  -v | --version)
    echo "Version 1.2"
    ;;
  esac
  shift
done

# Handle remaining command-line arguments (if any)
if [[ "$#" -gt 0 ]]; then
  # Handle unknown or unsupported arguments
  echo "Unknown argument: $1"
fi
