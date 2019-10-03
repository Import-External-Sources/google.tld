#!/bin/bash
# Created by: Spirillen
# Copyright: Spirillen - https://gitlab.com/spirillen
# Repo Url: https://gitlab.com/rpz-zones/google.tld
# LICENSE: GNU Affero General Public License v3.0

TEMP=`(mktemp)`
RPZ=`(mktemp)`
ACTIVE=`(${TRAVIS_BUILD_DIR}/dev-tools/output/domains/ACTIVE/list)`

cat ${ACTIVE} | awk '/^#/{ next }; { printf("%s\n",tolower($1)) }' >> ${TEMP}
mv ${TEMP} ${TRAVIS_BUILD_DIR}/domains.list

printf "google-rpz.mypdns.cloud.\t3600\tIN\tSOA\tneed.to.know.only. hostmaster.mypdns.org. `date +%s` 3600 60 604800 60;\ngoogle-rpz.mypdns.cloud.\t3600\tIN\tNS\tlocalhost\n" > ${RPZ}
cat ${ACTIVE} | awk '/^#/{ next }; {  printf("%s\tCNAME\t.\n*.%s\tCNAME\t.\n",tolower($1),tolower($1)) }' >> ${RPZ}
mv ${RPZ} ${TRAVIS_BUILD_DIR}/google-rpz.mypdns.cloud.rpz

exit ${?}
