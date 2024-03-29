#!/bin/zsh

####################################################################################################
#                    WARNING: THIS FILE IS AUTOMATICALLY GENERATED BY A SCRIPT.                    #
#                           ANY MANUAL MODIFICATIONS MAY BE OVERWRITTEN                            #
####################################################################################################

# Define the robot character and colors
ROBOT=$'\e[32m\[._.]/\e[0m'
OK_ROBOT=$'\e[32m\[._.]/'
ERROR_ROBOT=$'\e[31m\[._.]/\e[0m'
# Function to display the robot prompt
prompt_robot() {
  read -r "response?${ROBOT} $1 [Y/n]: "
  if [[ $response =~ ^[Yy]$ || $response == "" ]]; then
    return 0
  else
    return 1
  fi
}

# Function to display the robot prompt with default as "No"
prompt_robot_no_default() {
  read -r "response?${ROBOT} $1 [y/N]: "
  if [[ $response =~ ^[Yy]$ ]]; then
    return 0
  else
    return 1
  fi
}

# Function to display a succes message with the robot
show_ok() {
  echo -e "$OK_ROBOT $1\e[0m"
}

# Function to display an error message with the robot
show_error() {
  echo -e "$ERROR_ROBOT Error: $1"
}

# Function to install apps using Homebrew from a Brewfile
install_apps_with_brew() {
  if prompt_robot_no_default "Install apps with Homebrew from a Brewfile?"; then
    # Download the Brewfile from the provided URL
    brewfile_url="https://raw.githubusercontent.com/technoluc/dotfiles/main/macos/Brewfile"
    curl -fsSL "$brewfile_url" -o Brewfile
    if [ $? -ne 0 ]; then
      show_error "Failed to download Brewfile from $brewfile_url."
      return 1
    else
      show_ok "Successfully downloaded Brewfile from $brewfile_url."
      return 0
    fi

    # Install apps from the Brewfile
    brew bundle
    if [ $? -ne 0 ]; then
      show_error "Failed to install apps from the Brewfile."
      return 1
    else
      show_ok "Successfully installed apps from the Brewfile."
      return 0
    fi

    # Clean up the downloaded Brewfile
    rm Brewfile
    return 0
  fi
}

# Function to install Xcode Command Line Tools
install_xcode_command_line_tools() {
  if prompt_robot "Install Xcode Command Line Tools?"; then
    xcode-select --install
    if [ $? -ne 0 ]; then
      show_error "Failed to install Xcode Command Line Tools."
      return 1
    else
      show_ok "Successfully installed Xcode Command Line Tools."
      return 0
    fi
  fi
}

# Function to install Homebrew
install_homebrew() {
  if prompt_robot "Install Homebrew?"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    if [ $? -ne 0 ]; then
      show_error "Failed to install Homebrew."
      return 1
    else
      show_ok "Successfully installed Homebrew."
      return 0
    fi
  fi
}
function setPlistValue {
  local plist="$HOME/Library/Preferences/com.apple.Terminal.plist"
  local profile="Basic"
  local key="$1"
  local value="$2"

  # Check if the value already exists in the profile
  local existingValue
  existingValue=$(/usr/libexec/PlistBuddy -c "Print 'Window Settings':$profile:$key" "$plist" 2>/dev/null)

  if [[ -n $existingValue ]]; then
    # Check if the existing value matches the desired value
    if [[ "$existingValue" != "$value" ]]; then
      # Value exists but is different, set it to the provided value
      echo $existingValue
      # /usr/libexec/PlistBuddy -c "Set 'Window Settings':$profile:$key $value" "$plist"
      # show_ok "$key has been updated to $value."
    else
      show_ok "$key is already set to $value."
    fi
  else
    # Value doesn't exist, add it with the provided value
    local type
    # Determine the data type based on the value
    if [[ "$value" == "true" || "$value" == "false" ]]; then
      type="bool"
    elif [[ "$value" == *"."* ]]; then
      type="real"
    else
      type="integer"
    fi

    /usr/libexec/PlistBuddy -c "Add 'Window Settings':$profile:$key $type $value" "$plist"
    if [ $? -ne 0 ]; then
      show_error "Failed to add $key with value $value to the plist."
    else
      show_ok "$key has been added and set to $value."
    fi
  fi
}

# Function to customize Terminal settings
customize_terminal_settings() {
  if prompt_robot "Customize Terminal settings?"; then
    # Use Option As MetaKey
    if prompt_robot "Use Option As MetaKey?"; then
      # Call the function to set or add the value for useOptionAsMetaKey
      setPlistValue "useOptionAsMetaKey" "true"
      show_ok "Option As MetaKey is enabled."
    fi

    # Shell Exit Action
    if prompt_robot "Set Shell Exit Action?"; then
      # Call the function to set or add the value for shellExitAction
      setPlistValue "shellExitAction" "1"
      show_ok "Shell Exit Action is set."

    fi
  fi
}# Function to set Finder preferences
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
echo "Welcome to Mac Setup Script!"

echo "Follow the prompts from the robot to set up your Mac."

# Check if xcode is installed
if ! xcode-select --print-path &>/dev/null; then
  install_xcode_command_line_tools
else
  show_ok "Xcode Command Line Tools already installed."
fi

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
  install_homebrew
else
  show_ok "Homebrew already installed."
fi

install_apps_with_brew
customize_terminal_settings

# You can add more functions here for customizing settings.

show_ok "Mac setup is complete."
