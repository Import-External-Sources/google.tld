#!/usr/bin/env bash

# Copyright: https://www.mypdns.org/
# Content: https://www.mypdns.org/p/Spirillen/
# Source: https://github.com/Import-External-Sources/pornhosts
# License: https://www.mypdns.org/w/license
# License Comment: GNU AGPLv3, MODIFIED FOR NON COMMERCIAL USE
#
# License in short:
# You are free to copy and distribute this file for non-commercial uses,
# as long the original URL and attribution is included.
#
# Please forward any additions, corrections or comments by logging an
# issue at https://www.mypdns.org/maniphest/

set -e

printf "deb [arch=amd64] http://repo.powerdns.com/ubuntu %s-rec-master main\n" \
  "$(lsb_release -cs)" > "/etc/apt/sources.list.d/pdns.list"

printf "Package: pdns-*\nPin: origin repo.powerdns.com\nPin-Priority: 600" > \
  "/etc/apt/preferences.d/pdns"

curl "https://repo.powerdns.com/CBC8B383-pub.asc" | sudo apt-key add - && \
  sudo apt-get update -q && \
  sudo apt-get install -q pdns-recursor ldnsutils

# Lets get rit of known deadbeats by loading the Response policy zone
# for known pirated domains

cp "${TRAVIS_BUILD_DIR}/dev-tools/recursor.lua" "/etc/powerdns/recursor.lua"

# Since this systemd-resolved kill script also killed Travis we most change
# the default port of the recursor.... fuck!!!!!

sed -i "/local-address/d" "/etc/powerdns/recursor.conf"

printf "local-address=0.0.0.0\nlocal-port=5300\n" >> "/etc/powerdns/recursor.conf"

systemctl restart pdns-recursor.service

# Let the recursor load the RPZ zone before testing it
sleep 5

# Check if the recursor is listening to port on port 5300
if lsof -i :5300 | grep -q '^pdns_'
then
	printf "\n\tThe recursor is running on port 5300
	We carry on with our test procedure"
else
	printf "\n\tRecursor not running, We stops here\n"
	exit 1
fi

if drill 21x.org @127.0.0.1 -p 5300 | grep -qi "NXDOMAIN"
then
	printf "\n\tPirated domains Response policy zone My Privacy DNS is loaded... Good\n\n"
else
	printf "\t\nResponse policy zone not loaded, we are done for this time\n\n"
	exit 1
fi

exit ${?}
