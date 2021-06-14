module App.Styles where

import CSS

import CSS.Common (auto)
import CSS.Overflow (hidden, overflow)
import CSS.TextAlign (leftTextAlign, textAlign)
import Prelude (Unit, discard, pure, unit, ($))

header :: StyleM Unit
header = do
    position absolute
    fontSize $ px 20.0
    backgroundColor $ fromInt 0xbe0f34
    height $ vh 15.0
    width $ vw 99.9
    clear clearBoth
    float floatLeft
    textAlign leftTextAlign
    paddingLeft $ vw 10.0 

video_container :: StyleM Unit
video_container = do
    position absolute
    float floatLeft
    top $ vh 20.0
    left $ vw 5.0
    width $ vw 60.0
    height $ vh 70.0
    backgroundColor $ fromInt 0xdce5f4

captions_container :: StyleM Unit
captions_container = do
    position absolute
    float floatLeft
    top $ vh 20.0
    left $ vw 70.0
    width $ vw 30.0

video :: StyleM Unit
video = do
    position absolute
    right $ pt 0.0
    bottom $ pt 0.0
    top $ pt 0.0
    minWidth $ pct 100.0
    minHeight $ pct 100.0
    maxHeight $ pct 100.0
    maxWidth $ pct 100.0
    width auto
    height auto
    zIndex $ 2
    backgroundSize cover
    overflow hidden

caption :: StyleM Unit
caption = do
    position absolute
    maxWidth $ pct 100.0
    minWidth $ pct 80.0
    height auto
    borderRadius (px 2.0) (px 2.0) (px 2.0) (px 2.0)
    border solid (px 2.0) (rgb 233 9 78)
    backgroundColor $ fromInt 0xe5e5e5

component_container :: StyleM Unit
component_container = pure unit

blank_player :: StyleM Unit
blank_player = do
    paddingLeft $ pct 20.0
    paddingTop $ pct 15.0
