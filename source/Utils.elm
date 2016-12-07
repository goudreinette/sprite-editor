module Utils exposing (..)

import Color exposing (Color)
import Char

hexToColor : String -> Color
hexToColor rgb =
  case (String.split "" rgb) of
    _ :: r1 :: r2 :: g1 :: g2 :: b1 :: b2 :: [] ->
      let
        r = (toNumber r1) * 16 + toNumber r2
        g = (toNumber g1) * 16 + toNumber g2
        b = (toNumber b1) * 16 + toNumber b2
      in
        Color.rgb r g b
    _ ->
      Color.red


toLowerChar : String -> Char
toLowerChar str =
  case String.uncons str of
    Just (result, _) ->
      Char.toLower result
    Nothing ->
      '0'


charToInt : Char -> Int
charToInt char =
  if Char.isDigit char then
    (Char.toCode char) - zeroCode
  else if Char.isHexDigit char then
    (Char.toCode char) - aCode + 10
  else
    0

toNumber = toLowerChar >> charToInt


aCode = (Char.toCode 'a')


zeroCode = (Char.toCode '0')
