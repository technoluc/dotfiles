#!/usr/bin/env bash

export DOTFILES_DIR=$HOME/.dotfiles/macos

source $DOTFILES_DIR/lib_sh/echos.sh
source $DOTFILES_DIR/lib_sh/requirers.sh


echo ""
cecho "#######################################################################" $green
cecho "#                                                                     #" $green
cecho "#                                                                     #" $green
cecho "#                 TechnoLuc's macos bootstrap script                  #" $green
cecho "#                                                                     #" $green
cecho "#                                                                     #" $green
cecho "#######################################################################" $green
echo ""

bot "Hi! I'm going to install tooling and tweak your system settings. Here I go..."


echo ""
cecho "Have you read through the script you're about to run and " $red
cecho "understood that it will make changes to your computer? (y/n)" $red
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  cecho "Please go read the script, it only takes a few minutes" $red
  exit
fi

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Do we need to ask for sudo password or is it already passwordless?
grep -q 'NOPASSWD:     ALL' /etc/sudoers.d/$LOGNAME > /dev/null 2>&1
if [ $? -ne 0 ]; then
  sudo -v

  # Keep-alive: update existing sudo time stamp until the script has finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

  botc "Do you want me to setup touchID for sudo commands? \n" $COL_RED

  read -r -p "Enable TouchID sudo ? [y|N] " response

  if [[ $response =~ (yes|y|Y) ]];then
      sudo sed -i -- '2s/^/auth sufficient pam_tid.so\n/' /etc/pam.d/sudo
      
      botc "You can now run sudo commands without password!" $COL_GREEN
  fi
fi

echo ""
botc "Source General dotfile? (y/n)" $COL_CYAN
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  source $DOTFILES_DIR/general.sh
fi

echo ""
botc "Source Input dotfile? (y/n)" $COL_CYAN
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  source $DOTFILES_DIR/input.sh
fi

echo ""
botc "Source Finder dotfile? (y/n)" $COL_CYAN
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  source $DOTFILES_DIR/finder.sh
fi

echo ""
botc "Source Safari dotfile? (y/n)" $COL_CYAN
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  source $DOTFILES_DIR/safari.sh
fi

# echo ""
# botq "Source Adblock dotfile? (y/n)"
# read -r response
# if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
#   source $DOTFILES_DIR/macos/adblock.sh
# fi

# echo ""
# botc "Source Git dotfile? (y/n)" $COL_CYAN
# read -r response
# if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
#   source $DOTFILES_DIR/git.sh
# fi

echo ""
botc "Source Brew dotfile? (y/n)" $COL_CYAN
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  source $DOTFILES_DIR/brew.sh
fi

echo ""
botc "Source Office dotfile? (y/n)" $COL_CYAN
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  source $DOTFILES_DIR/office.sh
fi

echo ""
botc "Source Dock dotfile? (y/n)" $COL_CYAN
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  source $DOTFILES_DIR/dock.sh
fi

echo ""
botc "Source Terminal dotfile? (y/n)" $COL_CYAN
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  source $DOTFILES_DIR/terminal.sh
fi

###############################################################################
# Kill affected applications                                                  #
###############################################################################

botc "OK. Note that some of these changes require a logout/restart to take effect. Killing affected applications (so they can reboot)....? (y/n)" $COL_RED
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  for app in "Activity Monitor" "cfprefsd" \
  "Dock" "Finder" "Safari" "SystemUIServer" \
  "Terminal"; do
  killall "${app}" > /dev/null 2>&1
  done
fi
