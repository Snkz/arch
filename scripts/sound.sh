#!/bin/sh
#-------------------------------------------------------------------------------
# file:            ~/scripts/sound.sh                                            
# author:          Abdi Dahir - I have no website :(                           
# modified:        December 2011                                               
# vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:                      
#                                                                             
# Script to get sound for conky, 95% copied from online source but hey i get it! 
#-------------------------------------------------------------------------------

vol=`amixer get Master | grep "Mono:" | awk '{print $4}'`
if [ $vol == "[0%]" ]
then
	echo "[Mute]"
else
	echo $vol
fi
