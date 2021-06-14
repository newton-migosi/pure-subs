module App.Styles where

import CSS

import Prelude (discard, ($), Unit)

header :: StyleM Unit
header = do
    position absolute
    fontSize $ px 20.0
    backgroundColor $ rgb 132 244 0
    height $ vh 7.0

video_container :: StyleM Unit
video_container = do
    position absolute
    float floatLeft
    top $ vh 10.0
    left $ vw 5.0
    width $ vw 35.0

captions_container :: StyleM Unit
captions_container = do
    position absolute
    float floatLeft
    top $ vh 10.0
    left $ vw 50.0

caption :: StyleM Unit
caption = do
    position relative
    width $ vw 30.0
    height $ pt 10.0
    borderRadius (px 2.0) (px 2.0) (px 2.0) (px 2.0)
    border solid (px 2.0) (rgb 233 9 78)
