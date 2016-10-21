module Toolkit.Helpers exposing
  ( toBool, thenTry, maybe2Tuple, maybe3Tuple, maybe4Tuple, wrapList, getNth
  , take2Tuple, take3Tuple, take4Tuple, unzip3, unzip4, zip, zip3, zip4, fst3
  , snd3, trd3, fst4, snd4, trd4, fth4, curry3, curry4, uncurry3, uncurry4
  , apply2, apply3, apply4, applyList)


{-|

## Some generic helper functions for type conversion, error handling, and working with lists, tuples, and functions

This is my personal library of helper functions for writing clean,
unidirectional, semantically pleasing Elm code. I've included all of these
functions in one module so that I can easily import them into other projects.

# String-to-Bool Conversion
@docs toBool

# Error Handling with Chained Results
@docs thenTry

# Error Handling with Multiple `Maybe` Values
@docs maybe2Tuple, maybe3Tuple, maybe4Tuple

# Value-to-List and Value-From-List Conversions
@docs wrapList, getNth

# List-Tuple Conversions
@docs take2Tuple, take3Tuple, take4Tuple, unzip3, unzip4, zip, zip3, zip4

# Getting Values from Tuples
@docs fst3, snd3, trd3, fst4, snd4, trd4, fth4

# Currying and Uncurrying
@docs curry3, curry4, uncurry3, uncurry4

# Applying Multiple Functions to Data
@docs apply2, apply3, apply4, applyList

-}


import String
import List
import Result


--TYPE CONVERSION

{-| Convert a boolean string to a `Bool`, ignoring case

    toBool "true"     --> Ok True
    toBool "True"     --> Ok True
    toBool "false"    --> Ok False
    toBool "FALSE"    --> Ok False
    toBool "blah"     --> Err "String argument must be 'true' or 'false' (case ignored)"
-}
toBool : String -> Result String Bool
toBool boolString =
  case boolString |> String.toLower of
    "true" ->
      Ok True

    "false" ->
      Ok False

    _ ->
      Err "String argument must be 'true' or 'false' (case ignored)"


--ERROR HANDLING WITH CHAINED RESULTS

