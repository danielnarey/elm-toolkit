module Toolkit.Result.Operators exposing
  ( (!=), (!|>), (!+>) )

{-|

Some experimental operators for error handling with `Result` values

@docs (!=), (!|>), (!+>)

-}

{-| Forward operator for `Result.withDefault`

    String.toInt "123" != 0

    --> 123

    String.toInt "abc" != 0

    --> 0

-}
(!=) : Result x a -> a -> a
(!=) resultValue defaultValue =
  Result.withDefault defaultValue resultValue

infixl 0 !=


{-| Forward operator for `Result.map`

    Ok 4.0
      !|> sqrt

    --> Ok 2.0

    Err "bad input"
      !|> sqrt

    --> Err "bad input"

-}
(!|>) : Result x a -> (a -> value) -> Result x value
(!|>) resultValue f =
  Result.map f resultValue

infixl 0 !|>


{-| Forward operator for `Result.andThen`

    String.toInt "1"
      !+> always (Err "ERROR")

    --> Err "ERROR"
    
-}
(!+>) : Result x a -> (a -> Result x b) -> Result x b
(!+>) firstResult nextFunction =
  firstResult
    |> Result.andThen nextFunction

infixl 0 !+>
