module View exposing (..)

import Model exposing (Model, Tool(..))
import Matrix exposing (toList, rowCount, colCount)
import Color exposing (toRgb, black)
import Color.Convert exposing (colorToHex, hexToColor, colorToCssRgba)
import Update exposing (Msg(..))
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
    , modal "Save" model
    ]

toolbar model =
  aside [class "toolbar"]
    [ tool Paint "paint-brush" model.tool
    , tool Erase "eraser" model.tool
    , tool Pipette "crosshairs" model.tool
    , button [class "show-grid fa fa-th", onClick ToggleGrid] []
    , button [class "save fa fa-floppy-o", onClick ToggleSave] []
    , input [type_ "color", value (model.color |> colorToHex),  class "color", onChangeColor ] []
    ]

tool tool icon current =
  div [class ("tool" ++ activeClass tool current), onClick (SwitchTool tool)]
    [ node "i" [class ("fa fa-" ++ icon)] []]


matrix showGrid rows =
  div [class ("matrix" ++ gridClass showGrid), onMouseDown (MouseDown True), onMouseUp (MouseDown False)]
    (List.indexedMap row rows)

row y cells =
  div [class "row"]
    (List.indexedMap (cell y) cells)

cell y x color =
  div [ class "cell"
     , style [("background-color", colorToCssRgba color)]
     , onMouseEnter (UseTool (y, x))
     , onMouseOut (UseTool (y, x))
     , onMouseDown (UseToolSingle (y, x))
     ]
     [ div [class "overlay"] []]

modal text model =
  div [class ("overlay" ++ activeClass model.showSave True)]
    [div [class "modal"]
      [ button [class "close fa fa-times", onClick ToggleSave] []

      ]
    ]



-- Utils
activeClass item current =
  if item == current then " active" else ""

gridClass show =
  if show then " show-grid" else ""


onChangeColor : Attribute Msg
onChangeColor = onInput ((hexToColor >> Maybe.withDefault black) >> ChangeColor)
