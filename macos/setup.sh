#!/usr/bin/env bash

declare -r GITHUB_REPOSITORY="technoluc/dotfiles"
declare DOTFILES_DIR="$HOME/.dotfiles"
declare -r DOTFILES_ORIGIN="https://github.com/$GITHUB_REPOSITORY.git"

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

bot "ensuring build/install tools are available"
if ! xcode-select --print-path &> /dev/null; then

    bot "Xcode CLI tools not found but are essential for this script. Installing them..."
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
    PROD=$(softwareupdate -l |
      grep "\*.*Command Line" |
      head -n 1 | awk -F"*" '{print $2}' |
      sed -e 's/^ *//' |
      cut -c 8- | 
      tr -d '\n')
    softwareupdate -i "$PROD" --verbose &> /dev/null
    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    # print_result $? ' XCode Command Line Tools Installed'

fi

ok "XCode Command Line Tools installed!"


bot "Cloning the dotfiles repository and starting the setup"
rm -rf $DOTFILES_DIR
mkdir -p $DOTFILES_DIR
git clone $DOTFILES_ORIGIN $DOTFILES_DIR
cd $DOTFILES_DIR/macos && sh bootstrap.sh