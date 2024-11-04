#!/bin/bash

# Source utilities script
safe_source "utilities.sh"

install_package() {
  sudo apt install snapd
}