{-| Same as
[`Result.andThen`](http://package.elm-lang.org/packages/elm-lang/core/latest/Result#andThen),
but flips the order of the arguments, allowing for cleaner syntax when used with
the `|>` operator.

    rawString
      |> toInt
      |> thenTry toValidMonth

-}
thenTry : (a -> Result x b) -> Result x a -> Result x b
thenTry callback result =
  Result.andThen result callback


--ERROR HANDLING WITH MULTIPLE MAYBES

{-| Given a 2-tuple of `Maybe` values, if both values are defined, return `Just`
the 2-tuple of values; otherwise, return `Nothing`

    maybe2Tuple (Just 1, Just 2)    --> Just (1,2)
    maybe2Tuple (Just 1, Nothing)    --> Nothing
-}
maybe2Tuple : (Maybe a, Maybe b) -> Maybe (a, b)
maybe2Tuple tuple =
  case tuple of
    (Just a, Just b) ->
      Just (a, b)

    _ ->
      Nothing


{-| Given a 3-tuple of `Maybe` values, if all three values are defined, return
`Just` the 3-tuple of values; otherwise, return `Nothing`
-}
maybe3Tuple : (Maybe a, Maybe b, Maybe c) -> Maybe (a, b, c)
maybe3Tuple tuple =
  case tuple of
    (Just a, Just b, Just c) ->
      Just (a, b, c)

    _ ->
      Nothing


{-| Given a 4-tuple of `Maybe` values, if all four values are defined, return
`Just` the 4-tuple of values; otherwise, return `Nothing`
-}
maybe4Tuple : (Maybe a, Maybe b, Maybe c, Maybe d) -> Maybe (a, b, c, d)
maybe4Tuple tuple =
  case tuple of
    (Just a, Just b, Just c, Just d) ->
      Just (a, b, c, d)

    _ ->
      Nothing


-- VALUE-TO-LIST AND VALUE-FROM-LIST CONVERSIONS

{-| Return a one-item list containing the argument

    wrapList ("key", "value")

    --> [ ("key", "value") ]
-}
wrapList : a -> List a
wrapList a =
  [ a ]


{-| Get the value at the nth place of a list without converting the list to an
array; returns `Nothing` if the list contains fewer than `n + 1` items, or if
`n` is negative

    getNth 0 [1, 3, 9, 27]    --> Just 1
    getNth 3 [1, 3, 9, 27]    --> Just 27
    getNth 4 [1, 3, 9, 27]    --> Nothing
    getNth -1 [1, 3, 9, 27]   --> Nothing

-}
getNth : Int -> List a -> Maybe a
getNth n list =
  if n < 0 then
    Nothing

  else
    list
      |> List.drop n
      |> List.head


-- LIST-TUPLE CONVERSIONS

{-| Returns the first two items in a list as a 2-tuple, or `Nothing` if the list
contains fewer than two items

    take2Tuple [1,2]   --> Just (1,2)
    take2Tuple [1,2,3]    --> Just (1,2)
    take2Tuple [1]    --> Nothing
-}
take2Tuple : List a -> Maybe (a, a)
take2Tuple list =
  list
    |> apply2 (getNth 0, getNth 1)
    |> maybe2Tuple


{-| Returns the first three items in a list as a 3-tuple, or `Nothing` if the
list contains fewer than three items
-}
take3Tuple : List a -> Maybe (a, a, a)
take3Tuple list =
  list
    |> apply3 (getNth 0, getNth 1, getNth 2)
    |> maybe3Tuple


{-| Returns the first four items in a list as a 4-tuple, or `Nothing` if the
list contains fewer than four items
-}
take4Tuple : List a -> Maybe (a, a, a, a)
take4Tuple list =
    list
      |> apply4 (getNth 0, getNth 1, getNth 2, getNth 3)
      |> maybe4Tuple


{-| Convert a 3-tuple of lists to a list of 3-tuples (see
[List.unzip](package.elm-lang.org/packages/elm-lang/core/latest/List#unzip))
-}
unzip3 : (List a, List b, List c) -> List (a, b, c)
unzip3 (list1, list2, list3) =
  List.map3 (\a b c -> (a, b, c)) list1 list2 list3


{-| Convert a 4-tuple of lists to a list of 4-tuples
-}
unzip4 : (List a, List b, List c, List d) -> List (a, b, c, d)
unzip4 (list1, list2, list3, list4) =
  List.map4 (\a b c d -> (a, b, c, d)) list1 list2 list3 list4


{-| Convert a 2-tuple of lists to a list of 2-tuples

    zip ([0,17,1337], [True,False,True])

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


--GETTING VALUES FROM TUPLES

{-| Return the first value of a 3-tuple
-}
fst3 : (a, b, c) -> a
fst3 (a, b, c) =
  a

{-| Return the second value of a 3-tuple
-}
snd3 : (a, b, c) -> b
snd3 (a, b, c) =
  b

{-| Return the third value of a 3-tuple
-}
trd3 : (a, b, c) -> c
trd3 (a, b, c) =
  c

{-| Return the first value of a 4-tuple
-}
fst4 : (a, b, c, d) -> a
fst4 (a, b, c, d) =
  a

{-| Return the second value of a 4-tuple
-}
snd4 : (a, b, c, d) -> b
snd4 (a, b, c, d) =
  b

{-| Return the third value of a 4-tuple
-}
trd4 : (a, b, c, d) -> c
trd4 (a, b, c, d) =
  c

{-| Return the fourth value of a 4-tuple
-}
fth4 : (a, b, c, d) -> d
fth4 (a, b, c, d) =
  d


--CURRYING AND UNCURRYING

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


--APPLYING MULTIPLE FUNCTIONS TO DATA

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
  let
    getNextResult (data, fList) =
      case fList |> List.head of
        Just f ->
          [ data |> f ]

        Nothing ->
          []

    applyNextFun (data, fList) resultList =
      case fList of
        Just fList ->
          (data, fList)
            |> getNextResult
            |> (++) resultList
            |> applyNextFun (data, fList |> List.tail)

        Nothing ->
          resultList

  in
    []
      |> applyNextFun (data, Just fList)
