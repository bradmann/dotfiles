#!/bin/bash

# zsh-ai bootstrap script
# Installs zsh-ai plugin in a cross-platform way

set -eu

echo "==> Setting up zsh-ai..."

system_type=$(uname -s)

# Create plugins directory if it doesn't exist
PLUGINS_DIR="$HOME/.zsh-plugins"
ZSH_AI_DIR="$PLUGINS_DIR/zsh-ai"

mkdir -p "$PLUGINS_DIR"

# Clone or update zsh-ai repository
if [ -d "$ZSH_AI_DIR" ]; then
    echo "    zsh-ai already installed, updating..."
    cd "$ZSH_AI_DIR"
    git pull --quiet
else
    echo "    Cloning zsh-ai..."
    git clone --quiet https://github.com/matheusml/zsh-ai.git "$ZSH_AI_DIR"
fi

echo "    ✓ zsh-ai installed to $ZSH_AI_DIR"
echo ""
echo "    Configuration file: ~/.zshrc.d/.zsh-ai"
echo "    To use zsh-ai, set one of the following in ~/.zshrc.d/.zsh-ai:"
echo "      - export ANTHROPIC_API_KEY=\"your-key\" (default)"
echo "      - export GEMINI_API_KEY=\"your-key\" and ZSH_AI_PROVIDER=\"gemini\""
echo "      - export OPENAI_API_KEY=\"your-key\" and ZSH_AI_PROVIDER=\"openai\""
echo "      - export ZSH_AI_PROVIDER=\"ollama\" (for local models)"
echo ""
echo "    Usage: Type '# your command in natural language' and press Enter"
echo ""

