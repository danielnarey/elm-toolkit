module Toolkit.Tuple3 exposing
  ( first, second, third, map )

{-|

Helpers for working with 3-tuples

# Getting values
@docs first, second, third

# Mapping functions
@docs map

-}

{-| Return the first value of a 3-tuple
-}
first : (a, b, c) -> a
first (a, b, c) =
  a

{-| Return the second value of a 3-tuple
-}
second : (a, b, c) -> b
second (a, b, c) =
  b

{-| Return the third value of a 3-tuple
-}
third : (a, b, c) -> c
third (a, b, c) =
  c

{-| Apply a function to all 3 values in a 3-tuple and return the results as a
3-tuple
-}
map : (a -> b) -> (a, a, a) -> (b, b, b)
map f (a1, a2, a3) =
  (f a1, f a2, f a3)
