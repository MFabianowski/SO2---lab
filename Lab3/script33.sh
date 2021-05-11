#!/bin/bash -eu

DIR_NOT_FOUND=3

GROOVY_DIR="groovies"

if [[ ! -d "${GROOVY_DIR}" ]]; then
    echo "Directory not found "${GROOVY_DIR}""
    exit ${DIR_NOT_FOUND}
fi

PATH_FILES=$(ls ${GROOVY_DIR})

cd ${GROOVY_DIR}

for ITEM in ${PATH_FILES}; do
    # We wszystkich plikach w katalogu groovies zamien $HEADER$ na /temat/
    sed -i 's|\$HEADER\$|\/temat\/|g' ${ITEM}
    # We wszystkich plikach w katalogu groovies po kazdej linijce z class dodac String marker = "/!@$%/"
    sed -i '/class/a\ String marker = "/!@$%/"' ${ITEM}
    # We wszystkich plikach w katalogu groovies usu linijki zawierajace fraze Help docs
    sed -i '/Help docs/d' ${ITEM}
done
