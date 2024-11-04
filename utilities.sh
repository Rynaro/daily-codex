#!/bin/bash

UTILITIES_VERSION=1.0.0

OS_TYPE="$(uname -s)"
USER_HOME_FOLDER=$HOME
POTIONS_HOME="$USER_HOME_FOLDER/.potions"
ZDOTDIR=$POTIONS_HOME
ENV_SOURCES_FOLDER="$POTIONS_HOME/sources"

WORKSPACE_FOLDER="$USER_HOME_FOLDER/workspace"
LOGS_FOLDER="$POTIONS_HOME/logs"
LOG_OUTPUT_FILE="$LOGS_FOLDER/plugins.daily-codex.log"

prepare_logging_stream() {
  ensure_directory $LOGS_FOLDER
  ensure_files "" "$LOG_OUTPUT_FILE"
}

log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"
}

# Function to source the common holding package
unpack_it() {
  local package="$1"
    safe_source "packages/$package.sh"
}

update_repositories() {
  log "Updating repositories..."
  if is_macos; then
    brew update
  elif is_termux; then
    pkg update
  elif is_wsl || is_linux; then
    if is_apt_package_manager; then
      log "If you do not need sudo for any reason, modify this script!"
      sudo apt-get update
    else
      exit_with_message "No supported package manager have been found! Consider move to another environment supported! Or create a patch! :)"
    fi
  fi
}

# Function to check if a command exists
command_exists() {
  local cmd="$1"

  # Check in bash
  if command -v "$cmd" &> /dev/null; then
    return 0
  fi

  # Check in zsh
  if zsh -c "which $cmd" &> /dev/null; then
    return 0
  fi

  return 1
}

# Function to safely source a script if it exists
safe_source() {
  [ -f "$PLUGIN_RELATIVE_FOLDER/$1" ] && source "$PLUGIN_RELATIVE_FOLDER/$1"
}

# Function to check if the environment is Termux
is_termux() {
  [ -n "$PREFIX" ] && [ -x "$PREFIX/bin/termux-info" ]
}

# Function to check if the environment is WSL
is_wsl() {
  grep -qi microsoft /proc/version
}

# Function to check if the environment is macOS
is_macos() {
  [ $OS_TYPE = "Darwin" ]
}

# Function to check if the environment is Linux-based kernel
is_linux() {
  [ $OS_TYPE = "Linux" ]
}

is_debian_bookworm() {
  grep -qi 'debian.*bookworm' /etc/os-release
}

# Function to check and create directory; if needed
ensure_directory() {
  local dir="$1"
  if [ -d "$dir" ]; then
    log "Directory '$dir' already exists."
  else
    log "Directory '$dir' does not exist. Creating..."
    mkdir -p "$dir"
    if [ $? -eq 0 ]; then
        log "Successfully created directory '$dir'."
    else
        log "Error: Failed to create directory '$dir'." >&2
        exit 1
    fi
  fi
}

# Function to check and create files in the described path; if needed or if could
ensure_files() {
  local dir="$1"
  shift
  local files=("$@")

  for file in "${files[@]}"; do
    local filepath="$dir/$file"
    if [ -f "$filepath" ]; then
      log "File '$filepath' already exists."
    else
      log "File '$filepath' does not exist. Creating..."
      touch "$filepath"
      if [ $? -eq 0 ]; then
        log "Successfully created file '$filepath'."
      else
        log "Error: Failed to create file '$filepath'." >&2
        exit 1
      fi
    fi
  done
}

# Function to source the appropriate environment script
target_source_file() {
  local target=""

  if is_termux; then
    target="termux.sh"
  elif is_wsl; then
    target="wsl.sh"
  elif is_macos; then
    target="macos.sh"
  elif is_linux; then
    target="linux.sh"
  else
    exit_with_message "Error: Unsupported environment." >&2
  fi

  echo "$target"
}

# Function to write lines to the appropriate environment script
write_to_sources_file() {
  echo "$1" >> "$ENV_SOURCES_FOLDER/$(target_source_file)"
}

# Function to check if apt is the package manager
is_apt_package_manager() {
  command_exists apt
}

# Beautifully message and go!
exit_with_message() {
  log $1
  log "Terminating Potions Routines..."
  exit 1
}
