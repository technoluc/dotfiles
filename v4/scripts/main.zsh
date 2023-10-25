############################################################################################
#                                   START OF MAIN SCRIPT                                   #
############################################################################################

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

