import XMonad

import XMonad.Config.Xfce
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import System.Exit

main = do
  xmproc <- spawnPipe "xmobar >~/xmobar.out 2>~/xmobar.err"
  xmonad $ xfceConfig
    { startupHook = startupHook xfceConfig >> setWMName "LG3D"
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "green" "" . shorten 50
      }
    , terminal = "urxvt"
    , modMask = mod4Mask
    , borderWidth = 3
    }
    -- unbind the silly defaults
    -- these mouse unbinds don't seem to work
    `removeMouseBindings`
    [ (mod1Mask, button1)
    , (mod1Mask, button2)
    , (mod1Mask, button3)
    ]
    `removeKeysP`
    [ "M-q"
    , "M-S-q"
    , "M-p"
    , "M-S-p"
    , "M-h"
    , "M-l"
    , "M-,"
    , "M-."
    , "M-n"
    , "M-<Tab>"
    , "M-S-<Space>"
    ]
    `additionalKeysP`
    [ ("M-o", safeSpawnProg "google-chrome")
    , ("M-d", spawn $ "dmenu_run" )
    , ("M-<Return>", spawn $ "urxvt -e dvtm")
    , ("M-<Backspace>", spawn "xmonad --recompile; xmonad --restart")
    ]

