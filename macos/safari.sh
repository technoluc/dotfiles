#!/usr/bin/env zsh

cecho "#-----------------------------------------------------------------#" $green
cecho "#                             Safari                              #" $green
cecho "#-----------------------------------------------------------------#" $green
echo ""

# Prevent Safari from opening ‘safe’ files automatically after downloading
echo ""
botq "Prevent Safari from opening safe files automatically after downloading? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  sudo defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
fi

# Enable the Develop menu and the Web Inspector in Safari
echo ""
botq "Enable the Develop menu and the Web Inspector in Safari? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write com.apple.Safari IncludeDevelopMenu -bool true
  defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
  defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
fi

# Show Safari status bar
echo ""
botq "Show Safari status bar? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write com.apple.Safari ShowStatusBar -boolean true
fi

# Add a context menu item for showing the Web Inspector in web views
echo ""
botq "Add a context menu item for showing the Web Inspector in web views? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
fi
