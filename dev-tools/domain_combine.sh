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
    printf "$i\n" >> domain.list
done

rm $TLD

head domain.list

cd dev-tools/

# ******************
# Set our Input File
# ******************

pyfuncebleConfigurationFileLocation=${CI_PROJECT_DIR}/dev-tools/.PyFunceble.yaml
pyfuncebleProductionConfigurationFileLocation=${CI_PROJECT_DIR}/dev-tools/.PyFunceble_production.yaml

# Run PyFunceble Testing
RunFunceble () {

    yeartag=$(date +%Y)
    monthtag=$(date +%m)
    ulimit -u
    cd ${TRAVIS_BUILD_DIR}/dev-tools

    hash PyFunceble

    if [[ -f "${pyfuncebleConfigurationFileLocation}" ]]
    then
        rm "${pyfuncebleConfigurationFileLocation}"
        rm "${pyfuncebleProductionConfigurationFileLocation}"
    fi

#    PyFunceble --travis -db -ex --dns 95.216.209.53 116.203.32.67 \
#        --cmd-before-end "bash ${TRAVIS_BUILD_DIR}/dev-tools/FinalCommit.sh" \
#        --plain --autosave-minutes 20 \
#        --commit-autosave-message "V1.${yeartag}.${monthtag}.${TRAVIS_BUILD_NUMBER} [Auto Saved]" \
#        --commit-results-message "V1.${yeartag}.${monthtag}.${TRAVIS_BUILD_NUMBER}" -f ${input}


PyFunceble --travis -db -ex -dbr 30 --autosave-minutes 2 --commit-autosave-message "V1.${yeartag}.${monthtag}.${TRAVIS_BUILD_NUMBER} [Google temp test]" \
	--commit-results-message "Live google domains tested ${yeartag}.${monthtag}.`date +%s`" \
	--cmd-before-end "bash FinalCommit.sh" -f ../domain.list

#cat output/domains/ACTIVE/list | awk '/^#/{ next }; { printf("%s\n",tolower($1)) }' >> ?
}

RunFunceble

exit ${?}
