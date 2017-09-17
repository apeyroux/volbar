module Main where

import Data.Monoid
import System.Environment
import Sound.ALSA.Mixer

volbar :: Int -> [Char]
volbar x | x == 0 = "<fc=#6272a4>" ++ (take 10 $ (take x $ repeat '#')) ++ "</fc>" ++ (take (10-x) $ repeat ':')
           | x <= 3 = "<fc=#50fa7b>" ++ (take 10 $ (take x $ repeat '#')) ++ "</fc>" ++ (take (10-x) $ repeat ':')
           | x >= 3 && x <= 7 = "<fc=#ffb86c>" ++ (take 10 $ (take x $ repeat '#')) ++ "</fc>" ++ (take (10-x) $ repeat ':')
           | x >= 7 = "<fc=#ff5555>" ++ (take 10 $ (take x $ repeat '#')) ++ "</fc>" ++ (take (10-x) $ repeat ':')

vol :: IO Integer
vol = withMixer "default" $ \mixer ->
  do Just control <- getControlByName mixer "Master"
     let Just playbackVolume = playback $ volume control
     (min, max) <- getRange playbackVolume
     Just v <- getChannel FrontLeft $ value $ playbackVolume
     return $ div (div (v * 100) max) 10

main :: IO ()
main = do
  vol >>= bare >>= putStr
  where
    bare = return . volbar . fromIntegral
