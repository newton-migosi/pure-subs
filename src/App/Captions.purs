module App.Captions (component) where

import Prelude

import Halogen as H
import Halogen.HTML as HH

data Action = CaptionComplete

type State =
  { captions :: Array String }

component :: forall q i o m. H.Component q i o m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
    }

initialState :: forall i. i -> State
initialState _ =
  { captions: ["First caption", "Second caption", "Third caption"]
  }

render :: forall m slots. State -> H.ComponentHTML Action slots m
render state =
    HH.div_ (map HH.text state.captions)

handleAction ::forall o m slots. Action -> H.HalogenM State Action slots o m Unit
handleAction = case _ of
  CaptionComplete -> pure unit