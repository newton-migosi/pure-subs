module App.Video (component, Output(..)) where

-- import Control.Monad (class Bind)

import DOM.HTML.Indexed.InputAcceptType (InputAcceptType, InputAcceptTypeAtom(..))
import Data.Foldable (traverse_)
import Data.Maybe (Maybe(..))
import Data.MediaType (MediaType(..))
import Data.Traversable (for_)
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Prelude (Unit, bind, const, discard, pure, unit, ($), (=<<), (>>=), (<<<))
import Web.Event.Event as Event

import Web.File.File as File
import Web.File.FileList as FileList
import Web.File.FileReader.Aff as FileReaderAff
import Web.HTML.HTMLInputElement as InputElement

data Action = HandleFileUpload Event.Event | Receive Input

type Input = Unit

data Output = VideoLoaded

-- type Slot q = H.Slot q Message

type State =
  { videoUrl :: Maybe String }

component :: forall q m. MonadAff m => H.Component q Input Output m
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval 
        { handleAction = handleAction 
        , receive = Just <<< Receive
        }
    }

initialState :: Input -> State
initialState inp =
  { videoUrl : Nothing
  }

render :: forall m slots. State -> H.ComponentHTML Action slots m
render state =
    case state.videoUrl of
        Nothing -> blank_player
        Just url -> video_player url

supported_formats :: InputAcceptType
supported_formats = 
    HP.InputAcceptType
        [ AcceptMediaType (MediaType "video/mp4")
        , AcceptMediaType (MediaType "video/webm")
        ]

blank_player :: forall w. HH.HTML w Action
blank_player = 
    HH.div_ 
        [ HH.span_ [HH.text "Choose file to upload"]
        , HH.input
            [ HP.type_ HP.InputFile
            , HP.accept supported_formats
            , HE.onChange HandleFileUpload
            ]
    ]

video_player :: forall w i. String -> HH.HTML w i
video_player url = 
    HH.div_ [
        HH.video [HP.src url] []
    ]

handleAction :: forall m slots. MonadAff m => Action -> H.HalogenM State Action slots Output m Unit 
handleAction = case _ of
  Receive rcvd -> pure unit

  HandleFileUpload ev → do
    traverse_ handleFileUpload (InputElement.fromEventTarget =<< Event.target ev)
    H.raise VideoLoaded

handleFileUpload :: forall m slots o. MonadAff m => InputElement.HTMLInputElement -> H.HalogenM State Action slots o m Unit 
handleFileUpload inputEl = do
  H.liftEffect (InputElement.files inputEl) >>= traverse_ \files ->
    for_ (FileList.item 0 files) \file → do
      video_url ← H.liftAff $ FileReaderAff.readAsDataURL (File.toBlob file)
      H.modify_ (const { videoUrl : Just video_url})
      pure unit