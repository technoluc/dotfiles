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
    if prompt_robot "Show hidden files by default?"; then
      defaults write com.apple.finder AppleShowAllFiles -bool true
      show_ok "Enabled showing hidden files by default."
    fi

    if prompt_robot "Show all filename extensions?"; then
      defaults write NSGlobalDomain AppleShowAllExtensions -bool true
      show_ok "Enabled showing all filename extensions."
    fi

    if prompt_robot "Show status bar?"; then
      defaults write com.apple.finder ShowStatusBar -bool true
      show_ok "Enabled showing the status bar."
    fi

    if prompt_robot "Show path bar?"; then
      defaults write com.apple.finder ShowPathbar -bool true
      show_ok "Enabled showing the path bar."
    fi

    if prompt_robot "Keep folders on top when sorting by name?"; then
      defaults write com.apple.Finder _FXSortFoldersFirst -bool true
      show_ok "Folders are kept on top when sorting by name."
    fi

    if prompt_robot "Allow text selection in Quick Look?"; then
      defaults write com.apple.finder QLEnableTextSelection -bool TRUE
      show_ok "Enabled text selection in Quick Look."
    fi

    if prompt_robot "Disable the warning when changing a file extension?"; then
      defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
      show_ok "Disabled the warning when changing a file extension."
    fi

    if prompt_robot "Calculate all folder sizes?"; then
      /usr/libexec/PlistBuddy "$HOME/Library/Preferences/com.apple.finder.plist" -c 'Delete "StandardViewSettings:ExtendedListViewSettings:calculateAllSizes" bool'
      /usr/libexec/PlistBuddy "$HOME/Library/Preferences/com.apple.finder.plist" -c 'Add "StandardViewSettings:ExtendedListViewSettings:calculateAllSizes" bool true'
      /usr/libexec/PlistBuddy "$HOME/Library/Preferences/com.apple.finder.plist" -c 'Delete "StandardViewSettings:ExtendedListViewSettings:useRelativeDates" bool'
      /usr/libexec/PlistBuddy "$HOME/Library/Preferences/com.apple.finder.plist" -c 'Add "StandardViewSettings:ExtendedListViewSettings:useRelativeDates" bool false'
      /usr/libexec/PlistBuddy "$HOME/Library/Preferences/com.apple.finder.plist" -c 'Delete "StandardViewSettings:ListViewSettings:calculateAllSizes" bool'
      /usr/libexec/PlistBuddy "$HOME/Library/Preferences/com.apple.finder.plist" -c 'Add "StandardViewSettings:ListViewSettings:calculateAllSizes" bool true'
      show_ok "Enabled calculating all folder sizes."
    fi

    if prompt_robot "Enabling snap-to-grid for icons on the desktop and in other icon views?"; then
      /usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
      /usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
      /usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" ~/Library/Preferences/com.apple.finder.plist
      show_ok "Enabled snap-to-grid for icons on the desktop and in other icon views."
    fi

    if prompt_robot "Avoid creating .DS_Store files on network Volumes?"; then
      defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
      show_ok "Avoided creating .DS_Store files on network Volumes."
    fi

    if prompt_robot "Avoid creating .DS_Store files on USB Volumes?"; then
      defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
      show_ok "Avoided creating .DS_Store files on USB Volumes."
    fi

    if prompt_robot "Disable disk image verification?"; then
      defaults write com.apple.frameworks.diskimages skip-verify -bool true
      defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
      defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true
      show_ok "Disabled disk image verification."
    fi

    if prompt_robot "Expand save panel by default?"; then
      defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
      defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
      show_ok "Expanded save panel by default."
    fi

    if prompt_robot "Expand print panel by default?"; then
      defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
      defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
      show_ok "Expanded print panel by default."
    fi
  fi
}
