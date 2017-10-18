{-# LANGUAGE DataKinds #-}
{-# LANGUAGE OverloadedStrings #-}
module Lib.Application where

import Bluetooth
import Data.IORef (IORef, readIORef, writeIORef)
import Vivid

app :: IORef [Float] -> Application
app wobbleBarRef = "/com/turingjump/demo"
  & services .~ [wobbleService wobbleBarRef]

wobbleService :: IORef [Float] -> Service 'Local
wobbleService wobbleBarRef = "3ca32424-dcb8-4044-918e-a4a544001e92"
  & characteristics .~ [wobbleNote wobbleBarRef]

wobbleNote :: IORef [Float] -> CharacteristicBS 'Local
wobbleNote wobbleBarRef = "f9b8798d-0366-4981-9c21-714dda49d437"
  & properties .~ [CPWrite, CPRead]
  & readValue ?~ encodeRead (liftIO $ readIORef wobbleBarRef)
  & writeValue ?~ encodeWrite (\x -> liftIO $ writeIORef wobbleBarRef x >> return True)
