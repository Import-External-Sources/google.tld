#!/usr/bin/env bash

apt install -y curl wget dos2unix

curltemp=$(mktemp /tmp/curl_temp.XXXXXXXXXX) || { echo "Failed to create temp file"; exit 1; }
chmod +x {$curltemp,,}
trap "rm -f $curltemp" 0 2 3 15

curl -sSL  --compressed "https://github.com/FadeMind/hosts.extras/raw/master/hpHosts/hosts" | grep -v '^#' | grep -v '^-' | grep -v 'localhost' | cut -f2 >> {$curltemp,,}
curl -sSL  --compressed "https://github.com/FadeMind/hosts.extras/raw/master/rlwpx.free.fr.hrsk/hosts" | grep -v '^#' | grep -v '^-' | grep -v 'localhost' | cut -d' ' -f2 >> {$curltemp,,}
curl -sSL  --compressed "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-blocklist.txt" | sed -e 's/#.*$//g' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://hostsfile.mine.nu/hosts0.txt" | sed -e 's/#.*$//g; s/^ *//; s/ *$//; /^$/d; /^\s*$/d' |cut -f2 >> {$curltemp,,}
curl -sSL  --compressed "https://hosts-file.net/ad_servers.txt" | sed -e 's/#.*$//g; s/^ *//; s/ *$//; /^$/d; /^\s*$/d; /localhost$/d' | cut -f2 >> {$curltemp,,}
curl -sSL  --compressed "https://hosts-file.net/download/hosts.txt" | sed -e 's/#.*$//g; s/^ *//; s/ *$//; /^$/d; /^\s*$/d; /localhost$/d' | cut -f2 >> {$curltemp,,}
curl -sSL  --compressed "https://hosts-file.net/emd.txt" | sed -e 's/#.*$//g; s/^ *//; s/ *$//; /^$/d; /^\s*$/d; /localhost$/d' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://hosts-file.net/exp.txt" | sed -e 's/#.*$//g; s/^ *//; s/ *$//; /^$/d; /^\s*$/d; /localhost$/d' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://hosts-file.net/fsa.txt" | sed -e 's/#.*$//g; s/^ *//; s/ *$//; /^$/d; /^\s*$/d; /localhost$/d' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://hosts-file.net/grm.txt" | sed -e 's/#.*$//g; s/^ *//; s/ *$//; /^$/d; /^\s*$/d; /localhost$/d' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://hosts-file.net/hjk.txt" | sed -e 's/#.*$//g; s/^ *//; s/ *$//; /^$/d; /^\s*$/d; /localhost$/d' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://hosts-file.net/mmt.txt" | sed -e 's/#.*$//g; s/^ *//; s/ *$//; /^$/d; /^\s*$/d; /localhost$/d' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://hosts-file.net/psh.txt" | sed -e 's/#.*$//g; s/^ *//; s/ *$//; /^$/d; /^\s*$/d; /localhost$/d' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://hosts-file.net/pup.txt" | sed -e 's/#.*$//g; s/^ *//; s/ *$//; /^$/d; /^\s*$/d; /localhost$/d' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://hostsfile.org/Downloads/hosts.txt" | sed -e 's/#.*$//g; s/^ *//; s/ *$//; /^$/d; /^\s*$/d; /localhost/d' | cut -f2 >> {$curltemp,,}
curl -sSL  --compressed "https://mirror.cedia.org.ec/malwaredomains/immortal_domains.txt" | sed -e 's/#.*$//g; /^\s*$/d' >> {$curltemp,,}
curl -sSL  --compressed "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=nohtml&showintro=0" >> {$curltemp,,}
curl -sSL  --compressed "https://phishing.army/download/phishing_army_blocklist_extended.txt" | sed -e 's/#.*$//g; /^\s*$/d' >> {$curltemp,,}
curl -sSL  --compressed "https://ransomwaretracker.abuse.ch/downloads/CW_C2_DOMBL.txt" | sed -e 's/#.*$//g; /^\s*$/d' >> {$curltemp,,}
curl -sSL  --compressed "https://ransomwaretracker.abuse.ch/downloads/LY_C2_DOMBL.txt" | sed -e 's/#.*$//g; /^\s*$/d' >> {$curltemp,,}
curl -sSL  --compressed "https://ransomwaretracker.abuse.ch/downloads/RW_DOMBL.txt" | sed -e 's/#.*$//g; /^\s*$/d' >> {$curltemp,,}
curl -sSL  --compressed "https://ransomwaretracker.abuse.ch/downloads/TC_C2_DOMBL.txt" | sed -e 's/#.*$//g; /^\s*$/d' >> {$curltemp,,}
curl -sSL  --compressed "https://ransomwaretracker.abuse.ch/downloads/TL_C2_DOMBL.txt" | sed -e 's/#.*$//g; /^\s*$/d' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt" | sed -e 's/#.*$//g; /^\s*$/d' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/anudeepND/blacklist/master/CoinMiner.txt" | sed -e 's/#.*$//g; /^\s*$/d' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/anudeepND/blacklist/master/facebook.txt" | sed -e 's/#.*$//g; /^\s*$/d' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/anudeepND/youtubeadsblacklist/master/domainlist.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt" | sed -e 's/#.*$//g; /^\s*$/d' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/Dawsey21/Lists/master/main-blacklist.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/HorusTeknoloji/TR-PhishingList/master/url-lists.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/matomo-org/referrer-spam-blacklist/master/spammers.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/android-tracking.txt" | sed -e 's/#.*$//g; /^\s*$/d' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/Perflyst/PiHoleBlocklist/master/SmartTV.txt" | sed -e 's/#.*$//g; /^\s*$/d; s/\/\///g' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/StevenBlack/hosts/master/data/add.2o7Net/hosts" | awk '{print $2}' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/StevenBlack/hosts/master/data/add.Risk/hosts" | awk '{print $2}' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/StevenBlack/hosts/master/data/add.Spam/hosts" | awk '{print $2}' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/StevenBlack/hosts/master/data/KADhosts/hosts" | sed -e 's/#.*$//g; /^\s*$/d; s/\/\///g' | awk '{print $2}' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/StevenBlack/hosts/master/data/UncheckyAds/hosts" | awk '{print $2}' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts" | grep -v 'localhost' | grep -v 'ip6-' | grep -v local | grep -v broadcasthost| sed -e 's/#.*$//g; /^\s*$/d; s/\/\///g' | awk '{print $2}' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://raw.githubusercontent.com/vokins/yhosts/master/hosts" | grep -v '#' | awk '{print $2}' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://reddestdream.github.io/Projects/MinimalHosts/etc/MinimalHostsBlocker/minimalhosts" | grep -v '::' | grep -v '#' | awk '{print $2}' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt" | grep -v '#' | grep -v 'Malvertising list by Disconnect' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt" | grep -v '#' | grep -v 'Malvertising list by Disconnect' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://someonewhocares.org/hosts/zero/hosts" | grep -v '#' | grep -v '127.0.0.1' | grep -v '::' | grep -v 'broadcasthost'  | awk '{print $2}' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/AdAway.txt" | grep -v 'localhost' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/AdguardDNS.txt" | grep -v 'localhost' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Airelle-trc.txt" | grep -v 'localhost' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Cameleon.txt" | grep -v 'localhost' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Disconnect-ads.txt" | grep -v 'localhost' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Disconnect-mal.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Disconnect-trc.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Dshield-Sus.txt" | grep -v '^site$' >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Easylist-Dutch.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Easylist.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Easyprivacy.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/HostsFileOrg.txt" | grep -v '^localhost$' >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/HPHosts-ads.txt" | grep -v '^localhost$' >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/JoeWein.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/JoeyLane.txt" | grep -v '^localhost$' >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Kowabit.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/PeterLowe.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/PiwikSpam.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Prigent-Ads.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Quidsup-trc.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/ReddestDream.txt" | grep -v 'localhost' | grep -v 'broadcasthost' >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/SB2o7Net.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/SBKAD.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/SBSpam.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/SBUnchecky.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/SomeoneWC.txt" | grep -v 'localhost' | grep -v 'localhost.localdomain' | grep -v 'broadcasthost' | grep -v '^local$' >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Spam404.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Vokins.txt" >> {$curltemp,,}
curl -sSL  --compressed "https://v.firebog.net/hosts/Winhelp2002.txt" | grep -v '^localhost$' >> {$curltemp,,}
curl -sSL  --compressed "https://www.dshield.org/feeds/suspiciousdomains_High.txt" | grep -iv '^site$' | grep -v '#' >> {$curltemp,,}
curl -sSL  --compressed "https://www.dshield.org/feeds/suspiciousdomains_Low.txt" | grep -iv '^site$' | grep -v '#' >> {$curltemp,,}
curl -sSL  --compressed "https://www.dshield.org/feeds/suspiciousdomains_Medium.txt" | grep -iv '^site$' | grep -v '#' >> {$curltemp,,}
curl -sSL  --compressed "https://www.joewein.net/dl/bl/dom-bl-base.txt" | cut -d';' -f1 | grep -v '#' >> {$curltemp,,}
curl -sSL  --compressed "https://www.malwaredomainlist.com/hostslist/hosts.txt" | dos2unix | grep -v '#' | grep -iv 'localhost' | cut -d' ' -d' ' -f3 | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://www.squidblacklist.org/downloads/dg-ads.acl" | grep -v '#' >> {$curltemp,,}
curl -sSL  --compressed "https://www.squidblacklist.org/downloads/dg-malicious.acl" | grep -v '#' >> {$curltemp,,}
curl -sSL  --compressed "http://sysctl.org/cameleon/hosts" | grep -v '#' | grep -vi 'localhost' | cut -f2 | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://zerodot1.gitlab.io/CoinBlockerLists/hosts" | grep -v '#' | awk '{print $2}' >> {$curltemp,,}
curl -sSL  --compressed "https://zeustracker.abuse.ch/blocklist.php?download=baddomains" | grep -v '#' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "https://zeustracker.abuse.ch/blocklist.php?download=domainblocklist" | grep -v '#' | awk '/[a-z]$/{print $0}' >> {$curltemp,,}
curl -sSL  --compressed "http://winhelp2002.mvps.org/hosts.txt" | dos2unix | grep -v '#' | grep -vi 'localhost' | awk '/[a-z]$/{print $0}' | awk '{print $2}' >> {$curltemp,,}

