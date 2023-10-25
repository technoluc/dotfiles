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

