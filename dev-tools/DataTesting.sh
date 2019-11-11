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
    ulimit -u
    cd ${TRAVIS_BUILD_DIR}/dev-tools

    hash PyFunceble

    if [[ -f "${pyfuncebleConfigurationFileLocation}" ]]
    then
        rm "${pyfuncebleConfigurationFileLocation}"
        rm "${pyfuncebleProductionConfigurationFileLocation}"
    fi

   PyFunceble --travis -psl -ex -dbr 30 --http --plain --cmd-before-end "bash ${TRAVIS_BUILD_DIR}/dev-tools/FinalCommit.sh" --plain --autosave-minutes 30 --commit-autosave-message "V1.${yeartag}.${monthtag}.${TRAVIS_BUILD_NUMBER} [Stop Google]" --commit-results-message "Live google domains tested V1.${yeartag}.${monthtag}.${TRAVIS_BUILD_NUMBER} [skip ci]" -f ${input}
}

RunFunceble

exit ${?}