wget -qO- "https://github.com/FadeMind/hosts.extras/raw/master/add.Risk/hosts" | cut -d ' ' -f 2 | sort -u >> {$curltemp,,}
wget -qO- "https://github.com/FadeMind/hosts.extras/raw/master/add.Spam/hosts" | cut -d ' ' -f 2 | sort -u >> {$curltemp,,}
wget -qO- "https://github.com/FadeMind/hosts.extras/raw/master/antipopads/hosts" | cut -d ' ' -f 2 | sort -u >> {$curltemp,,}
wget -qO- "https://github.com/FadeMind/hosts.extras/raw/master/blocklists-facebook/hosts" | cut -d ' ' -f 2 | sort -u >> {$curltemp,,}
wget -qO- "https://github.com/FadeMind/hosts.extras/raw/master/StreamingAds/hosts" | cut -d ' ' -f 2 | sort -u >> {$curltemp,,}
wget -qO- "https://github.com/FadeMind/hosts.extras/raw/master/UncheckyAds/hosts" | cut -d ' ' -f 2 | sort -u >> {$curltemp,,}
wget -qO- 'https://urlhaus.abuse.ch/downloads/rpz/' | dos2unix | grep -i '^[a-z0-9_]' | cut -d' ' -f 1 | sort -u >> {$curltemp,,}

wget -qO- "https://gitlab.com/ZeroDot1/CoinBlockerLists/raw/master/hosts?inline=false" | cut -d ' ' -f 2 | sort -u >> {$curltemp,,}
wget -qO- "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts" | cut -d ' ' -f 2 | sort -u >> {$curltemp,,}
wget -qO- "https://raw.githubusercontent.com/jawz101/MobileAdTrackers/master/hosts" | cut -d ' ' -f 2 | sort -u >> {$curltemp,,}

cat $curltemp | sort -u > hosts
rm -f $curltemp

#cat hosts | grep -i 'igoogle.com' | sort -u > ../domains/igoogle.com.list