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
alias homewifi="sudo netctl start wlp1s0-METABEE"
alias dhomewifi="sudo netctl stop wlp1s0-METABEE"
alias workwifi="sudo netctl start wlp1s0-TheEngineRoom"
alias dworkwifi="sudo netctl stop wlp1s0-TheEngineRoom"
#alias uoftwifi="sudo netctl start UofT"
#alias duoftwifi="sudo netctl stop UofT"
#alias cslab="ssh g1snkz-cdf@wifi.cs.toronto.edu"
#alias negarwifi="sudo netctl start Negar"
#alias dnegarwifi="sudo netctl stop Negar"
alias kevinwifi="sudo netctl start wlp1s0-Ramo"
alias dkevinwifi="sudo netctl stop wlp1s0-Ramo"
alias eth="sudo dhcpcd enp0s20u2u1c2"

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
alias scan="sudo iwlist wlp1s0 scan"
alias wifiup="sudo ip link set wlp1s0 up"
alias fm="pcmanfm"
alias unmount="sudo umount"
alias mount="sudo mount"
alias sshcdf="ssh g1snkz@cdf.toronto.edu"
alias sshcluster="ssh -i ~/.ssh/uskyloft adahir@fs.csl.utoronto.ca"
alias sshrserver="ssh -f -N -L 8787:c159:8787 -i ~/.ssh/uskyloft adahir@fs.csl.utoronto.ca"
alias sshstarscream="ssh -X invader@starscream.modilabs.org"
alias sshmegatron="ssh -X invader@megatron.modilabs.org"
alias scpcdf="scp g1snkz@cdf.toronto.edu:$1 $2"
alias scpcluster="scp -i ~/.ssh/uskyloft adahir@fs.csl.utoronto.ca:$1 $2"
alias extendmon="xrandr --output DP2 --auto --left-of  eDP1" 
#alias extendmon="xrandr --output HDMI1 --auto --above eDP1" 

# Pretty key -------------------------------------------------------------------
alias arch="python3 /usr/bin/archey3" 

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
export PATH=$HOME/.cabal/bin:$PATH
export PATH=/home/snkz/.gem/ruby/2.2.0/bin:$PATH
export ANDROID_HOME=/opt/android-sdk
source /usr/share/nvm/init-nvm.sh

# Atlas
PATH=${PATH}:/home/snkz/git/universe/emscripten/emsdk_portable:/home/snkz/git/universe/emscripten/emsdk_portable/clang/fastcomp/build_master_64/bin:/home/snkz/git/universe/emscripten/emsdk_portable/node/0.10.18_64bit/bin:/home/snkz/git/universe/emscripten/emsdk_portable/emscripten/master


export CXX=~/git/universe/toolchain/clang+llvm-3.6.0/bin/clang++
