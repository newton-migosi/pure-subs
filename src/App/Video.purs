module App.Video (component) where

import Data.Maybe (Maybe(..))
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Properties as HP
import Prelude (Unit, pure, unit, ($))

data Action = UploadVideo

type State =
  { videoUrl :: Maybe String }

component :: forall q i o m. H.Component q i o m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
    }

initialState :: forall i. i -> State
initialState _ =
  { videoUrl : Nothing
  }

render :: forall m slots. State -> H.ComponentHTML Action slots m
render state =
    case state.videoUrl of
        Nothing -> blank_player
        Just url -> video_player url

blank_player :: forall w i. HH.HTML w i
blank_player = 
    HH.div_ [
        HH.span_ [HH.text "Choose file to upload"],
        HH.input [HP.type_ HP.InputFile]
    ]

video_player :: forall w i. String -> HH.HTML w i
video_player url = 
    HH.div_ [
        HH.video [HP.src url] []
    ]

handleAction ::forall o m slots. Action -> H.HalogenM State Action slots o m Unit
handleAction = case _ of
  UploadVideo -> pure unit