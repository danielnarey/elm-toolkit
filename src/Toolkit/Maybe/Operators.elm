module Toolkit.Maybe.Operators exposing
  ( (?=), (?|>), (?+>) )

{-|

Some experimental operators for error handling with `Maybe` values

@docs (?=), (?|>), (?+>)

-}

{-| Forward operator for `Maybe.withDefault`

    Just 42 ?= 100

    --> 42

    Nothing ?= 100

    --> 100

-}
(?=) : Maybe a -> a -> a
(?=) maybeValue defaultValue =
  Maybe.withDefault defaultValue maybeValue

infixl 0 ?=

{-| Forward operator for `Maybe.map`

    Just 9
      ?|> sqrt

    --> Just 3

    Nothing
      ?|> sqrt

    --> Nothing

-}
(?|>) : Maybe a -> (a -> b) -> Maybe b
(?|>) maybeValue f =
  Maybe.map f maybeValue

infixl 0 ?|>

{-| Forward operator for `Maybe.andThen`

    List.head [1]
      ?+> always Nothing

    --> Nothing

-}
(?+>) : Maybe a -> (a -> Maybe b) -> Maybe b
(?+>) firstResult nextFunction =
  firstResult
    |> Maybe.andThen nextFunction

infixl 0 ?+>
