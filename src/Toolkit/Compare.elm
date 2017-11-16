module Toolkit.Compare exposing (isInRange, isBetween)

{-|
@docs isInRange, isBetween
-}


{-| Given a pair of values defining an interval and a test value, returns `True`
if the test value falls within the interval, *including* its endpoints
-}
isInRange : (comparable, comparable) -> comparable -> Bool
isInRange (min, max) value =
  value >= min && value <= max


{-| Given a pair of values defining an interval and a test value, returns `True`
if the test value falls strictly *between* the endpoints of the interval, such
that a test value equal to one of the endpoints will return `False`
-}
isBetween : (comparable, comparable) -> comparable -> Bool
isBetween (min, max) value =
  value > min && value < max
