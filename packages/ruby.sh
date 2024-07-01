#!/bin/bash

LOCKED_BUNDLER_VERSION=2.5

# Source utilities script
safe_source "utilities.sh"

# Function to install rbenv
install_package() {
  if command_exists rbenv; then
    latest_ruby_version=$(rbenv install -l | grep -v - | tail -1)
    echo "Installing Ruby $latest_ruby_version..."
    rbenv install $latest_ruby_version
    rbenv global $latest_ruby_version
  else
    echo "rbenv is required for ruby installation."
  fi
}

configure_package {
  if command_exists bundle; then
    echo "Avoid version mayhem. You already have a bundler there!"
  elif
    gem install bundler -v $LOCKED_BUNDLER_VERSION
  fi
}

install_package
configure_package
