
# Function to set Finder preferences
set_finder_preferences() {
    if prompt_robot "Customize Finder preferences?"; then
  # Set HOME as the default location for new Finder windows
  if prompt_robot "Set HOME as the default location for new Finder windows?"; then
    defaults write com.apple.finder NewWindowTarget -string "PfLo"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"
    show_ok "Set HOME as the default location for new Finder windows."
  fi

  # Show the ~/Library folder
  if prompt_robot "Show the ~/Library folder?"; then
    chflags nohidden ~/Library
    show_ok "Showing the ~/Library folder."
  fi

  # Other Finder preferences
  botq "Show hidden files by default?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    defaults write com.apple.finder AppleShowAllFiles -bool true
  fi

  botq "Show all filename extensions?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
  fi

  botq "Show status bar?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    defaults write com.apple.finder ShowStatusBar -bool true
  fi

  botq "Show path bar?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    defaults write com.apple.finder ShowPathbar -bool true
  fi

  botq "Keep folders on top when sorting by name?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    defaults write com.apple.Finder _FXSortFoldersFirst -bool true
  fi

  botq "Allow text selection in Quick Look?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    defaults write com.apple.finder QLEnableTextSelection -bool TRUE
  fi

  botq "Disable the warning when changing a file extension?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
  fi

  botq "Calculate all folder sizes?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    /usr/libexec/PlistBuddy "$HOME/Library/Preferences/com.apple.finder.plist" -c 'Delete "StandardViewSettings:ExtendedListViewSettings:calculateAllSizes" bool'
    /usr/libexec/PlistBuddy "$HOME/Library/Preferences/com.apple.finder.plist" -c 'Add "StandardViewSettings:ExtendedListViewSettings:calculateAllSizes" bool true'

    /usr/libexec/PlistBuddy "$HOME/Library/Preferences/com.apple.finder.plist" -c 'Delete "StandardViewSettings:ExtendedListViewSettings:useRelativeDates" bool'
    /usr/libexec/PlistBuddy "$HOME/Library/Preferences/com.apple.finder.plist" -c 'Add "StandardViewSettings:ExtendedListViewSettings:useRelativeDates" bool false'

    /usr/libexec/PlistBuddy "$HOME/Library/Preferences/com.apple.finder.plist" -c 'Delete "StandardViewSettings:ListViewSettings:calculateAllSizes" bool'
    /usr/libexec/PlistBuddy "$HOME/Library/Preferences/com.apple.finder.plist" -c 'Add "StandardViewSettings:ListViewSettings:calculateAllSizes" bool true'
  fi

  botq "Enabling snap-to-grid for icons on the desktop and in other icon views?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
    /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
  fi

  botq "Avoid creating .DS_Store files on network Volumes?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
  fi

  botq "Avoid creating .DS_Store files on USB Volumes?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
  fi

  botq "Disable disk image verification?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    defaults write com.apple.frameworks.diskimages skip-verify -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
    defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
  fi

  botq "Expand save panel by default?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
    defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
  fi

  botq "Expand print panel by default?"
  read -r response
  if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
    defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
  fi
  fi
}