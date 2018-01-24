import XMonad

import XMonad.Config.Xfce
import XMonad.Hooks.SetWMName
import XMonad.Util.EZConfig
import XMonad.Util.Run

main = do
  xmonad $ xfceConfig
    { startupHook = startupHook xfceConfig >> setWMName "LG3D"
    , terminal = "xfce4-terminal"
    , modMask = mod4Mask
    }
    `additionalKeysP`
    [ ("M-o", safeSpawnProg "google-chrome")
    , ("M-r", spawn $ "dmenu_run" )
    ]

