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
        Chrome)   chromium                      &;;
        Home)     xterm -e ranger               &;;
        Info)     xterm -e ./scripts/arch.sh    &;;
        Power)    ./scripts/power.sh            &;;
        *)        echo "WHAT?"                   ;;
    esac
}

if [ -n "$1" ]; then
    runcommand "$1"
    exit
fi

monitor=1;
height=$((`xrandr --current | grep 'eDP1' | awk "NR==1{print $1}" | cut -d 'x' -f2 | cut -d '+' -f1` - 20))
width=$(xrandr --current | grep 'eDP1' | awk "NR==1{print $1}" | cut -d 'x' -f1 | cut -d ' ' -f4)
# Menu
arch="^bg()^fg(blue)^i(confs/xbm8x8/arch_10x10.xbm)"
chrome="^ib(1)^bg()^fg(blue)^p(+10)^i(confs/xbm8x8/fs_01.xbm) Chrome ^p(+62)"
home="^ib(1)^bg()^fg(lightblue)^p(+10)^i(confs/xbm8x8/pacman.xbm) Home ^p(+62)"
info="^ib(1)^bg()^fg(yellow)^p(+10)^i(confs/xbm8x8/info_01.xbm) Info ^p(+62)"
power="^ib(1)^bg()^fg(white)^p(+10)^i(confs/xbm8x8/half.xbm) Power ^p(+62)"
# dzen settings
terminus="xos4 Terminus:pixelsize=16"
#dzen="dzen2 -dock -fn \"$terminus\" -x 0 -y $height -w 80 -h 24 -l 4 -m -p"
#terminus="-*-terminus-*-*-*-*-16-*-*-*-*-*-iso8859-*"
dzen="dzen2 -x 0 -y $height -w 80 -h 24 -l 4 -m -p"
#events="-e onstart=grabkeys;button1=menuprint,collapse,ungrabkeys;entertitle=uncollapse,grabmouse;leaveslave=collapse,ungrabmouse,ungrabkeys;button3=exit;key_Super_L=togglecollapse;"
events="-e button1=ungrabmouse,menuprint,collapse;entertitle=uncollapse,grabmouse;leaveslave=collapse,ungrabmouse;button3=exit;"

(echo "$arch"; echo -e "$chrome\n$home\n$info\n$power") \
    | $dzen $events | xargs -n1 $0
