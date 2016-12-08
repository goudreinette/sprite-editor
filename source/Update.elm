module Update exposing (..)

import Model exposing (Model, Tool(..), transparent)
import Matrix exposing (Location, Matrix)
import Color exposing (Color, white, black)


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
      useTool location model
    UseToolSingle location ->
      useTool location { model | mousedown = True }
    SwitchTool tool ->
      { model | tool = tool }
    ChangeColor color ->
      { model | color = color }
    MouseDown mousedown ->
      { model | mousedown = mousedown }
    ToggleGrid ->
      { model | showGrid = not model.showGrid }

useTool location model =
  if not model.mousedown
    then model
    else case model.tool of
      Paint ->
        {model | matrix = Matrix.update location (always model.color) model.matrix}

      Erase ->
        {model | matrix = Matrix.update location (always white) model.matrix}

      Pipette ->
        {model | color = Matrix.get location model.matrix |> Maybe.withDefault black}
