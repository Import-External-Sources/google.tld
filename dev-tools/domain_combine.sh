#!/usr/bin/env bash

yeartag=$(date +%Y)
monthtag=$(date +%m)

input=${CI_BUILDS_DIR}/PULL_REQUESTS/domain.list

rm domains.list

TLD=`(mktemp)`
wget -qO- 'http://data.iana.org/TLD/tlds-alpha-by-domain.txt' | awk '/^#/{ next }; { printf("%s\n",tolower($1))}' > ${TLD}

mapfile -t a < domain.list
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
    printf "$i\n" >> ${input}
done

rm $TLD

PyFunceble --travis -db -ex --autosave-minutes 20 --commit-autosave-message "V1.${yeartag}.${monthtag}.${TRAVIS_BUILD_NUMBER} [Google temp test]" \
	--commit-results-message "Live google domains tested ${yeartag}.${monthtag}.`date +%s`" \
	--cmd-before-end "bash ${CI_BUILDS_DIR}/dev-tools/FinalCommit.sh" -f ${input}

#cat output/domains/ACTIVE/list | awk '/^#/{ next }; { printf("%s\n",tolower($1)) }' >> ?

exit ${?}
