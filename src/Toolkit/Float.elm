module Toolkit.Float exposing (roundTo)

{-|
@docs roundTo
-}

-- ROUNDING NUMBERS

{-| Round a `Float` to a given number of decimal places

    pi |> roundTo 2      --> 3.14
    pi |> roundTo 0      --> 3
    1234 |> roundTo -2   --> 1200
    
-}
roundTo : Int -> Float -> Float
roundTo place number =
  let
    multiplier =
      place
        |> (^) 10
        |> toFloat

  in
    number
      |> (*) multiplier
      |> round
      |> toFloat
      |> flip (/) multiplier
