#!/bin/sh
#-------------------------------------------------------------------------------
# file:            .scripts/weather.sh                                              
# author:          Michael Seiler 2007                           
# modified:        December 2011                                               
# vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:                      
#                                                                             
# found this on the arch board, written to allow weather updates for conky 
#-------------------------------------------------------------------------------

METRIC=1 #0 for F, 1 for C

if [ -z $1 ]; then 
	echo
	echo "USAGE: weather.sh <locationcode>"
	echo
	exit 0;
fi

WEATHER=`curl --connect-timeout 30 -s http://rss.accuweather.com/rss/liveweather_rss.asp\?metric\=${METRIC}\&locCode\=$1 | perl -ne 'if (/Currently/) {chomp;/\<title\>Currently: (.*)?\<\/title\>/; print "$1"; }'`

if [ -z $WEATHER ]; then
	echo "unk"
	exit 0;
fi

echo $WEATHER 
