module Update exposing (..)

import Model exposing (Model, Tool(..), transparent)
import Matrix exposing (Location, Matrix)
import Color exposing (Color, white)


type Msg
  = UseTool Location
  | UseToolSingle Location
  | SwitchTool Tool
  | ChangeColor Color
  | MouseDown Bool
  | ToggleGrid

update msg model =
  case msg of
    UseTool location ->
      { model | matrix = updateMatrix location model }
    UseToolSingle location ->
      { model | matrix = updateMatrix location { model | mousedown = True } }
    SwitchTool tool ->
      { model | tool = tool }
    ChangeColor color ->
      { model | color = color }
    MouseDown mousedown ->
      { model | mousedown = mousedown }
    ToggleGrid ->
      { model | showGrid = not model.showGrid }

updateMatrix location model =
  if model.mousedown then
    case model.tool of
      Paint ->
        Matrix.update location (always model.color) model.matrix

      Erase ->
        Matrix.update location (always white) model.matrix
  else model.matrix
