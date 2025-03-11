# macOS Zsh Configuration Setup

This repository contains a script to automatically set up a powerful Zsh environment on macOS with Oh My Zsh, useful plugins, and the Spaceship theme.

## Features

### 🛠 Prerequisites Installation
- Automatically installs Command Line Tools if not present
- Installs Homebrew (macOS package manager) if not present
- Handles both Intel and Apple Silicon Macs automatically

### 🚀 Oh My Zsh Setup
- Installs Oh My Zsh if not already installed
- Configures the modern and minimal [Spaceship theme](https://github.com/spaceship-prompt/spaceship-prompt)
- Creates automatic backups of your existing configurations

### 🔌 Plugins
The script installs and configures the following plugins:

1. **git** - Better Git integration and aliases
   - Enhanced Git autocompletion
   - Repository status information
   - Useful Git aliases
2. **gh** - GitHub CLI integration and autocompletion
3. **zsh-autosuggestions** - Fish-like autosuggestions for commands
4. **zsh-syntax-highlighting** - Fish-like syntax highlighting for commands
5. **history-substring-search** - Type part of command and use ↑/↓ to search
6. **autojump** - Smart directory jumping (use `j` command)

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/zsh-setup.git
   cd zsh-setup
   ```

2. Make the script executable:
   ```bash
   chmod +x setup_zsh.sh
   ```

3. Run the script:
   ```bash
   ./setup_zsh.sh
   ```

4. After the script completes, restart your terminal or run:
   ```bash
   source ~/.zshrc
   ```

## What Gets Configured

### Git & GitHub Integration
- Full Git command completion through Oh My Zsh git plugin
- GitHub CLI (gh) command completion through gh plugin
- Useful Git aliases (check Oh My Zsh git plugin documentation for full list)
- Repository status information in prompt

### Spaceship Theme Configuration
- Minimal and clean prompt
- Shows username, directory, and hostname
- Git status information
- Command execution time
- Background jobs indicator
- Exit code for failed commands

### Plugin Features

#### Git & GitHub Features
- Enhanced Git commands and aliases through Oh My Zsh
- Repository status in prompt
- Full Git and GitHub CLI autocompletion
- Common Git operations simplified with aliases:
  - `gst` for git status
  - `ga` for git add
  - `gcm` for git commit
  - `gp` for git push
  - And many more!

#### Autosuggestions
- As you type, you'll see suggested commands in gray
- Press → (right arrow) to accept the suggestion
- Based on your command history

#### Syntax Highlighting
- Commands are highlighted in green if valid
- Red highlighting for invalid commands
- Highlights paths, options, and arguments

#### History Substring Search
- Type part of a command and use ↑/↓ arrows
- Searches through your history for matching commands

#### Autojump
- Smart directory jumping
- Example: `j code` jumps to most used directory containing "code"
- Learns from your navigation habits

## Backup
The script automatically creates a backup of your existing `.zshrc` as `.zshrc.backup` before making any changes.

## Customization

### Modifying Theme Settings
Edit the Spaceship configuration in your `.zshrc`:
```bash
SPACESHIP_PROMPT_ORDER=(
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section
  exec_time     # Execution time
  line_sep      # Line break
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
```

### Adding More Plugins
1. Open `.zshrc`
2. Find the `plugins=()` line
3. Add new plugins inside the parentheses

## Troubleshooting

### Common Issues
1. **Command not found after installation**
   - Restart your terminal or run `source ~/.zshrc`

2. **Plugins not working**
   - Ensure the script completed without errors
   - Check if plugins are listed in `.zshrc`
   - Try removing and reinstalling Oh My Zsh

3. **Theme not loading**
   - Verify Spaceship theme installation in `~/.oh-my-zsh/custom/themes/`
   - Check `ZSH_THEME="spaceship"` in `.zshrc`

## Contributing
Feel free to submit issues and enhancement requests!
