#!/bin/bash

system_type=$(uname -s)
if [ "$system_type" = "Darwin" ]; then
    brew install lsd
else
    if ! command -v cargo &> /dev/null; then
        curl https://sh.rustup.rs -sSf | sh -s -- -y
    fi
    cargo install lsd
fi

if [ -n $LC_DB_DEVBOX ]; then
  sudo DATABRICKS_ALLOW_INSTALL=1 snap install go --classic
  go install github.com/bazelbuild/buildtools/buildifier@latest
  sudo DATABRICKS_ALLOW_INSTALL=1 add-apt-repository ppa:deadsnakes/ppa
  sudo DATABRICKS_ALLOW_INSTALL=1 apt-get update
  sudo DATABRICKS_ALLOW_INSTALL=1 apt-get install python3.12
  python3 -m pip install pylance
fi
