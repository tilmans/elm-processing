module Main exposing (draw, main, setup)

import Canvas exposing (..)
import CanvasColor exposing (..)
import Processing.Processing exposing (..)


setup =
    []


draw state =
    fillStyle (rgba 0 0 0 1)
        >> fillRect 0 0 100 50


main =
    processing setup draw
