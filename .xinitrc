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

# Merge with Xresource for xterm settings --------------------------------------
xrdb -merge .Xresources & 

# Start transperncy program ----------------------------------------------------
xcompmgr & 

# Run background shuffling script ----------------------------------------------
./scripts/bg.sh &

# Set background again because xcompmgr does funny things when it starts -------
feh --bg-scale images/bgs/crystal.jpg &

# Running window manager -------------------------------------------------------
exec ck-launch-session xmonad  

# XFCE -------------------------------------------------------
#exec ck-launch-session startxfce4  

