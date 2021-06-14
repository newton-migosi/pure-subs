module App.Captions (component) where

import Prelude

import App.Styles as Styles
import App.Video as Video
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.CSS as CSS
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Type.Proxy (Proxy(..))
import Web.HTML.Common (AttrName(..))
import Web.UIEvent.KeyboardEvent as Ev


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
  { captions :: Array String, video_selected :: Boolean }

component :: forall q i o m. MonadAff m => H.Component q i o m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
    }

initialState :: forall i. i -> State
initialState _ =
  { captions: ["First caption"]
  , video_selected: false
  }

render :: forall m. MonadAff m => State -> H.ComponentHTML Action Slots m
render state =
  HH.div
    [ CSS.style Styles.component_container]
    [ HH.div 
        [ CSS.style Styles.header ]
        [ HH.h1_ [HH.text "Pure Subs"] ] 
    , HH.div
        [ CSS.style Styles.video_container ] 
        [ HH.slot _video_player unit Video.component unit HandleVideo ]
    , HH.div
        [ CSS.style Styles.captions_container ]
        [ if state.video_selected 
          then HH.div_ (map caption state.captions) 
          else HH.span_ [ HH.text "" ]
        ]
    ]

caption :: forall m. MonadAff m => String -> H.ComponentHTML Action Slots m
caption txt = 
  HH.div 
    [ HP.attr (AttrName "contenteditable") "true"
    , HE.onKeyUp HandleInput
    , CSS.style Styles.caption
    ] 
    [ HH.text txt ]

handleAction ::forall o m slots. Action -> H.HalogenM State Action slots o m Unit
handleAction = case _ of
  CaptionComplete -> pure unit
  HandleVideo Video.VideoLoaded -> H.modify_ (\s -> s {video_selected = true})
  HandleInput ev -> pure unit