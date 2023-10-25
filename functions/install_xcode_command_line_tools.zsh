
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
