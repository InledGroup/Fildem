#!/bin/bash
set -e

# Output colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${BLUE}===========================================${NC}"
echo -e "${BLUE}   Fildem Global Menu - Unified Installer  ${NC}"
echo -e "${BLUE}===========================================${NC}"

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}📦 Git is not installed. Installing...${NC}"
    sudo apt update && sudo apt install -y git
fi

# Create a temporary directory for installation
TEMP_DIR=$(mktemp -d)
trap 'rm -rf "$TEMP_DIR"' EXIT

echo -e "${BLUE}📥 Cloning repository from GitHub...${NC}"
git clone https://github.com/InledGroup/Fildem.git "$TEMP_DIR"

cd "$TEMP_DIR"

# Give execution permissions to internal scripts
chmod +x install_app.sh install_extension.sh

echo -e "${BLUE}📦 Installing companion app...${NC}"
./install_app.sh

echo -e "${BLUE}🧩 Installing GNOME Shell extension...${NC}"
./install_extension.sh

echo -e "${GREEN}===========================================${NC}"
echo -e "${GREEN}      Installation completed successfully!  ${NC}"
echo -e "${GREEN}===========================================${NC}"
echo -e "${YELLOW}IMPORTANT:${NC}"
echo -e "1. ${BLUE}Restart GNOME Shell${NC} (Alt+F2, type 'r' and press Enter, or log out on Wayland)."
echo -e "2. ${BLUE}Enable the 'Fildem Global Menu' extension${NC} in the 'Extensions' app."
echo -e "3. ${BLUE}Log out and back in${NC} for menus to work in all applications."
echo -e ""
echo -e "Developed with ❤️ by ${BLUE}Inled${NC} (https://inled.es)"
