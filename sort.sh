#!/bin/sh

ID=$1

pushd () {
    command pushd "$@" > /dev/null
}

popd () {
    command popd "$@" > /dev/null
}

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

COUNT=$(($(ls -1 input/${ID} | wc -l)))

if (( $COUNT == 0 )); then
    echo "! ${bold}input/${ID} dir is empty.${normal}"
    exit 1
fi

LAST=$(printf "%05d" $(expr $COUNT - 1))
LAST_MATCH="input/${ID}/${ID}_${LAST}.png"
LAST_FILE=$(ls -1 input/${ID}/*.png | tail -1)

if [[ -f "input/${ID}/${ID}_00000.png" && $LAST_MATCH = $LAST_FILE ]]; then
    echo "~~~${bold}input/${ID} dir does not need sorting.${normal}"
    exit
fi

echo "\t${bold}Sorting ${ID}...${normal}"

pushd input/$ID

a=0
for i in *.png; do
    new=$(printf -- "${ID}_%05d.png" "$a")
    mv -- "$i" "$new"
    let a=a+1
done

popd
