#!/bin/bash

PLUGIN_NAME="daily-codex"
PLUGIN_VERSION="0.1.0"
PLUGIN_RELATIVE_FOLDER="$(dirname "$0")/$1"

# Source utilities script
source "$PLUGIN_RELATIVE_FOLDER/utilities.sh"
prepare_logging_stream

create_workspace_essential_folders() {
  ensure_directory "$WORKSPACE_FOLDER/personal/tooling"
  ensure_directory "$WORKSPACE_FOLDER/personal/studies"
}

ensure_sources() {
  local source_files=(
    'macos.sh'
    'linux.sh'
    'termux.sh'
  )

  ensure_directory "$ENV_SOURCES_FOLDER"
  ensure_files "$ENV_SOURCES_FOLDER" "${source_files[@]}"
}

# Function to prepare to install packages
prepare() {
  update_repositories
  ensure_sources
  create_workspace_essential_folders
}

# Function to install packages
install_packages() {
  log "Installing Plugin: daily-codex..."
  local packages=(
    'snap'
    'rbenv'
    'ruby'
    'nvm'
    'node'
    'docker'
)

  for pkg in "${packages[@]}"; do
    unpack_it "$pkg"
  done
}

# Function to consolidate post-installation scripts
post_install() {
  log "My Daily Codex installed!"
}

# Run pipeline

if ! command_exists git; then
  exit_with_message "You should at least have git installed to proceed!"
fi

prepare
install_packages
post_install

