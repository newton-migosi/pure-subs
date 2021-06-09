module Main where

import Prelude

import App.Captions as Captions
import App.Video as Video
import Effect (Effect)
import Halogen.Aff as HA
import Halogen.VDom.Driver (runUI)

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI Video.component unit body
