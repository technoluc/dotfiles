#!/usr/bin/env zsh

cecho "#-----------------------------------------------------------------#" $green
cecho "#                       General UI/UX                             #" $green
cecho "#-----------------------------------------------------------------#" $green
cecho ""

# Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window
echo ""
botq "Enable admin info for login screen clock? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName
fi

# Disable the sound effects on boot
echo ""
botq "Disable the sound effects on boot? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  sudo nvram SystemAudioVolume=" "
fi

# Hide Spotlight in menu bar
echo ""
botq "Hide the Spotlight icon? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults -currentHost write com.apple.Spotlight MenuItemHidden -int 1
fi

# Hide Siri in menu bar
echo ""
botq "Hide the Siri icon? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write com.apple.Siri StatusMenuVisible -bool false
fi

# Check for software updates daily, not just once per week
echo ""
botq "Check for software updates daily, not just once per week? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1
fi


cecho "#-----------------------------------------------------------------#" $green
cecho "#                          LaunchPad                              #" $green
cecho "#-----------------------------------------------------------------#" $green
echo ""

# Change the Rows and Columns of Launchpad
echo ""
botq "Change the Rows and Columns of Launchpad? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  bot "How many Rows?"
  read -r rows
  defaults write com.apple.springboard-rows -int $rows

  bot "How many Columns? (y/n)"
  read -r columns
  defaults write com.apple.springboard-columns -int $columns
  defaults write com.apple.dock ResetLaunchPad -bool TRUE
  killall Dock

fi
