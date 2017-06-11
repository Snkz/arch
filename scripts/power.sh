#!/bin/sh
#-------------------------------------------------------------------------------
# file:            ~/scripts/menu.sh                                            
# author:          Abdi Dahir - I have no website :(                           
# modified:        July 2014                                              
# vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:                      
#
# Basic dzen2 power menu.
#-------------------------------------------------------------------------------


runcommand() 
{
    case $1 in
        Shutdown)   shutdown now                &;;
        Restart)    shutdown -r now             &;;
        Lock)       slock                       &;;
        Exit)       echo ""                     &;;
        *)          echo "WHAT?"                 ;;
    esac
}

if [ -n "$1" ]; then
    runcommand "$1"
    exit
fi


# Menu
turnoff="^ib(1)^fg(white)^p(+6)^i(confs/xbm8x8/full.xbm) Shutdown ^p()^fg(black)^p(-74)^ro(74x60)" 
reboot="^ib(1)^fg(white)^p(+9)^i(confs/xbm8x8/half.xbm) Restart ^p()^fg(black)^p(-74)^ro(74x60)"
lock="^ib(1)^fg(white)^p(+16)^i(confs/xbm8x8/empty.xbm) Lock ^p()^fg(black)^p(-74)^ro(74x60)" 
ext="^ib(1)^fg(white)^p(+16)^i(confs/xbm8x8/test.xbm) Exit ^p()^fg(black)^p(-74)^ro(74x60)" 

height=$((`xrandr --current | grep 'eDP1' | awk "NR==1{print $1}" | cut -d 'x' -f2 | cut -d '+' -f1` / 2 ))
width=$((`xrandr --current | grep 'eDP1' | awk "NR==1{print $1}" | cut -d 'x' -f1 | cut -d ' ' -f4` / 2 - 40))

# dzen settings
terminus="-*-terminus-*-*-*-*-12-*-*-*-*-*-iso8859-*"
dzen="dzen2 -p -fn $terminus -x 940 -y 600 -w 380 -h 60 -l 4 -m h"
# event thing isn't working, clickable area used instead
events="-e onstart=raise;button1=ungrabmouse,menuprint,collapse,exit;button3=print:Exit,exit;"
echo -e "$turnoff\n$reboot\n$lock\n$ext" | $dzen $events | xargs -n1 $0 

