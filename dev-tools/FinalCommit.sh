#!/usr/bin/env bash
# Created by: Spirillen
# Copyright: Spirillen - https://gitlab.com/spirillen
# Repo Url: https://gitlab.com/rpz-zones/google.tld
# LICENSE: GNU Affero General Public License v3.0

TEMP=`(mktemp)`
RPZ=`(mktemp)`
ACTIVE=${TRAVIS_BUILD_DIR}/dev-tools/output/domains/ACTIVE/list

# Let's output results to a equlant folder

mkdir -p ${TRAVIS_BUILD_DIR}/zone_files
results=${TRAVIS_BUILD_DIR}/zone_files

# Output a clean valid uptodate domainlist

awk '/^#|^$/{ next }; { printf("%s\n",tolower($1)) }' ${ACTIVE} >> ${TEMP}

cp ${TEMP} ${TRAVIS_BUILD_DIR}/domains.list
cp ${TEMP} ${results}/domains.list

# Output real rpz formatted

printf "google-rpz.mypdns.cloud.\t3600\tIN\tSOA\tneed.to.know.only. hostmaster.mypdns.org. `date +%s` 3600 60 604800 60;\ngoogle-rpz.mypdns.cloud.\t3600\tIN\tNS\tlocalhost\n" > ${RPZ}
awk '/^#|^$/{ next }; { printf("%s\tCNAME\t.\n*.%s\tCNAME\t.\n",tolower($1),tolower($1)) }' ${TEMP} >> ${RPZ}
  head ${RPZ}
mv ${RPZ} ${results}/google-rpz.mypdns.cloud.rpz

# Let's make it easy for unbound users

awk '/^#|^$/{ next }; { printf "local-zone: \"" $1 "\" always_nxdomain\n" }' ${TEMP} > ${results}/unbound_nxdomain.zone


# And for the people who still need to install an DNS Recursor, we make this
# hosts append

awk '/^#|^$/{ next }; { printf "0.0.0.0 $1\n" }' ${TEMP} > ${results}/hosts

git status

exit ${?}
