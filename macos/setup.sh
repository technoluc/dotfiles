#!/usr/bin/env bash

declare -r GITHUB_REPOSITORY="technoluc/dotfiles"
declare DOTFILES_DIR="$HOME/.dotfiles"
declare -r DOTFILES_ORIGIN="git@github.com:$GITHUB_REPOSITORY.git"

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"

function ok() {
    echo -e "$COL_GREEN[ok]$COL_RESET "$1
}

function bot() {
    echo -e "\n$COL_GREEN\[._.]/$COL_RESET - "$1
}

function botq() {
    echo -e "\n$COL_YELLOW\[._.]/ - $1 $COL_RESET"
}

bot "ensuring build/install tools are available"
# Only run if the tools are not installed yet
# To check that try to print the SDK path
xcode-select -p &> /dev/null
if [ $? -ne 0 ]; then
  bot "Xcode CLI tools not found. Installing them..."
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    cut -c 8- | 
    tr -d '\n')
  softwareupdate -i "$PROD" --verbose
  ok "Xcode CLI tools installed";
else
  ok "Xcode CLI tools OK"
fi

git clone —recursive git@github.com:technoluc/dotfiles.git $DOTFILES_DIR
cd $DOTFILES_DIR && cd macos && sh bootstrap.sh