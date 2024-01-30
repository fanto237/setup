#!/bin/bash

# *********************************************************
# *********************************************************
# **                                                     **
# **               SET UP UBUNTU WSL                     **
# **                                                     **
# *********************************************************
# *********************************************************

HOST_NAME=$(wslpath "$(wslvar USERPROFILE)" | cut -d '/' -f 5)
GIT_DIR_PATH="/mnt/c/Users/${HOST_NAME}/git"
LSD_BINARY="lsd_0.23.1_amd64.deb"

RED='\033[0;31m'  # Red Color
BLUE='\033[0;34m' # Blue Color
NC='\033[0m'      # No Color

# *** Install latest ubuntu packages ***
echo -e "${BLUE}Updating ubuntu packages${NC}"
sudo apt update && sudo apt upgrade -y
echo -e "${RED}Ubuntu has been updated${NC}"
sleep 5

# *** Enhancing the cli with some charms ***
# (1) installing lsd
echo -e "${BLUE}Installing LS Super charged${NC}"

sudo dpkg -i $LSD_BINARY
rm -f $LSD_OUTPUT
echo -e "${RED}LSD has been installed ${NC}"
sleep 5

# (2) setting up zsh
echo -e "${BLUE}Setting up zsh and its plugings${NC}"

# echo -e "${RED}creating directory to store plugins${NC}"
# mkdir -p ~/.zsh/.plugins

# echo -e "${RED}cd to the plugins directory${NC}"
# cd ~/.zsh/.plugins

echo -e "${RED}cloning p10k${NC}"
git clone https://github.com/romkatv/powerlevel10k.git .zsh/.plugins/powerlevel10k

echo -e "${RED}cloning zsh-completion${NC}"
git clone https://github.com/zsh-users/zsh-completions.git .zsh/.plugins/zsh-completions

echo -e "${RED}cloning zsh-syntax-highlighting${NC}"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git .zsh/.plugins/zsh-syntax-highlighting

echo -e "${RED}cloning zsh-autosuggestions${NC}"
git clone https://github.com/zsh-users/zsh-autosuggestions.git .zsh/.plugins/zsh-autosuggestions

echo -e "${RED}All Plugins have been cloned and added to zsh plugins directory${NC}"

# *** Install zsh
echo -e "${BLUE}Installing zsh${NC}"
sudo apt install zsh -y
sleep 5

# *** setting up my git working dir ***
echo -e "${BLUE}Creating the git working dir${NC}"

# (1) Creating the git dir
mkdir -p $GIT_DIR_PATH

# (2) Making a symbolic link of the git directoy into the wsl
ln -s $GIT_DIR_PATH
echo -e "${RED}The git working dir has been set up successfully${NC}"
sleep 5

# *** installing dev dependencies
echo -e "${BLUE}Installing dev dependencies${NC}"

# (1) node and yarn
echo -e "${RED} Installing node and yarn${NC}"
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install nodejs -y
npm install --global yarn
echo -e "${RED}Node and Yarn has been installed${NC}"
sleep 5

# setting zsh as the default shell
echo -e "${BLUE}Setting zsh as the default shell${NC}"
chsh -s $(which zsh)
