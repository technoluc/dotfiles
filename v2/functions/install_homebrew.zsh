
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
