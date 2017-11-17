module Toolkit.Function exposing
  ( apply2, apply3, apply4, applyList, applyWithArgs
  , compose, compose3, compose4, composeList, composeWithArgs
  , curry3, curry4, uncurry3, uncurry4
  )

{-|

# Apply multiple function to data
@docs apply2, apply3, apply4, applyList, applyWithArgs

# Compose multiple functions
@docs compose, compose3, compose4, composeList, composeWithArgs

# Curry and uncurry with more than two arguments
@docs curry3, curry4, uncurry3, uncurry4

-}


{-| Given a tuple containing two functions and a value accepted by both
functions, return a tuple containing the two results

    "1"
      |> Toolkit.Function.apply2
        ( flip (++) "2"
        , String.toInt
        )

    --> ("12", Ok 1)

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

    "a"
      |> Toolkit.Function.applyList
        [ flip (++) "b"
        , flip (++) "c"
        , flip (++) "d"
        ]

    --> ["ab", "ac", "ad"]
-}
applyList : List (a -> b) -> a -> List b
applyList fList data =
  case fList of
    [] ->
      []

    next :: rest ->
      (data |> next) :: (data |> applyList rest)


{-| Apply a series of functions that vary by the value of the first argument,
returning the results as a list.

    "a"
      |> Toolkit.Function.applyWithArgs (flip (++))
        [ "b"
        , "c"
        , "d"
        ]

    --> ["ab", "ac", "ad"]
-}
applyWithArgs : (a -> b -> b) -> List a -> b -> List b
applyWithArgs f args data =
  data
    |> applyList (args |> List.map f)


{-| Compose 2 functions, given as a 2-tuple

    "1"
      |> Toolkit.Function.compose
        ( flip (++) "1"
        , String.toInt
        )

    --> Ok 11

-}
compose : (a -> b, b -> c) -> a -> c
compose (f1, f2) data =
  data
    |> f1
    |> f2


{-| Compose 3 functions, given as a 3-tuple
-}
compose3 : (a -> b, b -> c, c -> d) -> a -> d
compose3 (f1, f2, f3) data =
  data
    |> f1
    |> f2
    |> f3


{-| Compose 4 functions, given as a 4-tuple
-}
compose4 : (a -> b, b -> c, c -> d, d -> e) -> a -> e
compose4 (f1, f2, f3, f4) data =
  data
    |> f1
    |> f2
    |> f3
    |> f4


{-| Compose a list of functions of arbitrary length; each function must take an
argument of the same type, with a result also of the same type.

    "a"
      |> Toolkit.Function.composeList [ flip (++) "b", flip (++) "c"]

    --> "abc"
-}
composeList : List (a -> a) -> a -> a
composeList fList data =
  let
    compose functions =
      case functions of
        [] ->
          identity

        next :: rest ->
          next
            >> compose rest

  in
    data
      |> compose fList


{-| Compose a series of functions that vary by the value of the first argument.

    "a"
      |> Toolkit.Function.composeWithArgs (flip (++)) ["b", "c", "d"]

    --> "abcd"
-}
composeWithArgs : (a -> b -> b) -> List a -> b -> b
composeWithArgs f args data =
  data
    |> composeList (args |> List.map f)


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
