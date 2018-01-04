module Toolkit.Compare exposing
  ( isInRange, isBetween )

{-|

Helpers for comparing values

# Intervals
@docs isInRange, isBetween

-}


{-| Given an interval and a test value, returns `True` if the test value falls
within the interval, *including* its endpoints

    10
      |> Toolkit.Compare.isInRange (10, 20)

    --> True

-}
isInRange : (comparable, comparable) -> comparable -> Bool
isInRange (min, max) value =
  value >= min && value <= max


{-| Given an interval and a test value, returns `True` if the test value falls
strictly *between* the endpoints of the interval, such that a test value equal
to one of the endpoints will return `False`

    10
      |> Toolkit.Compare.isBetween (10, 20)

    --> False

-}
isBetween : (comparable, comparable) -> comparable -> Bool
isBetween (min, max) value =
  value > min && value < max
