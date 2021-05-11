#!/bin/bash -eu

FILE_NOT_FOUND=2

SECOND_FILE="./yolo.csv"

if [[ ! -f "${SECOND_FILE}" ]]; then
    echo "File not found "${SECOND_FILE}""
    exit ${FILE_NOT_FOUND}
fi


# Z pliku yolo.csv wypisz wszystkich, ktorych id jest liczba nieparzysta. Wyniki zapisz na standardowe wyjscie bledow
cat ${SECOND_FILE} | grep -E "^[0-9]{0,2}[1,3,5,7,9]{1}\," >&2

# Z pliku yolo.csv wypisz kazdego, kto jest wart dokladnie $2.99, $5.99 lub $9.99 milionow lub miliardow (tylko nazwisko i wartosc). Wyniki zapisz na standardowe wyjscie bledow
cat ${SECOND_FILE} | grep "\$[2,5,9]\.99.$" | cut -d',' -f3,7 >&2

# Z pliku yolo.csv wypisz kazdy numer IP, ktory w pierwszym i drugim oktecie ma po jednej cyfrze. Wyniki zapisz na standardowe wyjscie bledow
cat ${SECOND_FILE} | cut -d',' -f6 | grep -E "^[0-9]\.[0-9]\.[0-9]{1,3}\.[0-9]{1,3}" >&2