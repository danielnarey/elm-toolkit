module Toolkit.Tuple exposing
  ( map )

{-|

Helpers for working with 2-tuples

# Mapping functions
@docs map

-}

{-| Apply a function to both values in a 2-tuple and return the results as a
2-tuple
-}
map : (a -> b) -> (a, a) -> (b, b)
map f (a1, a2) =
  (f a1, f a2)
