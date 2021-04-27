#!/bin/bash -eu

# RCs
DIR_NOT_FOUND=3
ARG_NOT_FOUND=200


if [[ -z "${1:-}" ]] || [[ -z "${2:-}" ]]; then
    echo "You must provide all arguments!"
    exit ${ARG_NOT_FOUND}
fi

PATH_1="${1}"
PATH_2="${2}"

if [[ ! -d "${PATH_1}" ]] || [[ ! -d "${PATH_2}" ]]; then
    echo "One of the directories does not exist!"
    exit ${DIR_NOT_FOUND}
fi

if [[ "${PATH_1}" = /* ]]; then
    ABS_PATH_1="${PATH_1}"
else
    ABS_PATH_1=`cd "${PATH_1}"; pwd`
    echo "Absolute path: "${ABS_PATH_1}""
fi

if [[ "${PATH_2}" = /* ]]; then
    ABS_PATH_2="${PATH_2}"
else
    ABS_PATH_2=`cd "${PATH_2}"; pwd`
    echo "Absolute path: "${ABS_PATH_2}""
fi

PATH_1_FILES=$(ls "${ABS_PATH_1}")

for ITEM in ${PATH_1_FILES}; do
    if [[ -d "${ABS_PATH_1}"/"${ITEM}" ]]; then
        echo ""${ITEM}" is a directory"
        if [[ "${ITEM}" == *"."* ]]; then
            NAME="${ITEM%.*}"
            EXT="${ITEM##*.}"
            UPCASE="${NAME^^*}_ln.${EXT}"
        else
            NAME="${ITEM%.*}"
            UPCASE="${NAME^^*}_ln"
        fi
        ln -s "${ABS_PATH_1}"/"${ITEM}" "${ABS_PATH_2}"/"${UPCASE}"
        #mv "${ABS_PATH_2}"/"${ITEM}" "${ABS_PATH_2}"/"${ITEM^^}_ln"
    elif [[ -L "${ABS_PATH_1}"/"${ITEM}" ]]; then
        echo ""${ITEM}" is a symbolic link"
        ln -s "${ABS_PATH_1}"/"${ITEM}" "${ABS_PATH_2}"/"${ITEM}"
    elif [[ -f "${ABS_PATH_1}"/"${ITEM}" ]]; then
        echo ""${ITEM}" is a regular file"
        if [[ "${ITEM}" == *"."* ]]; then
            NAME="${ITEM%.*}"
            EXT="${ITEM##*.}"
            UPCASE="${NAME^^*}_ln.${EXT}"
        else
            NAME="${ITEM%.*}"
            UPCASE="${NAME^^*}_ln"
        fi
        ln -s "${ABS_PATH_1}"/"${ITEM}" "${ABS_PATH_2}"/"${UPCASE}"
        #mv "${ABS_PATH_2}"/"${ITEM}" "${ABS_PATH_2}"/"${ITEM^^}_ln"
    fi
done