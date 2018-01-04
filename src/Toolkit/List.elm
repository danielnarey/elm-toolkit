module Toolkit.List exposing
  ( isOneOf, getNth, unique
  , take2Tuple, take3Tuple, take4Tuple
  , from2Tuple, from3Tuple, from4Tuple
  , unzip3, unzip4
  , zip, zip3, zip4
  )

{-|

Helpers for working with lists

# General
@docs isOneOf, getNth, unique

# List-Tuple conversions
@docs take2Tuple, take3Tuple, take4Tuple, from2Tuple, from3Tuple, from4Tuple

# Zipping and unzipping
@docs zip, zip3, zip4, unzip3, unzip4

-}

import Set
import Toolkit.Maybe
import Toolkit.Function


{-| Given a list and a test value, returns `True` if the list contains a value
equal to the test value.

    "apple"
      |> Toolkit.List.isOneOf
        [ "apple"
        , "banana"
        , "cherry"
        ]

    --> True

Equivalent to
[List.member](http://package.elm-lang.org/packages/elm-lang/core/latest/List#member)
with the arguments flipped

-}
isOneOf : List a -> a -> Bool
isOneOf list value =
  List.member value list


{-| Get the value at the nth place of a list without converting the list to an
array; returns `Nothing` if the list contains fewer than `n + 1` items, or if
`n` is negative

    [1, 3, 9, 27]
      |> Toolkit.List.getNth 0

    --> Just 1

    [1, 3, 9, 27]
      |> Toolkit.List.getNth 3

    --> Just 27

    [1, 3, 9, 27]
      |> Toolkit.List.getNth 4

    --> Nothing

    [1, 3, 9, 27]
      |> Toolkit.List.getNth -1

    --> Nothing

-}
getNth : Int -> List a -> Maybe a
getNth n list =
  if n < 0 then
    Nothing

  else
    list
      |> List.drop n
      |> List.head


-- REMOVING DUPLICATE VALUES FROM A LIST
{-| Given a list of values, returns the unique values as a list sorted from
highest to lowest

    [ "banana"
    , "cherry"
    , "apple"
    , "apple"
    ]
      |> Toolkit.List.unique

    --> ["apple", "banana", "cherry"]

-}
unique : List comparable -> List comparable
unique =
  Set.fromList
    >> Set.toList


-- LIST-TUPLE CONVERSIONS

{-| Returns the first two items in a list as a 2-tuple, or `Nothing` if the list
contains fewer than two items

    [1,2]
      |> Toolkit.List.take2Tuple

    --> Just (1,2)

    [1,2,3]
      |> Toolkit.List.take2Tuple

    --> Just (1,2)

    [1]
      |> Toolkit.List.take2Tuple

    --> Nothing

-}
take2Tuple : List a -> Maybe (a, a)
take2Tuple list =
  list
    |> Toolkit.Function.apply2 (getNth 0, getNth 1)
    |> Toolkit.Maybe.zip


{-| Returns the first three items in a list as a 3-tuple, or `Nothing` if the
list contains fewer than three items
-}
take3Tuple : List a -> Maybe (a, a, a)
take3Tuple list =
  list
    |> Toolkit.Function.apply3 (getNth 0, getNth 1, getNth 2)
    |> Toolkit.Maybe.zip3


{-| Returns the first four items in a list as a 4-tuple, or `Nothing` if the
list contains fewer than four items
-}
take4Tuple : List a -> Maybe (a, a, a, a)
take4Tuple list =
    list
      |>  Toolkit.Function.apply4 (getNth 0, getNth 1, getNth 2, getNth 3)
      |> Toolkit.Maybe.zip4


{-| Given a 2-tuple where both values are of the same type, return a list
containing those values

    (1,2)
      |> Toolkit.List.from2Tuple

    --> Just [1,2]

-}
from2Tuple : (a, a) -> List a
from2Tuple (a, b) =
  [a, b]


{-| Given a 3-tuple where all three values are of the same type, return a list
containing those values
-}
from3Tuple : (a, a, a) -> List a
from3Tuple (a, b, c) =
  [a, b, c]


{-| Given a 4-tuple where all four values are of the same type, return a list
containing those values
-}
from4Tuple : (a, a, a, a) -> List a
from4Tuple (a, b, c, d) =
  [a, b, c, d]


{-| Convert a 3-tuple of lists to a list of 3-tuples (see
[List.unzip](package.elm-lang.org/packages/elm-lang/core/latest/List#unzip))
-}
unzip3 : List (a, b, c) -> (List a, List b, List c)
unzip3 triples =
  let
    step (a, b, c) (listA, listB, listC) =
      ( a :: listA
      , b :: listB
      , c :: listC
      )
  in
    triples
      |> List.foldr step ([], [], [])


{-| Convert a 4-tuple of lists to a list of 4-tuples
-}
unzip4 : List (a, b, c, d) -> (List a, List b, List c, List d)
unzip4 quads =
  let
    step (a, b, c, d) (listA, listB, listC, listD) =
      ( a :: listA
      , b :: listB
      , c :: listC
      , d :: listD
      )
  in
    quads
      |> List.foldr step ([], [], [], [])


{-| Convert a 2-tuple of lists to a list of 2-tuples

    ( [ 0
      , 17
      , 1337
      ]

    , [ True
      , False
      , True
      ]

    )
      |> Toolkit.List.zip

    --> [(0, True), (17, False), (1337, True)]

-}
zip : (List a, List b) -> List (a, b)
zip (list1, list2) =
  List.map2 (,) list1 list2


{-| Convert a 3-tuple of lists to a list of 3-tuples
-}
zip3 : (List a, List b, List c) -> List (a, b, c)
zip3 (list1, list2, list3) =
  List.map3 (\a b c -> (a, b, c)) list1 list2 list3


{-| Convert a 4-tuple of lists to a list of 4-tuples
-}
zip4 : (List a, List b, List c, List d) -> List (a, b, c, d)
zip4 (list1, list2, list3, list4) =
  List.map4 (\a b c d -> (a, b, c, d)) list1 list2 list3 list4
