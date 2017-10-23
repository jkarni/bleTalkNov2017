{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -fno-warn-type-defaults #-}
module Lib.Synths where

import Data.IORef   (IORef, readIORef)
import GHC.TypeLits (KnownSymbol)
import Vivid

-- | In this module, we define the synths/instruments that will be available.
-- Each instrument has one or more arguments - these can be the note, or
-- duration, or something more complex.

wobble :: SynthDef '["note"]
wobble = sd (0 :: I "note") $ do
   s <- 50 ~* sinOsc (freq_ 10) ? KR
   s1 <- 0.1 ~* sinOsc (freq_ $ midiCPS (V::V "note") ~+ s)
   out 0 [s1, s1]

-- | Run a single-argument synth.
runSynth :: forall arg1. (KnownSymbol arg1)
  => Synth '[arg1] -> IORef [Float] -> IO ()
runSynth theSynth argRef = do
  args <- take 12 <$> readIORef argRef
  forM_ args $ \arg -> wait (1/4) >> set theSynth (toI arg :: I arg1)
  runSynth theSynth argRef
