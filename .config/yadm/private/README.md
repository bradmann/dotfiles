# Private Configuration Files

This directory contains sensitive configuration files that are **encrypted using yadm's built-in GPG encryption**.

## Setup Instructions (Using yadm Encryption) ⭐ Recommended

yadm has built-in encryption that securely stores sensitive files in your dotfiles repository.

### 1. Create API Keys File

```bash
# Copy the template
cp ~/.config/yadm/private/api-keys.zsh.template ~/.config/yadm/private/api-keys.zsh

# Edit with your actual API keys
vim ~/.config/yadm/private/api-keys.zsh
```

### 2. Encrypt and Commit

```bash
# Encrypt all files listed in ~/.config/yadm/encrypt
yadm encrypt

# This creates an encrypted archive at ~/.local/share/yadm/archive
# Add it to your yadm repository
yadm add ~/.local/share/yadm/archive

# Commit the encrypted archive (NOT the plaintext file)
yadm commit -m "Add encrypted API keys"
yadm push
```

**Note**: The plaintext `api-keys.zsh` is automatically excluded from yadm via `.gitignore`.

### 3. On New Machines

When setting up a new machine:

```bash
# Clone your dotfiles
yadm clone <your-dotfiles-repo>

# Decrypt the archive (you'll be prompted for your GPG password)
yadm decrypt

# This restores ~/.config/yadm/private/api-keys.zsh
# Run bootstrap
yadm bootstrap
```

### 4. Updating API Keys

After changing your API keys:

```bash
# Edit the file
vim ~/.config/yadm/private/api-keys.zsh

# Re-encrypt
yadm encrypt

# Commit the updated archive
yadm add ~/.local/share/yadm/archive
yadm commit -m "Update API keys"
yadm push
```

## 🚀 Quick Reference - Helper Scripts

For convenience, helper scripts are provided:

### Encrypt and Commit (After Creating/Updating Keys)

```bash
~/.config/yadm/private/encrypt-and-commit.sh
```

This script will:
1. ✅ Verify your `api-keys.zsh` file exists
2. 🔐 Encrypt it using `yadm encrypt`
3. 📦 Stage the encrypted archive
4. 💾 Commit the changes
5. Show next steps (push to remote)

### Decrypt on New Machine

```bash
~/.config/yadm/private/decrypt-keys.sh
```

This script will:
1. ✅ Verify the encrypted archive exists
2. 🔓 Decrypt it using `yadm decrypt`
3. ✅ Verify the API keys file was restored
4. 🎯 Show which provider zsh-ai will use

### Test Provider Selection

```bash
~/.config/yadm/private/test-zsh-ai-provider.sh
```

This script checks which provider zsh-ai will use (llm or Gemini).

## Alternative: Separate Private Repository (Old Method)

<details>
<summary>Click to expand alternative setup using a separate Git repo</summary>

### 1. Create a Private Dotfiles Repository

```bash
# Initialize yadm for private files (separate from main dotfiles)
# You can use a private Git repository for this
mkdir -p ~/.config/yadm/private
cd ~/.config/yadm/private
git init
```

### 2. Create API Keys File

```bash
# Copy the template
cp api-keys.zsh.template api-keys.zsh

# Edit with your actual API keys
vim api-keys.zsh
```

### 3. Add to Private Git Repository

```bash
cd ~/.config/yadm/private
git add api-keys.zsh
git commit -m "Add API keys"

# Push to your private repository
git remote add origin <your-private-repo-url>
git push -u origin main
```

### 4. On New Machines

```bash
# Clone your main dotfiles
yadm clone <your-dotfiles-repo>
yadm bootstrap

# Clone your private dotfiles
cd ~/.config/yadm/private
git clone <your-private-repo-url> .
```

</details>

## Security Best Practices

1. **Never commit `api-keys.zsh` to your public dotfiles repository**
2. Use a **private Git repository** for sensitive files
3. Set appropriate **file permissions**:
   ```bash
   chmod 600 ~/.config/yadm/private/api-keys.zsh
   ```
4. Consider using a **secrets manager** (1Password, Bitwarden, etc.) for additional security
5. **Rotate your API keys** periodically

## Files in This Directory

- `api-keys.zsh.template` - Template showing the format (safe to commit to public repo)
- `api-keys.zsh` - Your actual API keys (NEVER commit to public repo)
- `README.md` - This file (safe to commit to public repo)

## Alternative: Environment-Specific Configuration

If you don't want to use a separate private repo, you can also:

1. **Use environment variables** set by your shell/system
2. **Store keys in a secrets manager** and retrieve them at runtime
3. **Use different config files per machine** (not tracked by yadm)

Example for manual setup without private repo:

```bash
# Create the file manually on each machine
cat > ~/.config/yadm/private/api-keys.zsh << 'EOF'
export GEMINI_API_KEY="your-actual-key"
EOF

chmod 600 ~/.config/yadm/private/api-keys.zsh
```

## What Goes in This File?

See `api-keys.zsh.template` for the format. Currently used for:
- Gemini API key (fallback when `llm` command is not available)
- Optional: Other AI provider API keys

## How zsh-ai Provider Selection Works

The configuration automatically selects the best available provider:

1. **If `llm` command is available** → Use `cmdline` provider with `llm agent -t`
2. **If `llm` is not found** → Fall back to Gemini API (requires API key)

To check which provider will be used, run:
```bash
~/.config/yadm/private/test-zsh-ai-provider.sh
```

### Installing llm

If you want to use the `llm` command (recommended for local/offline use):

```bash
# Install llm
pip install llm

# Configure it (optional - set up models)
llm keys set openai  # or other providers
llm models list
```

See: https://llm.datasette.io/

### Setting up Gemini API (Fallback)

If you don't have `llm` installed, create the API keys file:

```bash
cp ~/.config/yadm/private/api-keys.zsh.template ~/.config/yadm/private/api-keys.zsh
# Edit and add your Gemini API key
vim ~/.config/yadm/private/api-keys.zsh
```

Get a Gemini API key from: https://makersuite.google.com/app/apikey

