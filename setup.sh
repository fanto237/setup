#!/bin/bash

RED='\033[0;31m'  # Red Color
BLUE='\033[0;34m' # Blue Color
NC='\033[0m'      # No Color

echo -e "${BLUE}  ************************************************************${NC}"
echo -e "${BLUE}  ************************************************************${NC}"
echo -e "${BLUE}  **                                                        **${NC}"
echo -e "${BLUE}  **            BASH SCRIPT TO SET UP ENV                   **${NC}"
echo -e "${BLUE}  **                                                        **${NC}"
echo -e "${BLUE}  ************************************************************${NC}"
echo -e "${BLUE}  ************************************************************${NC}"

# Function to set up Ubuntu WSL
setup_wsl() {
  setup_linux "wsl"
}

# Function to set up Windows Terminal (Placeholder)
setup_windows() {

  echo "Setting up Windows"
  read -p "Do you want to install scoop? (y/n): "
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    install_scoop
  fi
  sleep 5

  # *** Install zsh
  setup_zsh "wezterm"
  sleep 5

  # restore scoop packages
  echo -e "${BLUE}Restoring scoop packages${NC}"
  scoop import scoop.json
  sleep 3

  # ask if fancontroll config should be copy
  read -p "Do you want to copy the fancontrol config? (y/n): "
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    cp fancontroll.json ~/scoop/apps/fancontrol/current/Configurations
  fi
}

# Function to set up Linux
setup_linux() {
  echo "Setting up Linux"

  # *** Install latest ubuntu packages ***
  echo -e "${BLUE}Updating ubuntu packages${NC}"
  sudo apt update && sudo apt upgrade -y
  sleep 5

  # *** Enhancing the cli with some charms ***
  # installing lsd
  echo -e "${BLUE}Installing LS Super charged${NC}"
  sudo apt install lsd -y
  sleep 5

  # *** Install zsh
  setup_zsh $1
  sleep 5

  # *** setting up my git working dir ***
  setup_working_dir $1
  sleep 5

  # *** installing dev dependencies
  echo -e "${BLUE}Installing dev dependencies${NC}"
  sudo apt install build-essential -y
  sleep 5

  # installing .NET
  install_dotnet
  sleep 5

  # install node
  install_node_js
  sleep 5

  # install docker
  if [[ $1 == "wsl" ]]; then
    echo -e "${BLUE}Docker is not supported on WSL${NC}"
  else
    install_docker
  fi
  sleep 5

  # Setting zsh as the default shell
  echo -e "${BLUE}Setting zsh as the default shell${NC}"
  chsh -s "$(which zsh)"
}

install_scoop() {
  # Install scoop
  echo -e "${BLUE}Installing scoop${NC}"
  Powershell -Command Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  Powershell -Command Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
  sleep 5
}

setup_zsh() {
  echo -e "${BLUE}Setting up zsh and its plugings${NC}"

  echo -e "${RED}cloning p10k${NC}"
  git clone https://github.com/romkatv/powerlevel10k.git ~/.zsh/.plugins/powerlevel10k

  echo -e "${RED}cloning zsh-completion${NC}"
  git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/.plugins/zsh-completions

  echo -e "${RED}cloning zsh-syntax-highlighting${NC}"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/.plugins/zsh-syntax-highlighting

  echo -e "${RED}cloning zsh-autosuggestions${NC}"
  git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/.plugins/zsh-autosuggestions

  echo -e "${RED}All Plugins have been cloned and added to zsh plugins directory${NC}"

  cp .zshrc ~
  cp .p10k.zsh ~

  echo -e "${RED}The zshrc file has been moved to the home directory${NC}"

  # copy wezterm config and setup zsh as default shell
  if [[ $1 == "wezterm" ]]; then
    cp .wezterm.lua ~
    echo -e 'if [ -t 1 ]; then\n  exec zsh\nfi' > ~/.bashrc
  fi 

  # install zsh from apt repo
  if [[ $1 == "wsl" ]]; then
    echo -e "${BLUE}Installing zsh${NC}"
    sudo apt install zsh -y
    cp clean-dl.sh ~
  fi
}

install_node_js() {
  echo -e "${BLUE}Installing Node.js and Yarn${NC}"
  sudo apt install curl -y
  # Download and install fnm:
  curl -o- https://fnm.vercel.app/install | bash

  # Download and install Node.js:
  fnm install 22

  # Verify the Node.js version:
  node -v # Should print "v22.13.0".

  # Download and install Yarn:
  corepack enable yarn

  # Verify Yarn version:
  yarn -v
}

install_docker() {
  echo -e "${BLUE}Installing Docker${NC}"
  for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

  # Add Docker's official GPG key:
  sudo apt-get update
  sudo apt-get install ca-certificates curl
  sudo install -m 0755 -d /etc/apt/keyrings
  sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
  sudo chmod a+r /etc/apt/keyrings/docker.asc

  # Add the repository to Apt sources:
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" |
    sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
  sudo apt-get update

  sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

  sudo groupadd docker

  sudo usermod -aG docker $USER
}

setup_working_dir() {
  echo -e "${BLUE}Creating the git working dir${NC}"

  if [[ $1 == "wsl" ]]; then
    HOST_NAME=$(cmd.exe /c "echo %USERNAME%")
    GIT_DIR_PATH="/mnt/c/Users/${HOST_NAME}/repos"

    ln -s $GIT_DIR_PATH
    echo -e "${RED}The git working dir has been set up successfully${NC}"
    sleep 5
  else
    mkdir repos
  fi
}

install_dotnet() {
  echo -e "${BLUE}Installing .NET${NC}"
  sudo apt-get update
  wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  sudo apt-get update
  sudo apt-get install -y dotnet-sdk-8.0
  sleep 5
}

# Main script execution
echo "Select setup option:"
echo "1. Windows Subsystem for Linux"
echo "2. Windows Terminal"
echo "3. Ubuntu"
read -p "Enter your choice (1-3): " choice

case "$choice" in
1)
  setup_wsl
  ;;
2)
  setup_windows

  ;;
3)
  setup_linux
  ;;
*)
  echo "Invalid choice, please run the script again."
  ;;
esac
