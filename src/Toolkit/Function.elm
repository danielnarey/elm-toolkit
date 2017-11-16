module Toolkit.Function exposing
  ( apply2, apply3, apply4, applyList
  , curry3, curry4, uncurry3, uncurry4
  )

{-|

# Apply multiple function to data
@docs apply2, apply3, apply4, applyList

# Curry and uncurry with more than two arguments
@docs curry3, curry4, uncurry3, uncurry4

-}


{-| Given a tuple containing two functions and a value accepted by both
functions, return a tuple containing the two results
-}
apply2 : (a -> b, a -> c) -> a -> (b, c)
apply2 (f1, f2) a =
  (f1 a, f2 a)


{-| Given a tuple containing three functions and a value accepted by all three
functions, return a tuple containing the three results
-}
apply3 : (a -> b, a -> c, a -> d) -> a -> (b, c, d)
apply3 (f1, f2, f3) a =
  (f1 a, f2 a, f3 a)


{-| Given a tuple containing four functions and a value accepted by all four
functions, return a tuple containing the four results
-}
apply4 : (a -> b, a -> c, a -> d, a -> e) -> a -> (b, c, d, e)
apply4 (f1, f2, f3, f4) a =
  (f1 a, f2 a, f3 a, f4 a)


{-| Given a list containing any number of functions and a value accepted by
every function in the list, return a list containing all of the results. Note
that to use `applyList`, all of the results must be of the same type, which is
not the case for the apply functions that return tuples.
-}
applyList : List (a -> b) -> a -> List b
applyList fList data =
  case fList of
    [] ->
      []

    next :: rest ->
      (data |> next) :: (data |> applyList rest)


{-| [`curry`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#curry)
with 3 parameters
-}
curry3 : ((a, b, c) -> d) -> a -> b -> c -> d
curry3 f a b c =
  f (a, b, c)


{-| [`curry`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#curry)
with 4 parameters
-}
curry4 : ((a, b, c, d) -> e) -> a -> b -> c -> d -> e
curry4 f a b c d =
  f (a, b, c, d)


{-| [`uncurry`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#uncurry)
with 3 parameters
-}
uncurry3 : (a -> b -> c -> d) -> (a, b, c) -> d
uncurry3 f (a, b, c) =
  f a b c


{-| [`uncurry`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#uncurry)
with 4 parameters
-}
uncurry4 : (a -> b -> c -> d -> e) -> (a, b, c, d) -> e
uncurry4 f (a, b, c, d) =
  f a b c d
