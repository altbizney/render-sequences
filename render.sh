#!/bin/sh

ID=${1%/}
FPS=${2:-30}
QSCALE=${3:-13}
SIZE=${4:-1920x1080}

bold=$(tput bold)
normal=$(tput sgr0)

if [ -z "${ID}" ]; then
    echo "! ${bold}Shot ID is required.${normal}"
    exit 1
fi

if [ ! -d "input/${ID}" ]; then
    echo "! ${bold}input/${ID} dir does not exist.${normal}"
    exit 1
fi

if [ ! -f "input/${ID}/${ID}_00000.png" ]; then
    echo "! ${bold}${ID}/${ID}_00000.png file does not exist.${normal}"
    exit 1
fi

COUNT=$(($(ls -1 input/${ID} | wc -l)))

echo "\t${bold}Rendering ${ID} (${COUNT} frames)...${normal}"

ffmpeg -loglevel panic -stats -y -probesize 5000000 -f image2 -r ${FPS} -i input/${ID}/${ID}_%05d.png -c:v prores_ks -profile:v 3 -qscale:v ${QSCALE} -vendor ap10 -pix_fmt yuv422p10le -s ${SIZE} -r ${FPS} -force_fps output/${ID}.mov
