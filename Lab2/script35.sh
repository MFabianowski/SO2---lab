#!/bin/bash -eu

# RCs
DIR_NOT_FOUND=3
ARG_NOT_FOUND=200

DATE=$(date +%F)

if [[ -z "${1:-}" ]] || [[ -z "${2:-}" ]]; then
    echo "You must provide all arguments!"
    exit ${ARG_NOT_FOUND}
fi

PATH_1="${1}"
FILE_NAME="${2}"

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

FILE_LIST=$(ls "${ABS_PATH_1}")

cd "${ABS_PATH_1}"
touch "${FILE_NAME}"

for ITEM in ${FILE_LIST}; do
    if [[ -L "${ITEM}" ]]; then
        if [[ ! -e "${ITEM}" ]]; then
            echo "${ITEM} ${DATE}" >> ${FILE_NAME}
            unlink "${ITEM}"
        fi
    fi
done