#!/usr/bin/env zsh

# echo ""
# echo "Would you like to set your computer name (as done via System Preferences >> Sharing)?  (y/n)"
# read -r response
# if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
#   echo "What would you like it to be?"
#   read COMPUTER_NAME
#   sudo scutil --set ComputerName $COMPUTER_NAME
#   sudo scutil --set HostName $COMPUTER_NAME
#   sudo scutil --set LocalHostName $COMPUTER_NAME
#   sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string $COMPUTER_NAME
# fi

# echo ""
# echo "Hide the Time Machine, Volume, User, and Bluetooth icons?  (y/n)"
# read -r response
# if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
#   # Get the system Hardware UUID and use it for the next menubar stuff
#   for domain in ~/Library/Preferences/ByHost/com.apple.systemuiserver.*; do
#     defaults write "${domain}" dontAutoLoad -array \
#       "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
#       "/System/Library/CoreServices/Menu Extras/Volume.menu" \
#       "/System/Library/CoreServices/Menu Extras/User.menu"
#   done

#   defaults write com.apple.systemuiserver menuExtras -array \
#     "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
#     "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
#     "/System/Library/CoreServices/Menu Extras/Battery.menu" \
#     "/System/Library/CoreServices/Menu Extras/Clock.menu"
# fi

echo ""
echo "Hide the Spotlight icon? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults -currentHost write com.apple.Spotlight MenuItemHidden -int 1
  defaults write com.apple.Siri StatusMenuVisible -bool false
fi

echo ""
echo "Hide the Siri icon? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write com.apple.Siri StatusMenuVisible -bool false
fi

echo ""
echo "Reveal IP address, hostname, OS version, etc. when clicking the clock in the login window"
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

echo ""
echo "Check for software updates daily, not just once per week"
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo ""
echo "Disable the sound effects on boot"
sudo nvram SystemAudioVolume=" "
