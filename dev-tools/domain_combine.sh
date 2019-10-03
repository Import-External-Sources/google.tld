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

#head domain.list
head -n 5 ${TRAVIS_BUILD_DIR}/dev-tools/domain.test

# *********************************************
# Get Travis CI Prepared for Committing to Repo
# *********************************************

PrepareTravis () {
    git remote rm origin
    git remote add origin https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}.git
    git config --global user.email "${GIT_EMAIL}"
    git config --global user.name "${GIT_NAME}"
    git config --global push.default simple
    git checkout "${GIT_BRANCH}"
    ulimit -u
}
PrepareTravis

# ******************
# Set our Input File
# ******************
input=${TRAVIS_BUILD_DIR}/dev-tools/domain.test
pyfuncebleConfigurationFileLocation=${TRAVIS_BUILD_DIR}/dev-tools/.PyFunceble.yaml
pyfuncebleProductionConfigurationFileLocation=${TRAVIS_BUILD_DIR}/dev-tools/.PyFunceble_production.yaml

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

#  PyFunceble --travis -db -ex --dns 1.1.1.1 --autosave-minutes 10 --commit-autosave-message "V1.${yeartag}.${monthtag}.${TRAVIS_BUILD_NUMBER}" --commit-results-message "Live google domains tested ${yeartag}.${monthtag}." --cmd-before-end "bash ${TRAVIS_BUILD_DIR}/dev-tools/FinalCommit.sh" -f ${TRAVIS_BUILD_DIR}/dev-tools/domain.test
   PyFunceble --travis -db -ex --dns 1.1.1.1 1.0.0.1 --cmd-before-end "bash ${TRAVIS_BUILD_DIR}/dev-tools/FinalCommit.sh" --plain --autosave-minutes 20 --commit-autosave-message "V1.${yeartag}.${monthtag}.${TRAVIS_BUILD_NUMBER} [PyFunceble]" --commit-results-message "V1.${yeartag}.${monthtag}.${TRAVIS_BUILD_NUMBER}" -f ${input}
}

RunFunceble

exit ${?}
