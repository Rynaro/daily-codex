#!/bin/bash

LOCKED_BUNDLER_VERSION=2.5
MY_RUBY_VERSION=3.3.0

# Source utilities script
safe_source "utilities.sh"

prepare_package() {
  sudo apt install -y autoconf patch build-essential rustc \
    libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libgmp-dev \
    libncurses5-dev libffi-dev libgdbm6 libgdbm-dev \
    libdb-dev uuid-dev
}

# Function to install rbenv
install_package() {
  if command_exists rbenv; then
    echo "Installing Ruby $latest_ruby_version..."
    rbenv install $MY_RUBY_VERSION
    rbenv global $MY_RUBY_VERSION
  else
    echo "rbenv is required for ruby installation."
  fi
}

configure_package() {
  gem uninstall bundler
  gem install bundler -v $LOCKED_BUNDLER_VERSION
}

prepare_package
install_package
configure_package
