#!/bin/sh
#-------------------------------------------------------------------------------
# file:            ~/scripts/menu.sh                                            
# author:          Abdi Dahir - I have no website :(                           
# modified:        April 2012                                              
# vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:                      
#
# Basic dzen2 menu.
#-------------------------------------------------------------------------------


runcommand() 
{
    case $1 in
        Fire)     firefox    &;;
        Info)     xterm -e ./arch.sh  &;;
        Power)    ./power.sh &;;
        *)        echo "WHAT?";;
    esac
}

if [ -n "$1" ]; then
    runcommand "$1"
    exit
fi

# Menu
arch="^bg()^fg(blue)^i(../confs/xbm8x8/arch_10x10.xbm)"
firefox="^bg(black)^fg(red)^p(+10)^i(../confs/xbm8x8/fox.xbm) Fire ^p(+62)"
info="^bg(black)^fg(yellow)^p(+10)^i(../confs/xbm8x8/info_01.xbm) Info ^p(+62)"
power="^bg(black)^fg(white)^p(+10)^i(../confs/xbm8x8/half.xbm) Power ^p(+62)"
# dzen settings
terminus="-*-terminus-*-*-*-*-12-*-*-*-*-*-iso8859-*"
dzen="dzen2 -fn $terminus -x 0 -y 748 -w 80 -h 20 -l 3 -m -p"
#events="-e onstart=grabkeys;button1=menuprint,collapse,ungrabkeys;entertitle=uncollapse,grabmouse;leaveslave=collapse,ungrabmouse,ungrabkeys;button3=exit;key_Super_L=togglecollapse;"
events="-e button1=ungrabmouse,menuprint,collapse;entertitle=uncollapse,grabmouse;leaveslave=collapse,ungrabmouse;button3=exit;"
(echo "$arch"; echo -e "$firefox\n$info\n$power") \
    | $dzen $events | xargs -n1 $0

