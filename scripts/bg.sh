#!/bin/sh
#-------------------------------------------------------------------------------
# file:            ./scripts/bg.sh                                               
# author:          Abdi Dahir - I have no website :(                           
# modified:        December 2011                                               
# vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:                     
#    
# background slideshow, currently supports no input reading. ... maybe one day
#-------------------------------------------------------------------------------

INTERVAL=30
DIR="images/bgs"
while true; do
	for WALLPAPER in `ls $DIR`
	do
		feh --bg-scale $DIR"/"$WALLPAPER
		sleep $INTERVAL
	done
done
