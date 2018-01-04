module Toolkit.Maybe exposing
  ( zip, zip3, zip4, zipList
  , filter
  )

{-|

Helpers for error handling with multiple `Maybe` values

# Zipping
@docs zip, zip3, zip4, zipList

# Filtering
@docs filter

-}

{-| Given a 2-tuple of `Maybe` values, if both values are defined, return `Just`
the 2-tuple of values; otherwise, return `Nothing`

    (Just 1, Just 2)
      |> Toolkit.Maybe.zip

    --> Just (1,2)

    (Just 1, Nothing)
      |> Toolkit.Maybe.zip

    --> Nothing

-}
zip : (Maybe a, Maybe b) -> Maybe (a, b)
zip tuple =
  case tuple of
    (Just a, Just b) ->
      Just (a, b)

    _ ->
      Nothing


{-| Given a 3-tuple of `Maybe` values, if all three values are defined, return
`Just` the 3-tuple of values; otherwise, return `Nothing`
-}
zip3 : (Maybe a, Maybe b, Maybe c) -> Maybe (a, b, c)
zip3 tuple =
  case tuple of
    (Just a, Just b, Just c) ->
      Just (a, b, c)

    _ ->
      Nothing


{-| Given a 4-tuple of `Maybe` values, if all four values are defined, return
`Just` the 4-tuple of values; otherwise, return `Nothing`
-}
zip4 : (Maybe a, Maybe b, Maybe c, Maybe d) -> Maybe (a, b, c, d)
zip4 tuple =
  case tuple of
    (Just a, Just b, Just c, Just d) ->
      Just (a, b, c, d)

    _ ->
      Nothing


{-| Given a list of `Maybe` values, if all values are defined, return
`Just` the list of values; otherwise, return `Nothing`. When passed an empty
list, returns `Just` an empty list.

    [Just 1, Just 2]
      |> Toolkit.Maybe.zipList

    --> Just [1,2]

    [Just 1, Nothing]
      |> Toolkit.Maybe.zipList

    --> Nothing

    []
      |> Toolkit.Maybe.zipList

    --> Just []

-}
zipList : List (Maybe a) -> Maybe (List a)
zipList maybeList =
  let
    toSingleton maybeValue =
      case maybeValue of
        Just value ->
          [ value ]

        Nothing ->
          []

  in
    case (maybeList |> List.member Nothing) of
      True ->
        Nothing

      False ->
        maybeList
          |> List.map toSingleton
          |> List.concat
          |> Just


{-| Given a list of `Maybe` values, return a list containing only the defined
values.

    [ Just 1
    , Just 2
    , Nothing
    ]
      |> Toolkit.Maybe.filter

    --> [1, 2]

-}
filter : List (Maybe a) -> List a
filter maybeList =
  let
    toSingleton maybeValue =
      case maybeValue of
        Just value ->
          [ value ]

        Nothing ->
          []

  in
    maybeList
      |> List.map toSingleton
      |> List.concat
