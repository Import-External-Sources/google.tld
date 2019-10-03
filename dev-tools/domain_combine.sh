#!/usr/bin/env bash

#yeartag=$(date +%Y)
#monthtag=$(date +%m)

#input=domain.list

#rm ${input}
rm domain.list

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
    printf "$i\n" >> dev-tools/domain.test
done

rm $TLD

source ${TRAVIS_BUILD_DIR}/dev-tools/PrepareTravis.sh

bash ${TRAVIS_BUILD_DIR}/dev-tools/DataTesting.sh

exit ${?}
