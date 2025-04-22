#!/bin/bash

##############################################################
# This script is intended to get a mac machine to the point
# I like for working with and with the tools I want installed
# It will check for installs before installing apps if possible
##############################################################

set -e

echo "🚀 Bootstrapping your terminal..."

# 1. Install Homebrew
if ! command -v brew &> /dev/null; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# 2. Install iTerm2
echo "🧪 Installing iTerm2..."
brew install --cask iterm2

# 3. Install Nerd Fonts
echo "🔤 Installing Nerd Fonts (Meslo)..."
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font

# 3.5 Install zsh and zsh-completions
if ! command -v zsh &> /dev/null; then
  echo "Installing zsh"
  brew install zsh
fi

echo "Installing zsh additions"
brew install zsh-completions zsh-autosuggestions zsh-syntax-highlighting


# 4. Install Oh My Zsh (non-interactive)
echo "⚙️ Installing Oh My Zsh..."
export RUNZSH=no
export CHSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 5. Install Powerlevel10k theme
echo "🎨 Installing Powerlevel10k..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 6. Copy dotfiles to home directory
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/terminal-resources"

echo "📝 Copying dotfiles..."
cp "$DOTFILES_DIR/.zshrc" ~/.zshrc
cp "$DOTFILES_DIR/.p10k.zsh" ~/.p10k.zsh

# 7. Install useful CLI tools
echo "🔧 Installing CLI tools..."
brew install thefuck htop dive k9s awscli

# 8. Optional: Set iTerm2 preferences
echo "✅ Done! Launch iTerm2 and set the font to 'MesloLGS NF' manually."
echo "Then run 'p10k configure' to finish Powerlevel10k setup."

# 9. Install neovim
echo "Installing neovim"
brew install neovim