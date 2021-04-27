#!/bin/bash -eu

# RCs
DIR_NOT_FOUND=3
ARG_NOT_FOUND=200


if [[ -z "${1:-}" ]]; then
    echo "You must provide all arguments!"
    exit ${ARG_NOT_FOUND}
fi

PATH_1="${1}"

if [[ ! -d "${PATH_1}" ]]; then
    echo "Directory does not exist!"
    exit ${DIR_NOT_FOUND}
fi

if [[ "${PATH_1}" = /* ]]; then
    ABS_PATH_1="${PATH_1}"
else
    ABS_PATH_1=`cd "${PATH_1}"; pwd`
    echo "Absolute path: "${ABS_PATH_1}""
fi

FILES=$(ls "${ABS_PATH_1}")

cd "${ABS_PATH_1}"

for ITEM in ${FILES}; do
    if [[ "${ITEM}" == *".bak"* ]] && [[ -d "${ITEM}" ]]; then
        chmod o+x,ug-x "${ITEM}"
    elif [[ "${ITEM}" == *".tmp"* ]] && [[ -d "${ITEM}" ]]; then
        chmod a=w "${ITEM}"
    elif [[ "${ITEM}" == *".bak"* ]] && [[ -f "${ITEM}" ]]; then
        chmod uo-w "${ITEM}"
    elif [[ "${ITEM}" == *".txt"* ]] && [[ -f "${ITEM}" ]]; then
        chmod u=r,g=w,o=x "${ITEM}"
    elif [[ "${ITEM}" == *".exe"* ]] && [[ -f "${ITEM}" ]]; then
        chmod a=xs "${ITEM}"
    fi
done

