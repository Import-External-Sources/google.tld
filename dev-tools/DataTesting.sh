#!/usr/bin/env bash

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
    dateTime=$(date '+%F %X %:z (%Z)')
    ulimit -u
    cd ${TRAVIS_BUILD_DIR}/dev-tools

    hash PyFunceble

    if [[ -f "${pyfuncebleConfigurationFileLocation}" ]]
    then
        rm "${pyfuncebleConfigurationFileLocation}"
        rm "${pyfuncebleProductionConfigurationFileLocation}"
    fi

   PyFunceble --travis -q -psl -ex -dbr 30 --dns 127.0.0.1 --http --plain --cmd-before-end "bash ${TRAVIS_BUILD_DIR}/dev-tools/FinalCommit.sh" --autosave-minutes 30 --commit-autosave-message "${dateTime} v.${TRAVIS_BUILD_NUMBER} [Stop Google]" --commit-results-message "Live google domains tested ${dateTime} v.${TRAVIS_BUILD_NUMBER} [skip ci]" -f ${input}
}

RunFunceble

exit ${?}
