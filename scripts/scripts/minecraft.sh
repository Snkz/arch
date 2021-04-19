#!/bin/sh
#-------------------------------------------------------------------------------
# file:            ./scripts/minecraft.sh                                               
# author:          Abdi Dahir - I have no website :(                           
# modified:        December 2011                                               
# vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:                     
# 
# fix for minecraft, still super buggy. Maybe I should buy some RAM. 
# ------------------------------------------------------------------------------

export LD_LIBRARY_PATH="/opt/java/jre/lib/i386"
java -Xmx768M -Xms512M -cp .minecraft/minecraft.jar net.minecraft.LauncherFrame
