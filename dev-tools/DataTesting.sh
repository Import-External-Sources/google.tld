#!/usr/bin/env bash

# ******************
# Set our Input File
# ******************
input="${TRAVIS_BUILD_DIR}/dev-tools/domain.test"
pyfuncebleConfigurationFileLocation="${TRAVIS_BUILD_DIR}/dev-tools/.PyFunceble.yaml"
pyfuncebleProductionConfigurationFileLocation="${TRAVIS_BUILD_DIR}/dev-tools/.PyFunceble_production.yaml"

# Run PyFunceble Testing
RunFunceble () {

    yeartag=$(date +%Y)
    monthtag=$(date +%m)
    dateTime=$(date '+%F %T %:z (%Z)')
    
    cd "${TRAVIS_BUILD_DIR}/dev-tools"

    hash PyFunceble

    if [[ -f "${pyfuncebleConfigurationFileLocation}" ]]
    then
        rm "${pyfuncebleConfigurationFileLocation}"
        rm "${pyfuncebleProductionConfigurationFileLocation}"
    fi

   PyFunceble --ci -q -ex -dbr 30 --dns 127.0.0.1:5300 8.8.8.8 8.8.4.4 -h --plain \
        --autosave-minutes 30 -db --database-type mariadb \
        --hierarchical --ci-branch processing \
        -m -p "$(nproc --ignore=1)" \
        --ci-branch  master \
        --ci-distribution-branch master \
        --commit-autosave-message "${dateTime} ${TRAVIS_BUILD_NUMBER} [Stop Google]" \
        --commit-results-message "Live google domains tested ${dateTime} ${TRAVIS_BUILD_NUMBER}" \
        --cmd-before-end "bash ${TRAVIS_BUILD_DIR}/dev-tools/FinalCommit.sh" \
        -f ${input}
}

RunFunceble

exit ${?}
