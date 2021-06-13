module App.Captions (component) where

import Prelude

import App.Video as Video
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Web.UIEvent.KeyboardEvent as Ev
import Halogen.HTML.Properties as HP
import Web.HTML.Common (AttrName(..))
import Data.Maybe (Maybe(..))
import Web.Event.Event as Event
import Type.Proxy (Proxy(..))
import Effect.Aff.Class (class MonadAff)


type Slots = 
  (video_player :: forall query. H.Slot query Video.Output Unit
  )

_video_player :: Proxy "video_player"
_video_player = Proxy

data Action = 
    CaptionComplete 
  | HandleVideo Video.Output 
  | HandleInput Ev.KeyboardEvent

type State =
  { captions :: Array String }

component :: forall q i o m. MonadAff m => H.Component q i o m
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

render :: forall m. MonadAff m => State -> H.ComponentHTML Action Slots m
render state =
  HH.div_
    [ HH.h1_ [HH.text "Add Captions"] 
    , HH.slot _video_player unit Video.component unit HandleVideo 
    , HH.div_ (map caption state.captions)
    ]

caption txt = 
  HH.div 
    [ HP.attr (AttrName "contenteditable") "true"
    , HE.onKeyUp HandleInput
    ] 
    [ HH.text txt
    ]

handleAction ::forall o m slots. Action -> H.HalogenM State Action slots o m Unit
handleAction = case _ of
  CaptionComplete -> pure unit
  HandleVideo Video.VideoLoaded -> pure unit
  HandleInput ev -> pure unit