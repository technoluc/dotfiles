#!/usr/bin/env bash

###
# some colorized echo helpers
# @author Adam Eivy
###

# Set the colours you can use for cecho
black='\033[0;30m'
white='\033[0;37m'
red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
magenta='\033[0;35m'
cyan='\033[0;36m'

# Resets the style
reset=`tput sgr0`

# Colors
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
COL_RED=$ESC_SEQ"31;01m"
COL_GREEN=$ESC_SEQ"32;01m"
COL_YELLOW=$ESC_SEQ"33;01m"
COL_BLUE=$ESC_SEQ"34;01m"
COL_MAGENTA=$ESC_SEQ"35;01m"
COL_CYAN=$ESC_SEQ"36;01m"

function cecho() {
  echo "${2}${1}${reset}"
  return
}

function ok() {
    echo -e "$COL_GREEN[ok]$COL_RESET "$1
}

function bot() {
    echo -e "\n$COL_GREEN\[._.]/$COL_RESET - "$1
}

function botq() {
    echo -e "\n$COL_YELLOW\[._.]/ - $1 $COL_RESET"
}

function botc() {
    echo -e "\n$COL_GREEN\[._.]/ - ${2}${1} $COL_RESET"
}

function running() {
    echo -en "$COL_YELLOW ⇒ $COL_RESET"$1": "
}

function action() {
    echo -e "\n$COL_YELLOW[action]:$COL_RESET\n ⇒ $1..."
}

function warn() {
    echo -e "$COL_YELLOW[warning]$COL_RESET "$1
}

function error() {
    echo -e "$COL_RED[error]$COL_RESET "$1
}

function print_error() {
    printf " [✖] %s\n" "$1"
}

function print_result() {

    if [ "$1" -eq 0 ]; then
        print_success "$2"
    else
        print_error "$2"
    fi

    return "$1"

}

function print_success() {
    printf " [✔] %s\n" "$1"
}


function mkd() {
    if [ -n "$1" ]; then
        if [ -e "$1" ]; then
            if [ ! -d "$1" ]; then
                print_error "$1 - a file with the same name already exists!"
            else
                print_success "$1"
            fi
        else
            execute "mkdir -p $1" "$1"
        fi
    fi
}

function print_error() {
    print_in_red "   [✖] $1 $2\n"
}

function print_error_stream() {
    while read -r line; do
        print_error "↳ ERROR: $line"
    done
}

function print_in_color() {
    printf "%b" \
        "$(tput setaf "$2" 2> /dev/null)" \
        "$1" \
        "$(tput sgr0 2> /dev/null)"
}

function print_in_green() {
    print_in_color "$1" 2
}

function print_in_purple() {
    print_in_color "$1" 5
}

function print_in_red() {
    print_in_color "$1" 1
}

function print_in_yellow() {
    print_in_color "$1" 3
}

function print_question() {
    print_in_yellow "   [?] $1"
}

function print_result() {

    if [ "$1" -eq 0 ]; then
        print_success "$2"
    else
        print_error "$2"
    fi

    return "$1"

}

function print_success() {
    print_in_green "   [✔] $1\n"
}

function print_warning() {
    print_in_yellow "   [!] $1\n"
}
