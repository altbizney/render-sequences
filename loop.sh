#!/bin/sh

bold=$(tput bold)
normal=$(tput sgr0)

if [ ! -d "input" ]; then
    echo "! ${bold}input dir does not exist.${normal}"
    exit 1
fi

mkdir -p output

for d in input/*; do
    input=${d#input/}

    if [ -f "output/${input}.mov" ]; then
        echo "~~~${bold}Skipping ${input}, output/${input}.mov already exists...${normal}"
        continue
    fi

    ./sort.sh "${input}"

    # don't call ./render if ./sort failed
    if [ $? -eq 0 ]; then
        ./render.sh "${input}"
    fi
done
