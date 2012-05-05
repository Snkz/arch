# Menu
turnoff="^bg(black)^fg(white)^ca(1,xterm)^p(+10)^i(../confs/xbm8x8/full.xbm) Power Off ^p(+60)^ca()"
reboot="^bg(black)^fg(white)^p(+15)^i(../confs/xbm8x8/half.xbm) Restart ^p(+100)"
cancel="^bg(black)^fg(white)^p(+20)^i(../confs/xbm8x8/empty.xbm) Cancel ^p(+100)"
# dzen settings
terminus="-*-terminus-*-*-*-*-12-*-*-*-*-*-iso8859-*"
dzen="dzen2 -p -fn $terminus -x 540 -y 300 -w 300 -h 80 -l 3 -m h"
# event thing isn't working, clickable area used instead
events="-e button1=exit;button3=exit;"
echo -e "$turnoff\n$reboot\n$cancel" | $dzen $events 

