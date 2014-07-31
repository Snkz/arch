#-------------------------------------------------------------------------------
# file:            ~/.xinitrc                                              
# author:          Abdi Dahir - I have no website :(                           
# modified:        December 2011                                               
# vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:                      
#                                                                             
# run fuckers
#-------------------------------------------------------------------------------


# Set cursor and font ----------------------------------------------------------
xsetroot -cursor_name left_ptr 
xset +fp /usr/share/fonts/local
xset fp rehash
xmodmap -e "remove lock = Caps_Lock"
xmodmap -e "keysym Caps_Lock = Escape"

# Merge with Xresource for xterm settings --------------------------------------
xrdb -merge .Xresources & 

# Start transperncy program ----------------------------------------------------
xcompmgr -r 3 -o 0.9 -I 0.1 -O 0.1 -D 10 & 

# Run background shuffling script ----------------------------------------------
./scripts/bg.sh &

# Set background again because xcompmgr does funny things when it starts -------
feh --bg-scale images/bgs/crystal.jpg &

# Running window manager -------------------------------------------------------
exec xmonad

# XFCE -------------------------------------------------------
#exec ck-launch-session startxfce4  

