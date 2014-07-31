#-------------------------------------------------------------------------------
# file:            ~/.bashrc                                              
# author:          Abdi Dahir - I have no website :(                           
# modified:        December 2011                                               
# vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:                      
#                                                                             
# I LOVE YOU PROMPT 
# Most of these settings were "Inspired" by online resources, mostly arch wiki 
#-------------------------------------------------------------------------------


# Not sure what this check is all about 
[[ $- != *i* ]] && return

# PROMPT -----------------------------------------------------------------------
PS1="\`if [ \$? = 0 ]; then echo \[\e[32\;1m\]::\[\e[m\]; else echo \[\e[31\;1m\]::\[\e[0m\]; fi\` \[\e[36;2m\][\u@\h \W]\[\e[m\] $ " 

# Coloured output --------------------------------------------------------------
alias grep="grep --color=auto"
alias ls="ls -hF --color=auto"
alias lr="ls -R --color=auto"
alias diff="colordiff"
eval $(dircolors -b)

# Directory movement -----------------------------------------------------------
alias back="cd $OLDPWD; pwd"
alias images="cd ~/images; pwd" 
alias desktop="cd ~/Desktop; pwd" 
alias home="cd ~; pwd"
alias work="cd ~/work; pwd"
alias school="cd ~/school; pwd"
alias scripts="cd ~/scripts; pwd"
alias 469="cd ~/school/csc469; pwd"
alias 418="cd ~/school/csc418; pwd"
alias 458="cd ~/school/csc458; pwd"

# Networks ---------------------------------------------------------------------
alias homewifi="sudo netctl start wlan0-Fiino"
alias dhomewifi="sudo netctl stop wlan0-Fiino"
alias uoftwifi="sudo netctl start UofT"
alias duoftwifi="sudo netctl stop UofT"
#alias cslab="ssh g1snkz-cdf@wifi.cs.toronto.edu"
alias utorwifi="sudo netctl start utor"
alias dutorwifi="sudo netctl stop utor"
alias negarwifi="sudo netctl start Negar"
alias dnegarwifi="sudo netctl stop Negar"
alias kevinwifi="sudo netctl start wlan0-Ramo"
alias dkevinwifi="sudo netctl stop wlan0-Ramo"

# Sudo-ing things --------------------------------------------------------------
# sorry buddy :( alias pacman="sudo pacman-color" 
alias pacman="sudo pacman" 
alias reboot="sudo reboot"
alias svim="sudo vim"
alias scat="sudo cat"
alias update="sudo pacman-color -Syu"
alias shutdown="sudo halt"

# Shortened commands -----------------------------------------------------------
alias xredo="xmonad --recompile && xmonad --restart"
alias hist="history | grep $1"
#alias pdf="apvlv"
alias pdf="evince"
alias hinfo="sudo dmidecode | less"
alias scan="sudo iwlist wlan0 scan"
alias wifiup="sudo ip link set wlan0 up"
alias fm="pcmanfm"
alias unmount="sudo umount"
alias mount="sudo mount"
alias sshcdf="ssh g1snkz@cdf.toronto.edu"
alias sshcluster="ssh -i ~/.ssh/uskyloft adahir@fs.csl.utoronto.ca"
alias sshrserver="ssh -f -N -L 8787:c159:8787 -i ~/.ssh/uskyloft adahir@fs.csl.utoronto.ca"
alias scpcdf="scp g1snkz@cdf.toronto.edu:$1 $2"
alias scpcluster="scp -i ~/.ssh/uskyloft adahir@fs.csl.utoronto.ca:$1 $2"

# Pretty key -------------------------------------------------------------------
alias arch="archey3" 

# Saftey aliases ---------------------------------------------------------------
alias cp="cp -i"
alias mv="mv -i"
alias chmod="chmod --preserve-root"

# Someone said I needed this? fuck is export -----------------------------------
export LESS="-R"
export EDITOR="vim"

# Transparent terminal! requires X to be up and xcompmgr -----------------------
#[ -n "$WINDOWID" ] && transset-df -i $WINDOWID >/dev/null

#1337
#alias dpkg="dpkg -i --ignore--depends=libasound2,libqt4-opengl,libqrcore4,libqtgui4" 
export LD_LIBRARY_PATH=/opt/softkinetic/DepthSenseSDK/lib/
