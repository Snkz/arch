#!/bin/sh
#
# by lyon8 some dude from the interwebs

BG="000000"             #BACKGROUND
FG="FFFFFF"             #FOREGROUND
W=150                   #DZEN WIDTH
GW=50                   #GAUGE WIDTH
GFG="#FFFFFF"           #GAUGE COLOUR
GH=7                    #GAUGE HEIGHT
X=100                   #X POS
Y=100                   #Y POS
FN="fixed"              #FONT

STATEFILE="/proc/acpi/battery/BAT0/state"   #BAT STATE INFO
INFOFILE="/proc/acpi/battery/BAT0/info"     #BAT INFO FILE

LOWBAT=24                                   #LOW BAT PERCENTAGE MARKER
LOWCOL="FF4747"                             #LOW BAT PERCENTAGE COLOUR
TIME_INT=1                                  #REPEAT TIME INTERVAL

PREBAR="^i(~/confs/xbm8x8/bat_low-02.xbm)"  #BATTERY SYMBOL

while true; do
    #Look up battery data
    BAT_FULL=`acpi -V |grep design|line|cut -d " " -f 11`;
    STATUS=`acpi -V|grep charging|cut -d " " -f 12`;
    RCAP=`cat $STATEFILE|grep remaining|cut -d " " -f 8`;

    #Calculate remaining power
    RPERCT=`expr $RCAP \* 100`;
    RPERC=`expr $RPERCT / $BAT_FULL`;

    #Draw the bar
    if [$RPERC -le $LOWBAT ]; then GFG=$LOWCOL; fi
    echo -n $PREBAR
    eval echo $RPERC | gdbar -h $GH -w $GW -fg $GFG -b $GBG
    sleep $TIME_INT;
done | dzen2 -ta c -tw $W -y $Y -x $X -fg $FG -bg $bg -fn $FN
