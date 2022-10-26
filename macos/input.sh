#!/usr/bin/env zsh

cecho "#-----------------------------------------------------------------#" $green
cecho "#   Trackpad, mouse, keyboard, Bluetooth accessories, and input   #" $green
cecho "#-----------------------------------------------------------------#" $green
echo ""

# Tap to click
echo ""
botq "Tap to click? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  sudo defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
fi

# Drag windows with three fingers
echo ""
botq "Drag windows with three fingers? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  sudo defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true 
fi

# Full Keyboard Access
echo ""
botq "Enable full keyboard access for controls? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  cecho "1 : Text boxes and lists only" $yellow
  cecho "3 : All controls" $yellow
  read -r response
  if [[ $response == "1" ]]; then
    sudo defaults write NSGlobalDomain AppleKeyboardUIMode -int 1
  elif [[ $response == "3" ]]; then
    sudo defaults write NSGlobalDomain AppleKeyboardUIMode -int 3
  else
    cecho "enter (1/3)" $red
  fi
fi

# Enable two finger tap as right click
echo ""
botq "Enable two finger tap as right click? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
  defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
  defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true

fi
