#!/bin/bash

system_type=$(uname -s)
if [ "$system_type" = "Darwin" ]; then
    brew install lsd
else
    sudo apt install lsd
fi
