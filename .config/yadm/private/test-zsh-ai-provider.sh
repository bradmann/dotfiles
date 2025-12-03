#!/bin/bash

# Test script to check which zsh-ai provider will be used
# Run this to verify your configuration

echo "=== zsh-ai Provider Check ==="
echo ""

# Check for llm command
if command -v llm &> /dev/null; then
    echo "✓ llm command found at: $(which llm)"
    echo "  Version: $(llm --version 2>/dev/null || echo 'unknown')"
    echo ""
    echo "Provider will be: cmdline (using llm)"
    echo "Command: llm agent -t"
else
    echo "✗ llm command not found"
    echo "  Install with: pip install llm"
    echo ""
    echo "Provider will be: gemini (API fallback)"

    # Check for Gemini API key
    if [[ -f "$HOME/.config/yadm/private/api-keys.zsh" ]]; then
        source "$HOME/.config/yadm/private/api-keys.zsh"
        if [[ -n "$GEMINI_API_KEY" ]]; then
            echo "  ✓ Gemini API key is set"
        else
            echo "  ✗ Gemini API key is NOT set in api-keys.zsh"
        fi
    else
        echo "  ✗ API keys file not found at ~/.config/yadm/private/api-keys.zsh"
        echo "  Create it from the template:"
        echo "    cp ~/.config/yadm/private/api-keys.zsh.template ~/.config/yadm/private/api-keys.zsh"
        echo "    vim ~/.config/yadm/private/api-keys.zsh"
    fi
fi

echo ""
echo "=== Testing zsh-ai ==="
echo "To test, run in a new shell:"
echo "  # list all python files"
echo ""

