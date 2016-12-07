module Main exposing (..)

import Html exposing (beginnerProgram)
import Model exposing (initModel)
import View exposing (view)
import Update exposing (update)

main = beginnerProgram
  { model  = initModel
  , update = update
  , view = view
  }
