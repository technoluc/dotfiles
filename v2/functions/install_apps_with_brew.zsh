
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
