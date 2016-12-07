module View exposing (..)

import Model exposing (Model, Tool(..))
import Matrix exposing (toList, map)
import Color exposing (toRgb)
import Update exposing (Msg(..))
import Utils exposing (hexToColor)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

view : Model -> Html Msg
view model =
  div [class "container"]
    [ node "link" [href "../styles/style.css", rel "stylesheet"] []
    , node "link" [href "../styles/font-awesome.css", rel "stylesheet"] []
    , toolbar model
    , matrix model.showGrid (model.matrix |> toList)
    ]

toolbar model =
  aside [class "toolbar"]
    [ tool Paint "paint-brush" model.tool
    , tool Erase "eraser" model.tool
    , button [class "show-grid fa fa-th", onClick ToggleGrid] []
    , input [type_ "color", class "color", onChangeColor ] []
    ]

tool tool icon current =
  div [class ("tool" ++ activeClass tool current), onClick (SwitchTool tool)]
    [ node "i" [class ("fa fa-" ++ icon)] []]


matrix showGrid rows =
  table [class ("matrix " ++ gridClass showGrid), onMouseDown (MouseDown True), onMouseUp (MouseDown False)]
    (List.indexedMap row rows)

row y cells =
  tr []
    (List.indexedMap (cell y) cells)

cell y x color =
  td [ class "pixel"
     , style [("background-color", color |> toRgb |> toCSS)]
     , onMouseEnter (UseTool (y, x))
     , onMouseOut (UseTool (y, x))
     , onMouseDown (UseToolSingle (y, x))
     ]
     [ div [class "overlay"] []]


-- Utils
toCSS color =
  let r = color.red |> toString
      g = color.green |> toString
      b = color.blue |> toString
      a = color.alpha |> toString
  in "rgba(" ++ r ++ "," ++ g ++ "," ++ b ++ "," ++ a ++ ")"

gridClass showGrid =
  if showGrid then "grid" else ""


activeClass item current =
  if item == current then " active" else ""


onChangeColor : Attribute Msg
onChangeColor = onInput (hexToColor >> ChangeColor)
