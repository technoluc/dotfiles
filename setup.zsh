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
