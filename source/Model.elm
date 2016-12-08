module Model exposing (..)

import Color exposing (Color, rgba, black, white)
import Matrix exposing (Matrix, matrix)


initModel : Model
initModel =
  { tool = Paint
  , zoom = 1
  , matrix = initMatrix
  , color = black
  , mousedown = False
  , showGrid = True
  , showSave = False
  }


transparent =
  (rgba 0 0 0 0)

initMatrix =
  matrix 10 10 (always white)

type Tool
  = Paint
  | Erase
  | Pipette

type alias Model =
  { tool : Tool
  , zoom : Int
  , matrix : Matrix Color
  , color : Color
  , mousedown : Bool
  , showGrid : Bool
  , showSave : Bool
  }
