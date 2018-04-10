import XMonad

import XMonad.Config.Xfce
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog

main = do
  xmproc <- spawnPipe "xmobar >~/xmobar.out 2>~/xmobar.err"
  xmonad $ xfceConfig
    { startupHook = startupHook xfceConfig >> setWMName "LG3D"
    , logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc
      , ppTitle = xmobarColor "green" "" . shorten 50
      }
    , terminal = "xfce4-terminal"
    , modMask = mod4Mask
    , borderWidth = 3
    }
    `additionalKeysP`
    [ ("M-o", safeSpawnProg "google-chrome")
    , ("M-r", spawn $ "dmenu_run" )
    , ("M-<Return>", spawn $ "xfce4-terminal --execute tmux")
    ]

