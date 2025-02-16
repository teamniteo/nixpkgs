module Main exposing (main)

import Browser
import Html exposing (text)

main =
    Browser.sandbox
        { init = ()
        , view = \_ -> text "Hello, foo!"
        , update = \_ model -> model
        }
