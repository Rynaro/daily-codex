# Source utilities script
safe_source "utilities.sh"

PERSONAL_WORKSPACE_FOLDER=~/workspace/personal

# Function to install rbenv
install_package() {
  if command_exists docker; then
    echo "Installing Personal Rails Based Containers"
    cd $PERSONAL_WORKSPACE_FOLDER
    git clone git@github.com:Rynaro/drun.git .
  else
    echo "git and docker are required for it."
  fi
}

configure_package {
  echo "Building drun containers!"
  cd drun
  dc build . # dc aliases is set in potions main repo
  cd ~
}

install_package
configure_package
