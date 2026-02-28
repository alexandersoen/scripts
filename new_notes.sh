#!/bin/bash

NOTE_TEMPLATE_DIR=/Users/alexander.soen/Documents/templates/notes

if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    exit -1
fi

# Clone and reset
git clone $NOTE_TEMPLATE_DIR $1
rm -rf "$1/.git"
cd $1
git init
