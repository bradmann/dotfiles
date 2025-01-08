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
