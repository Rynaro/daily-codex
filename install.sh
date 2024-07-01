#!/bin/bash

PLUGIN_NAME="daily-codex"
PLUGIN_VERSION="0.0.1"
PLUGIN_RELATIVE_FOLDER="./daily-codex"

# Function to prepare to install packages
prepare() {
  if ! is_wsl; then
    echo "My actual workflow depends on WSL environment. I have plans to adapt it to macOS and pure Debian. But now I just support WSL with Debian-like distros (what a irony)!"
    return;
  fi

  if ! command_exists git; then
    echo "You should at least have git installed to proceed!"
    return
  fi

  update_repositories
  cd ~
  mkdir -p workspaces/personal
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
  source ~/.potions/.zshrc
  clear
  echo "My Daily Codex installed!"
}

# Run pipeline
configure
install_packages
post_install

