module Lib ( run ) where


import Bluetooth
import Data.IORef (newIORef)
import Vivid (synth)

import Lib.Application
import Lib.Synths

run :: IO ()
run = do
  conn <- connect
  wobbleBarRef <- newIORef [1..12]
  wobbleSynth <- synth wobble ()
  registerResult <- runBluetoothM (registerAndAdvertiseApplication $ app wobbleBarRef) conn
  case registerResult of
    Left err -> error $ show err
    Right _registered -> do
      runSynth wobbleSynth wobbleBarRef
