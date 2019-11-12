#!/usr/bin/env bash
# Created by: Spirillen
# Copyright: Spirillen - https://gitlab.com/spirillen
# Repo Url: https://gitlab.com/rpz-zones/google.tld
# LICENSE: GNU Affero General Public License v3.0

TEMP=`(mktemp)`
RPZ=`(mktemp)`
ACTIVE=${TRAVIS_BUILD_DIR}/dev-tools/output/domains/ACTIVE/list

# Output a clean valid uptodate domainlist

cat ${ACTIVE} | awk '/^#|^$/{ next }; { printf("%s\n",tolower($1)) }' >> ${TEMP}
  head ${TEMP}
mv ${TEMP} ${TRAVIS_BUILD_DIR}/domains.list

# Output real rpz formatted

printf "google-rpz.mypdns.cloud.\t3600\tIN\tSOA\tneed.to.know.only. hostmaster.mypdns.org. `date +%s` 3600 60 604800 60;\ngoogle-rpz.mypdns.cloud.\t3600\tIN\tNS\tlocalhost\n" > ${RPZ}
cat ${ACTIVE} | awk '/^#|^$/{ next }; { printf("%s\tCNAME\t.\n*.%s\tCNAME\t.\n",tolower($1),tolower($1)) }' >> ${RPZ}
  head ${RPZ}
mv ${RPZ} ${TRAVIS_BUILD_DIR}/google-rpz.mypdns.cloud.rpz

head ${TRAVIS_BUILD_DIR}/google-rpz.mypdns.cloud.rpz ${TRAVIS_BUILD_DIR}/domains.list

# Let's make it easy for unbound users

awk '/^#|^$/{ next }; { printf "local-zone: \"" $1 "\" always_nxdomain\n" }' ${ACTIVE} > ${TRAVIS_BUILD_DIR}/unbound_nxdomain.zone


# And for the people who still need to install an DNS Recursor, we make this
# hosts append

awk '/^#|^$/{ next }; { printf "0.0.0.0 $1\n" }' ${ACTIVE} > ${TRAVIS_BUILD_DIR}/hosts

git status

exit ${?}
