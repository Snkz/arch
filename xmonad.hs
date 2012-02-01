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

import XMonad.Actions.CycleWS

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.SetWMName
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.ManageHelpers
import XMonad.ManageHook

import XMonad.Util.Loggers
import XMonad.Util.Run
import XMonad.Util.EZConfig
import XMonad.Util.Font

import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Prompt.Man

import XMonad.Layout.NoBorders 

import qualified Data.Map as M
import qualified XMonad.StackSet as W

main = do 
	-- spawn first dzen bar, displays default dzen stuff
	statusbar <- spawnPipe (workbar)
	spawn (conkybar)
	spawn (extrabar)
	-- override the following xmonad settings and run. Use the specified urgency hook.
	xmonad $ myUrgencyHook  $ defaultConfig 
		{ borderWidth   = 3 
		, workspaces    = ["main", "web", "code", "ssh", "game"] ++ map show [6..9]
		, startupHook   = setWMName "LG3D"
		, layoutHook    = smartBorders $ avoidStruts $ layoutHook defaultConfig
		, manageHook    = manageDocks <+> myManageHook <+> manageHook defaultConfig 
						  -- Did not fix mtpaint <+> (fmap not isDialog --> doF avoidMaster)
						  -- Did not fix mtpaint <+> (isDialog --> doF W.shiftMaster <+> doF W.swapDown)
		, logHook       = dynamicLogWithPP $ myPPsettings statusbar
		} `additionalKeysP` myKeys
		

-- Format: [... ("key bind", functionality) ...]
myKeys = [
	-- Launch programs
	  ("M-f", spawn "firefox")
	, ("M-p", shellPrompt myXPConfig) 
	, ("M-m", spawn "./scripts/minecraft.sh")
	, ("M-c", spawn "conky")
	-- Close focused program
	, ("M-S-k", kill)
	-- Screenies
	, ("<Print>", spawn "scrot -q 100 -e 'mv $f ~/images/screenshot'")
	-- Return to tilespace
	, ("M-S-t", withFocused $ windows . W.sink)
	-- Restart xmonad
	, ("M-q", spawn "killall conky; xmonad --recompile; xmonad --restart")
	-- Audio Control 
	, ("<XF86AudioLowerVolume>", spawn "amixer -q set Master 1- unmute")
	, ("<XF86AudioRaiseVolume>", spawn "amixer -q set Master 1+ unmute")
	, ("<XF86AudioMute>", spawn "amixer -q set Master toggle")
	-- Workspace control
	, ("M-<Left>",   prevWS)
	, ("M-<Right>",  nextWS)
	, ("M-z",    toggleWS)
	, ("M-S-<Left>",   shiftToPrev)
	, ("M-S-<Right>",  shiftToNext)
	, ("M-S-z",    moveTo Next EmptyWS)
	]

-- The regular status bar
workbar = "dzen2  -fn '" ++ terminus ++ "' -bg black -fg white -ta l -w 700 -h 20"

-- Conky stats
conkybar = "conky -c './scripts/conky_statsrc' | dzen2  -fn '" ++ terminus ++ "' -bg black -fg white -ta r -x 700 -w 570 -h 20"
extrabar = "conky -c './scripts/conky_namescrollrc' | dzen2  -fn '" ++ terminus ++ "' -bg black -fg white -ta r -x 1270 -w 96 -h 20"

-- How dzen bar will appear 
myPPsettings bar = defaultPP
				{ ppCurrent            = dzenColor "#FFFFFF" "#000000" . wrap ">" ""
				, ppOutput             = hPutStrLn bar
				, ppVisible            = dzenColor "#000000" "#FFFFFF"
				, ppHidden             = dzenColor "#FFFFFF" ""
				, ppHiddenNoWindows    = dzenColor "#4A4459" ""
				, ppSep                = " ^fg(grey60) = ^fg() "
				, ppWsSep              = " "
				, ppUrgent             = dzenColor "yellow" "red" . dzenStrip
				--, ppTitle              = dzenColor "#FFFFFF" "" . wrap ":: " " ::"
				, ppTitle              = dzenColor "#FFFFFF" "" 
				, ppLayout             = dzenColor "#FFFFF" "" . (\mode -> case mode of
																		"Tall" -> "|[]"
																		"Mirror Tall" -> "[_]"
																		"Full" -> "[-]")
				}

-- layout for specified programs.
myManageHook = composeAll [ 
			   (className =? "mtpaint" --> doFloat) 
			 , (isFullscreen --> (doF W.focusDown <+> doFullFloat)) 
			 ]

-- what xmonad will do when a window calls for my attention
myUrgencyHook = withUrgencyHook dzenUrgencyHook 
				{ args = [ "-fn", "smoothansi-10"
						 , "-bg", "yellow"] 
				} 
				 
-- oh pretty terminus 
terminus = "-*-terminus-*-*-*-*-12-*-*-*-*-*-iso8859-*"

-- New windows will never be put on the master window! 
-- I swear this is how the param'd it, I can't rename things I dont know!!
-- It also doesn't work as intended! 
avoidMaster = W.modify' $ (\c -> case c of 
						   W.Stack t [] (r:rs) -> W.Stack t [r] rs
						   otherwise 		   -> c)

-- Settings for the terminal thinng below , shows all avalible shell commands
myXPConfig = defaultXPConfig 
	{ position = Bottom
	, promptBorderWidth = 0 
	--, borderColor = "grey"
	, height = 20  
	, bgColor = "black"
	, fgColor = "gray"
	, fgHLight = "white"
	, bgHLight = "black"
	}