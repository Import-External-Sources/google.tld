#!/usr/bin/env bash

rm domain.list
OUTPUT=`(mktemp)`
TLD=`(mktemp)`
wget -qO- 'http://data.iana.org/TLD/tlds-alpha-by-domain.txt' | awk '/^#/{ next }; { printf("%s\n",tolower($1))}' > ${TLD}

mapfile -t a < google.list
mapfile -t b < $TLD

for((i=0;i<${#a[@]};i++));
do
    for ((j=0;j<${#b[@]};j++))
    do
        c+=(${a[i]}.${b[j]});
    done
done

for i in "${c[@]}"
do
    printf "$i\n" >> ${OUTPUT}
done

sort -u -i -f ${OUTPUT} -o dev-tools/domain.test

rm ${TLD} ${OUTPUT}

bash ${TRAVIS_BUILD_DIR}/dev-tools/PrepareTravis.sh

bash ${TRAVIS_BUILD_DIR}/dev-tools/DataTesting.sh

exit ${?}
