#!/bin/bash

# Helper script to decrypt API keys on a new machine
# Run this after: yadm clone <repo> && yadm bootstrap

set -e

echo "=== yadm Decryption Helper ==="
echo ""

# Check if archive exists
if [[ ! -f "$HOME/.local/share/yadm/archive" ]]; then
    echo "❌ Error: Encrypted archive not found at ~/.local/share/yadm/archive"
    echo ""
    echo "Make sure you've cloned your yadm repository:"
    echo "  yadm clone <your-repo-url>"
    exit 1
fi

echo "✓ Found encrypted archive"
echo ""

# Check if GPG is available
if ! command -v gpg &> /dev/null; then
    echo "❌ Error: GPG not found"
    echo "   Install GPG to decrypt:"
    echo "   - macOS: brew install gnupg"
    echo "   - Linux: sudo apt install gnupg (or equivalent)"
    exit 1
fi

echo "✓ GPG is available"
echo ""

# Decrypt
echo "🔓 Decrypting files..."
echo "   (You'll be prompted for your GPG password)"
echo ""

if yadm decrypt; then
    echo ""
    echo "✅ Decryption successful!"
    echo ""

    # Verify the file was created
    if [[ -f "$HOME/.config/yadm/private/api-keys.zsh" ]]; then
        echo "✓ API keys file restored at: ~/.config/yadm/private/api-keys.zsh"
        echo ""

        # Test which provider will be used
        if command -v llm &> /dev/null; then
            echo "✓ zsh-ai will use: cmdline (llm command)"
        else
            echo "✓ zsh-ai will use: gemini (API key from decrypted file)"
        fi
        echo ""
        echo "Restart your shell to use zsh-ai:"
        echo "  exec zsh"
    else
        echo "⚠️  Warning: API keys file not found after decryption"
        echo "   Check ~/.config/yadm/encrypt patterns"
    fi
else
    echo ""
    echo "❌ Decryption failed"
    echo ""
    echo "Troubleshooting:"
    echo "  - Make sure you're using the same GPG key"
    echo "  - Check if you have the correct password"
    echo "  - Verify the archive wasn't corrupted"
    exit 1
fi

echo ""

