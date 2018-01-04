module Toolkit.Result exposing
  ( try
  , zip, zip3, zip4, zipList
  , filter
  )

{-|

Helpers for error handling with multiple `Result` values

# Implicit default value
@docs try

# Zipping
@docs zip, zip3, zip4, zipList

# Filtering
@docs filter

-}


{-| Apply a function that returns a `Result` value, with the initial value as
the default (equivalent to `f x |> Result.withDefault x`). Note that the type
returned in an `Ok` result must match the type of the initial value.
-}
try : (a -> Result x a) -> a -> a
try resultFunction initialValue =
  case initialValue |> resultFunction of
    Ok resultValue ->
      resultValue

    Err _ ->
      initialValue


{-| Given a 2-tuple of `Result` values, if both values are `Ok`, return an `Ok`
result containing the 2-tuple of values; otherwise, return an `Err` value.

    (Ok 1, Ok 2)
      |> Toolkit.Result.zip "ERROR"

    --> Ok (1,2)

    (Ok 1, Err "..")
      |> Toolkit.Result.zip "ERROR"

    --> Err "ERROR"

-}
zip : x -> (Result x a, Result x b) -> Result x (a, b)
zip error tuple =
  case tuple of
    (Ok a, Ok b) ->
      Ok (a, b)

    _ ->
      Err error


{-| Given a 3-tuple of `Result` values, if all three values are `Ok`, return an
`Ok` result containing the 3-tuple of values; otherwise, return an `Err`
value.
-}
zip3 : x -> (Result x a, Result x b, Result x c) -> Result x (a, b, c)
zip3 error tuple =
  case tuple of
    (Ok a, Ok b, Ok c) ->
      Ok (a, b, c)

    _ ->
      Err error


{-| Given a 4-tuple of `Result` values, if all three values are `Ok`, return an
`Ok` result containing the 4-tuple of values; otherwise, return an `Err`
value.
-}
zip4 : x -> (Result x a, Result x b, Result x c, Result x d) -> Result x (a, b, c, d)
zip4 error tuple =
  case tuple of
    (Ok a, Ok b, Ok c, Ok d) ->
      Ok (a, b, c, d)

    _ ->
      Err error


{-| Given a list of `Result` values, if all values are `Ok`, return an `Ok`
result containing the list of values; otherwise, return an error message. When
passed an empty list, returns `Ok []`.

    [Ok 1, Ok 2]
      |> Toolkit.Result.zipList "ERROR"

    --> Ok [1,2]

    [Ok 1, Err ".."]
      |> Toolkit.Result.zipList "ERROR"

    --> Err "ERROR"

    []
      |> Toolkit.Result.zipList "ERROR"

    --> Ok []

-}
zipList : x -> List (Result x a) -> Result x (List a)
zipList error resultList =
  let
    toSingleton resultValue =
      case resultValue of
        Ok value ->
          [ value ]

        Err _ ->
          []

    singletonList =
      resultList
        |> List.map toSingleton

  in
    case singletonList |> List.member [] of
      True ->
        error
          |> Err

      False ->
        singletonList
          |> List.concat
          |> Ok


{-| Given a list of `Result` values, return a list containing only the success
values.

    [ Ok 1
    , Ok 2
    , Err ".."
    ]
      |> Toolkit.Result.filter

    --> [1, 2]

-}
filter : List (Result x a) -> List a
filter resultList =
  let
    toSingleton resultValue =
      case resultValue of
        Ok value ->
          [ value ]

        Err _ ->
          []

  in
    resultList
      |> List.map toSingleton
      |> List.concat
