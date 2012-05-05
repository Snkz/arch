#!/bin/sh
#-------------------------------------------------------------------------------
# file:            scripts/dictionary.sh                                               
# author:          Abdi Dahir - I have no website :(                           
# modified:        Feburary 2012                                              
# vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:                     
#    
# Dictonary script based on one found on the dzen wiki
#-------------------------------------------------------------------------------

LOOKUP=`sselp`
FONT="-*-terminus-*-*-*-*-12-*-*-*-*-*-iso8859-*"
(echo "$LOOKUP"; dict "$LOOKUP") | \
    dzen2 -l 8 -p -w 500 -bg darkblue -fg grey75 -x 300 -y 300 \
    -e 'key Escape=ungrabkeys,exit;onstart=uncollapse;button4=scrollup;button5=scrolldown;button1=exit' \
    -fn $FONT 
