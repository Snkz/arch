--------------------------------------------------------------------------------
-- file:            ~/.xmonads/xmonads.hs                                              
-- author:          Abdi Dahir - I have no website :(                           
-- modified:        December 2011                                               
-- vim: set fenc=utf-8:nu:ai:si:et:ts=4:sw=4:ft=haskell:                      
--                                                                             
-- Shity haskel config file
-- Most of these settings were "Inspired" by online resources, mostly arch wiki
-- Knowing haskell in no way helps with this. Well maybe reading it but
-- god so much setting specific attributes and commands! 
--
-- TODO: Pump aptana to code workspace
-- TODO: Pump minecraft to games workspace
-- TODO: Create a second status bar
-- TODO: Replace XXX: with bitmaps found online
-- TODO: Main "startmenu" link Arch icon should be clickable and list avalible commands 
-- 
--------------------------------------------------------------------------------

import XMonad 

import XMonad.Config.Desktop

import XMonad.Actions.CycleWS
import XMonad.Actions.MouseGestures
import XMonad.Actions.MouseResize
import XMonad.Actions.GridSelect

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.FadeInactive
import XMonad.ManageHook

import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.Font

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Man

import XMonad.Layout.WindowArranger 
import XMonad.Layout.NoBorders 
import XMonad.Layout.Spacing
import XMonad.Layout.Named
import XMonad.Layout.Spiral
import XMonad.Layout.Accordion 
import XMonad.Layout.Mosaic 
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Tabbed 

import qualified Data.Map as M
import qualified XMonad.StackSet as W

main = do 
  -- spawn first dzen bar, displays default dzen stuff
	statusbar <- spawnPipe (workbar)
	spawn (conkybar)
	spawn (scroller)
	spawn (secondstatus)
	--spawn ("./scripts/menu.sh")
	--spawn (bbar)
	
    -- override the following xmonad settings and run. Use the specified urgency hook.
    -- layoutHook    = avoidStruts $ myLayout 
    -- layoutHook    =  smartBorders $ avoidStruts $ layoutHook defaultConfig 
    -- $ myUrgencyHook  
	xmonad $ withUrgencyHook NoUrgencyHook desktopConfig
		{ borderWidth       = 3 
    , handleEventHook   = docksEventHook <+> handleEventHook desktopConfig 
    , layoutHook        = avoidStruts $ mouseResize $ windowArrange myLayout
		, workspaces        = ["main", "web", "code", "ssh"] ++ map show [5..7] ++ ["mcabber", "irc"]
		, startupHook       = setWMName "LG3D" <+> docksStartupHook
		, manageHook        = manageDocks <+> myManageHook <+> manageHook desktopConfig
						  -- Did not fix mtpaint <+> (fmap not isDialog --> doF avoidMaster)
						  -- Did not fix mtpaint <+> (isDialog --> doF W.shiftMaster <+> doF W.swapDown)
		, logHook           = (dynamicLogWithPP $ myPPsettings statusbar) >> (fadeLogHook)
		} `additionalKeysP` myKeys


-- Format: [... ("key bind", functionality) ...]
myKeys = [
	-- Launch programs
	  ("M-f", spawn "firefox")
	, ("M-p", shellPrompt myXPConfig) 
	, ("M-m", spawn "./scripts/minecraft.sh")
	, ("M-c", spawn "chromium")
	, ("M-S-c", spawn "conky")
	, ("M-S-i", spawn "xterm -title irssi -name irssi -e irssi")
	, ("M-i", spawn "irssi")
    -- Fontsize control
	--, ("M-S-8", spawn "xtermcontrol --font terminus:pixelsize=18")
	-- Close focused program
	, ("M-S-k", kill)
	-- Screenies
	, ("<Print>", spawn "scrot -q 100 -e 'mv $f ~/images/screenshot'")
	-- Return to tilespace
	, ("M-S-t", withFocused $ windows . W.sink)
	-- Lock Screen
	, ("M-S-l", spawn "slock")
	-- Restart xmonad
	, ("M-q", spawn "killall conky; killall xargs; killall dzen2; xmonad --recompile; xmonad --restart")
	-- Kill X
	, ("M-S-q", spawn "killall conky; killall xargs; killall dzen2; killall xinit;")
	-- Audio Control 
	, ("<XF86AudioLowerVolume>", spawn "amixer -q set Master 3%- unmute")
	, ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 3%+ unmute")
	, ("<XF86AudioMute>", spawn "amixer -q set Master toggle")
    -- Brightness
	, ("M-S-<Up>", spawn "xbacklight -inc 5")
	, ("M-S-<Down>", spawn "xbacklight -dec 5")
	-- Workspace control
	, ("M-<Left>",   prevWS)
	, ("M-<Right>",  nextWS)
	, ("M-z",    toggleWS)
	, ("M-b",    sendMessage ToggleStruts)
	, ("M-S-<Left>",   shiftToPrev)
	, ("M-S-<Right>",  shiftToNext)
	, ("M-S-z",    moveTo Next EmptyWS)
    -- Grid Controls
	, ("M-g", goToSelected def)
	]

-- The regular status bar
workbar = "dzen2 -dock -fn '" ++ terminus ++ "' -xs 1 -bg black -fg white -ta l -w 1000 -h 24"

-- Icons, not in use
arch    = "^bg()^fg(blue)^i(confs/xbm8x8/arch_10x10.xbm)"
firefox = "^bg(black)^fg(red)^p(+10)^i(confs/xbm8x8/fox.xbm) Fire ^p(+62)"
info    = "^bg(black)^fg(yellow)^p(+10)^i(confs/xbm8x8/info_01.xbm) Info ^p(+62)"
power   = "^bg(black)^fg(white)^p(+10)^i(confs/xbm8x8/half.xbm) Power ^p(+62)"

-- Conky stats
conkybar = "conky -c './scripts/conky_statsrc' | dzen2 -dock -xs 1 -p -fn '" ++ terminus ++ "' -bg black -fg white -ta r -x 1000 -w 1880 -h 24"
-- Useless Welcome thingy
scroller = "echo \"^fg(white)Welcome to ^fg(lightblue)Skyloft^fg()\" | dzen2 -dock -xs 1 -p -fn '" ++ terminus ++ "' -bg black -x 80 -y $((`xrandr --current | grep '*' | awk 'NR==1{print $1}' | cut -d 'x' -f2` - 24)) -ta r -w 970 -h 24 & transset .9";
-- Bottom status stuff
secondstatus = "conky -c './scripts/conky_weather' | dzen2 -dock -xs 1 -fn '" ++ terminus ++ "' -bg black -fg white -x 1050 -y $((`xrandr --current | grep '*' | awk 'NR==1{print $1}' | cut -d 'x' -f2` - 24)) -ta r -w 1870 -h 24"


-- How dzen bar will appear 
myPPsettings bar = def
				{ ppCurrent            = dzenColor "#FFFFFF" "#000000" . wrap ">" ""
				, ppOutput             = hPutStrLn bar
				, ppVisible            = dzenColor "#000000" "#FFFFFF" . wrap "^i(confs/xbm8x8/full,xbm)" ""
				, ppHidden             = dzenColor "#FFFFFF" ""  . wrap "^i(confs/xbm8x8/full,xbm)" ""
				, ppHiddenNoWindows    = dzenColor "#4A4459" ""  . wrap "^i(confs/xbm8x8/empty,xbm)" ""
				, ppSep                = " ^fg(grey60) = ^fg() "
				, ppWsSep              = " "
				, ppUrgent             = dzenColor "yellow" "black" . dzenStrip
				--, ppTitle              = dzenColor "#FFFFFF" "" . wrap ":: " " ::"
				, ppTitle              = dzenColor "#FFFFFF" "" 
				, ppLayout             = dzenColor "#FFFFF" "" . (\mode -> case mode of
																		"Tiled" -> "|[]"
																		"Mirror Tiled" -> "[_]"
																		"Full" -> "[-]"
																		"Tab" -> "[=]"
																		"Spiral" -> "[@]"
																		"Accordion" -> "[#]"
																		"Mosaic" -> "[+]"
																		_ -> "[?]" )
				}


-- Layout hook of awesome, found on xmonad wiki mostly with a few tweaks 
myLayout = avoidStruts (full ||| tiled ||| Mirror tiled ||| spiraly)
--myLayout = Full ||| mos ||| acc ||| tiled ||| tabs ||| Mirror tiled ||| spiraly
    where 
        -- default lol
        nmaster = 1
        -- lol props golden bro
        ratio = (2 / (1 + (toRational(sqrt(5)::Double))))
        -- percent of screen to increment and shit
        delta = 5/100
        -- something about partitioning 
        tiled = named "Tiled" $ spacing 4 $ Tall nmaster delta ratio
        -- the coolest one ever
        spiraly = named "Spiral" $ spacing 1 $ avoidStrutsOn [U] (spiral (6/7))
        -- TABS BRAH 
        tabs = named "Tab" $ simpleTabbed
        -- Accordian BRO
        acc = named "Accordion" $ Mirror Accordion
        -- MOSI B
        mos = named "Mosaic" $ mosaic 3 [4,1] 
        -- regular old full
        full = smartBorders $ Full

-- Fading bro, found online
fadeLogHook = fadeInactiveLogHook 0.9

-- layout for specified programs.
myManageHook = composeAll 
            [ className =? "mtpaint" --> doFloat 
            , isFullscreen --> (doF W.focusDown <+> doFullFloat)
            , className =? "info" --> doFloat
            , appName =? "irssi" --> doShift "irc"
            , appName =? "mcabber" --> doShift "mcabber"
			]

-- what xmonad will do when a window calls for my attention
-- myUrgencyHook = withUrgencyHook dzenUrgencyHook 
--				{ args = [ "-fn", "smoothansi-10"
--						 , "-bg", "yellow"] 
--				} 
				 
-- oh pretty terminus 
-- terminus = "-*-terminus-*-*-*-*-16-*-*-*-*-*-iso8859-*"
terminus = "xos4 Terminus:pixelsize=16"

-- New windows will never be put on the master window! 
-- I swear this is how the param'd it, I can't rename things I dont know!!
-- It also doesn't work as intended! 
avoidMaster = W.modify' $ (\c -> case c of 
						   W.Stack t [] (r:rs) -> W.Stack t [r] rs
						   otherwise 		   -> c)

-- Settings for the terminal thinng below , shows all avalible shell commands
myXPConfig = def
	{ position = Bottom
	, promptBorderWidth = 0 
	--, borderColor = "grey"
	, height = 24  
	, bgColor = "black"
	, fgColor = "gray"
	, fgHLight = "white"
	, bgHLight = "black"
	}
