#!/bin/bash -eu

FILE_NOT_FOUND=2

FIRST_FILE="./access_log"

if [[ ! -f "${FIRST_FILE}" ]]; then
    echo "File not found "${FIRST_FILE}""
    exit ${FILE_NOT_FOUND}
fi


# Znajdz w pliku access_log zapytania, ktore maja fraze "denied" w linku
cat ${FIRST_FILE} | grep "\/denied\/*" > denied.txt

# Znajdz w pliku access_log zapytania typu POST
cat ${FIRST_FILE} | grep "\"POST " > post.txt

# Znajdz w pliku access_log zapytania wysane z IP: 64.242.88.10
cat ${FIRST_FILE} | grep "^64\.242\.88\.10" > IP.txt

# Znajdz w pliku access_log wszystkie zapytania NIE WYSLANE z adresu IP tylko z FQDN
cat ${FIRST_FILE} | grep -E -v "^[0-9][0-9]?[0-9]?\." | grep -E -v "^\[" | grep -E -v "^[0-9]{1,3}x[0-9]{1,3}x[0-9]{1,3}x[0-9]{1,3}"> FQDN.txt

# Znajdz w pliku access_log unikalne zapytania typu DELETE
cat ${FIRST_FILE} | grep "DELETE /" | sort -u > delete.txt

# Znajdz unikalnych 10 adresow IP w access_log
cat ${FIRST_FILE} | grep -E -o "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" | sort -u | head -n10 > uniqueIPs.txt
