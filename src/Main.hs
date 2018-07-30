module Main where

import Data.Monoid
import System.Environment
import Sound.ALSA.Mixer

volbar :: Int -> String
volbar x | x == 0 = "<fc=#6272a4>" ++ take 10 (replicate x '#') ++ "</fc>" ++ take (10-x) $ repeat ':'
         | x <= 3 = "<fc=#50fa7b>" ++ take 10 (replicate x '#') ++ "</fc>" ++ take (10-x) $ repeat ':'
         | x >= 3 && x <= 7 = "<fc=#ffb86c>" ++ take 10 $ replicate x '#' ++ "</fc>" ++ take (10-x) $ repeat ':'
         | x >= 7 = "<fc=#ff5555>" ++ take 10 $ replicate x '#' ++ "</fc>" ++ take (10-x) $ repeat ':'

vol :: IO Integer
vol = withMixer "default" $ \mixer ->
  do Just control <- getControlByName mixer "Master"
     let Just playbackVolume = playback $ volume control
     let Just playbackSwitch = playback $ switch control
     Just sw <- getChannel FrontLeft playbackSwitch
     Just v <- getChannel FrontLeft $ value playbackVolume
     (min, max) <- getRange playbackVolume
     return $ div (div (isMuted sw v * 100) max) 10
     where
       isMuted sw v | not sw = 0
                    | sw = v
                    | otherwise = v

main :: IO ()
main = vol >>= bare >>= putStr
  where
    bare = return . volbar . fromIntegral
