#!/bin/bash


system_type=$(uname -s)

# Install rust/cargo: https://www.rust-lang.org/tools/install
if [ "$system_type" = "Darwin" ] || [ "$system_type" = "Linux" ]; then
    if ! command -v cargo &> /dev/null; then
        curl https://sh.rustup.rs -sSf | sh -s -- -y
    fi
fi

# Install lsd: https://github.com/lsd-rs/lsd
if [ "$system_type" = "Darwin" ]; then
    brew install lsd
else
    if command -v cargo &> /dev/null; then
        cargo install lsd
    fi
fi

# Install uv: https://github.com/astral-sh/uv
if [ "$system_type" = "Darwin" ] || [ ]"$system_type" = "Linux" ]; then
    if ! command -v uv &> /dev/null; then
        curl -LsSf https://astral.sh/uv/install.sh | sh
    fi
elif [ "$system_type" = "Windows_NT" ]; then
    if ! command -v uv &> /dev/null; then
        powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
    fi
fi

# Update uv
uv self update

# Install latest python, create a virtual environment, and activate it
uv python install 3.12.0
uv pin python 3.12.0
uv venv
source .venv/bin/activate
uv pip install pylance


if [ -n $LC_DB_DEVBOX ]; then
  sudo DATABRICKS_ALLOW_INSTALL=1 snap install go --classic
  go install github.com/bazelbuild/buildtools/buildifier@latest
fi
