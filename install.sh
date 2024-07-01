#!/bin/bash

PLUGIN_NAME="daily-codex"
PLUGIN_VERSION="0.0.1"
PLUGIN_RELATIVE_FOLDER="$(dirname "$0")/$1"

# Source utilities script
source "$PLUGIN_RELATIVE_FOLDER/utilities.sh"

# Function to prepare to install packages
prepare() {
  update_repositories
  mkdir -p ~/workspaces/personal
}

# Function to install packages
install_packages() {
  echo "Installing Plugin: daily-codex..."
  safe_source "packages/rbenv.sh"
  safe_source "packages/ruby.sh"
  safe_source "packages/nvm.sh"
  safe_source "packages/node.sh"
  safe_source "packages/docker.sh"
  safe_source "packages/rails-containers.sh"
}

# Function to consolidate post-installation scripts
post_install() {
  clear
  echo "My Daily Codex installed!"
}

# Run pipeline

if ! is_wsl; then
  echo "My actual workflow depends on WSL environment. I have plans to adapt it to macOS and pure Debian. But now I just support WSL with Debian-like distros (what a irony)!"
  return
  fi

if ! command_exists git; then
  echo "You should at least have git installed to proceed!"
  return
fi


prepare
install_packages
post_install

