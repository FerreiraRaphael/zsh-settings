#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "Checking for Command Line Tools..."

# Check if Command Line Tools are installed
if ! xcode-select -p &>/dev/null; then
    echo -e "${YELLOW}Command Line Tools not found. Installing...${NC}"
    # Request installation of Command Line Tools
    xcode-select --install
    echo "Please wait for the Command Line Tools installation to complete..."
    echo "After installation is complete, please run this script again."
    exit 0
else
    echo -e "${GREEN}✓ Command Line Tools are installed${NC}"
fi

# Check if Homebrew is installed
echo -e "\nChecking for Homebrew installation..."
if ! command -v brew &>/dev/null; then
    echo -e "${YELLOW}Homebrew not found. Installing...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    echo -e "${GREEN}✓ Homebrew installed${NC}"
else
    echo -e "${GREEN}✓ Homebrew is already installed${NC}"
fi

echo -e "\nChecking for Oh My Zsh installation..."

# Check if .oh-my-zsh directory exists in the home directory
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo -e "${GREEN}✓ Oh My Zsh is already installed${NC}"

    # Install spaceship theme
    echo -e "\nSetting up Spaceship theme..."
    if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship-prompt" ]; then
        echo "Installing Spaceship theme..."
        git clone https://github.com/spaceship-prompt/spaceship-prompt.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship-prompt" --depth=1
        ln -s "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme" "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/spaceship.zsh-theme"
    fi

    # Update theme in .zshrc
    if grep -q "^ZSH_THEME=" "$HOME/.zshrc"; then
        sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="spaceship"/' "$HOME/.zshrc"
    else
        echo 'ZSH_THEME="spaceship"' >> "$HOME/.zshrc"
    fi

    # Add Spaceship configuration
    if ! grep -q "SPACESHIP_PROMPT_ORDER" "$HOME/.zshrc"; then
        cat >> "$HOME/.zshrc" << 'EOL'

# Spaceship Theme Configuration
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_PROMPT_ADD_NEWLINE=false
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=" "
EOL
    fi

    # Install and configure plugins
    echo -e "\nSetting up Zsh plugins..."

    # Create custom plugins directory if it doesn't exist
    ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

    # Install zsh-autosuggestions
    if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
        echo "Installing zsh-autosuggestions..."
        git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
    fi

    # Install zsh-syntax-highlighting
    if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
        echo "Installing zsh-syntax-highlighting..."
        git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
    fi

    # Install autojump
    if ! command -v autojump &> /dev/null; then
        echo "Installing autojump..."
        brew install autojump
    fi

    # Update .zshrc with plugins
    echo "Updating .zshrc configuration..."
    # Backup existing .zshrc
    cp "$HOME/.zshrc" "$HOME/.zshrc.backup"

    # Update plugins line in .zshrc
    if grep -q "^plugins=" "$HOME/.zshrc"; then
        sed -i '' 's/^plugins=(.*)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting history-substring-search autojump)/' "$HOME/.zshrc"
    else
        echo 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting history-substring-search autojump)' >> "$HOME/.zshrc"
    fi

    # Add autojump configuration if not present
    if ! grep -q "[ -f /usr/local/etc/profile.d/autojump.sh ]" "$HOME/.zshrc"; then
        echo '[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh' >> "$HOME/.zshrc"
    fi

    echo -e "${GREEN}✓ Plugins installed and configured${NC}"
    echo -e "${YELLOW}Please restart your terminal or run 'source ~/.zshrc' to apply changes${NC}"
else
    echo -e "${RED}✗ Oh My Zsh is not installed${NC}"
    echo "Would you like to install Oh My Zsh? (y/n)"
    read -r install_choice

    if [ "$install_choice" = "y" ] || [ "$install_choice" = "Y" ]; then
        echo "Installing Oh My Zsh..."
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

        # After installation, run the script again to install plugins
        echo -e "${YELLOW}Please run this script again to install plugins${NC}"
    else
        echo "Skipping Oh My Zsh installation"
    fi
fi
