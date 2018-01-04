module Toolkit.Tuple4 exposing
  ( first, second, third, fourth, map )

{-|

Helpers for working with 4-tuples

# Getting values
@docs first, second, third, fourth

# Mapping functions
@docs map

-}

{-| Return the first value of a 4-tuple
-}
first : (a, b, c, d) -> a
first (a, b, c, d) =
  a

{-| Return the second value of a 4-tuple
-}
second : (a, b, c, d) -> b
second (a, b, c, d) =
  b

{-| Return the third value of a 4-tuple
-}
third : (a, b, c, d) -> c
third (a, b, c, d) =
  c

{-| Return the fourth value of a 4-tuple
-}
fourth : (a, b, c, d) -> d
fourth (a, b, c, d) =
  d

{-| Apply a function to all 4 values in a 4-tuple and return the results as a
4-tuple
-}
map : (a -> b) -> (a, a, a, a) -> (b, b, b, b)
map f (a1, a2, a3, a4) =
  (f a1, f a2, f a3, f a4)
