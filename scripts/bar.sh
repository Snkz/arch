#!/bin/sh
#-------------------------------------------------------------------------------
# file:            scripts/bar.sh                                               
# author:          Abdi Dahir - I have no website :(                           
# modified:        Feburary 2012                                              
# vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:                     
#    
# Print the bottom bar with the ARCH logo
#-------------------------------------------------------------------------------

ICON="^i(confs/xbm8x8/arch.xbm)"
FONT="-*-terminus-*-*-*-*-16-*-*-*-*-*-iso8859-*"
  echo $ICON | dzen2 -p -x 0 -y 932 -w 200 -ta l -fn $FONT -bg black -fg white 
