#!/bin/sh
#-------------------------------------------------------------------------------
# file:            ~/scripts/sound.sh                                            
# author:          Abdi Dahir - I have no website :(                           
# modified:        May 2012                                               
# vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:                      
#                                                                             
# Script to get sound for conky using amixer and a mono master speaker 
#-------------------------------------------------------------------------------

channel="Left:"
vol=`amixer get Master | grep $channel | awk '{print $5}'`
mute=`amixer get Master | grep $channel | awk '{print $7}'`
if [ $vol == "[0%]" ] || [ $mute == "[off]" ]
then
	echo "0"
else
	echo $vol | tr -d "[%]"
fi
