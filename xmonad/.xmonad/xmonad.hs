import XMonad

main = xmonad def
      {  terminal    = myTerminal
      ,  modMask     = myModMask
      ,  borderWidth = myBorderWidth
      }
myTerminal    = "xfce4-terminal"
myModMask     = mod4Mask -- Win key or Super_L
myBorderWidth = 3

-- main = do
--     xmonad $ defaultConfig
--       {  terminal    = myTerminal
--       ,  modMask     = myModMask
--       ,  borderWidth = myBorderWidth
--       }
-- 
