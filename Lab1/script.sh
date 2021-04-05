#!/bin/bash

SOURCE_DIR=${1:-"lab_uno"}
RM_LIST=${2:-"lab_uno/2remove"}
TARGET_DIR=${3:-"bakap"}

if [[ ! -d ${TARGET_DIR} ]]; then
    mkdir ${TARGET_DIR}
fi

LIST=$(cat ${RM_LIST})
for ITEM in ${LIST}; do
    if [[ -e ${SOURCE_DIR}/${ITEM} ]]; then
        rm -r ${SOURCE_DIR}/${ITEM}
    fi
done

LIST2=$(ls ${SOURCE_DIR}/)
for ITEM in ${LIST2}; do
    if [[ -f ${SOURCE_DIR}/${ITEM} ]]; then
        mv ${SOURCE_DIR}/${ITEM} ${TARGET_DIR}/
    elif [[ -d ${SOURCE_DIR}/${ITEM} ]]; then
        cp -avr ${SOURCE_DIR}/${ITEM}/ ${TARGET_DIR}/ > /dev/null
    fi
done

COUNT=$(ls ${SOURCE_DIR} | wc -l)

if [[ ${COUNT} -gt 0 ]]; then
    echo "There's still something left..."
    if [[ ${COUNT} -ge 2 ]]; then
        echo "There are at least 2 files left"
    fi
    if [[ ${COUNT} -gt 4 ]]; then
        echo "There are more than 4 files left"
    elif [[ ${COUNT} -ge 2 ]] && [[ ${COUNT} -le 4 ]]; then
        echo "Jabadaba doo"
fi
else
    echo "And I am Iron Man"
fi

LIST3=$(ls ${TARGET_DIR})
for ITEM in ${LIST3}; do
    chmod -R ugo-w ${TARGET_DIR}/${ITEM}
done

DATA=$(date +%F)

zip -r bakap_${DATA}.zip ${TARGET_DIR} > /dev/null