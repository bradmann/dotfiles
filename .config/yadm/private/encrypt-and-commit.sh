#!/bin/bash

# Helper script to encrypt API keys and commit the archive
# This automates the yadm encrypt workflow

set -e

echo "=== yadm Encryption Helper ==="
echo ""

# Check if api-keys.zsh exists
if [[ ! -f "$HOME/.config/yadm/private/api-keys.zsh" ]]; then
    echo "❌ Error: API keys file not found"
    echo "   Create it first from the template:"
    echo "   cp ~/.config/yadm/private/api-keys.zsh.template ~/.config/yadm/private/api-keys.zsh"
    exit 1
fi

echo "✓ Found API keys file"
echo ""

# Check if GPG is available
if ! command -v gpg &> /dev/null; then
    echo "❌ Error: GPG not found"
    echo "   Install GPG to use yadm encryption:"
    echo "   - macOS: brew install gnupg"
    echo "   - Linux: sudo apt install gnupg (or equivalent)"
    exit 1
fi

echo "✓ GPG is available"
echo ""

# Check if yadm encrypt file exists
if [[ ! -f "$HOME/.config/yadm/encrypt" ]]; then
    echo "❌ Error: ~/.config/yadm/encrypt not found"
    echo "   This file should have been created automatically."
    exit 1
fi

echo "✓ Encryption patterns file exists"
echo ""
echo "Files to be encrypted:"
cat "$HOME/.config/yadm/encrypt"
echo ""

# Encrypt
echo "🔐 Encrypting files..."
if yadm encrypt; then
    echo "✓ Encryption successful"
else
    echo "❌ Encryption failed"
    exit 1
fi

echo ""

# Check if archive exists
if [[ ! -f "$HOME/.local/share/yadm/archive" ]]; then
    echo "❌ Error: Encrypted archive not created"
    exit 1
fi

echo "✓ Encrypted archive created at: ~/.local/share/yadm/archive"
echo ""

# Stage the archive
echo "📦 Staging encrypted archive..."
yadm add ~/.local/share/yadm/archive

echo "✓ Archive staged"
echo ""

# Show status
echo "Current yadm status:"
yadm status --short
echo ""

# Prompt for commit
echo "Ready to commit!"
echo ""
read -p "Enter commit message (or press Enter for default): " commit_msg

if [[ -z "$commit_msg" ]]; then
    commit_msg="Update encrypted API keys"
fi

# Commit
yadm commit -m "$commit_msg"

echo ""
echo "✅ Done! Changes committed."
echo ""
echo "Next steps:"
echo "  1. Push to remote: yadm push"
echo "  2. On new machines, run: yadm decrypt"
echo ""

