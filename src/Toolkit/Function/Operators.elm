module Toolkit.Function.Operators exposing
  ( (|>.), (@@|>), (#), (||>) )

{-|

Some experimental operators for function application

# Apply List
@docs (|>.)

# Uncurrying
@docs (@@|>)

# Flipping arguments
@docs (#)

# Precedence
@docs (||>)

-}


{-| Alias for `Toolkit.Function.applyList`

Given a list containing any number of functions and a value accepted by
every function in the list, return a list containing all of the results. Note
that to use this operator, all of the results must be of the same type.

    "a"
      |>.
        [ flip (++) "b"
        , flip (++) "c"
        , flip (++) "d"
        ]

    --> ["ab", "ac", "ad"]

-}
(|>.) : a -> List (a -> b) -> List b
(|>.) data fList =
  case fList of
    [] ->
      []

    next :: rest ->
      (data |> next) :: (data |>. rest)

infixl 0 |>.


{-| Forward operator for
[`uncurry`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#uncurry)
with 2 parameters

    (1,2)
    @@|> (+)

    --> 3

-}
(@@|>) : (a, b) -> (a -> b -> c) -> c
(@@|>) params f =
  uncurry f params

infixl 0 @@|>


{-| An operator for
[`flip`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#flip).
Think of the `#` symbol as appearing where the missing argument would go.

    4
      |> (/) 2

    --> 0.5

    4
      |> flip (/) 2

    --> 2

    4
      |> (/) # 2

    --> 2


-}
(#) : (a -> b -> c) -> b -> (a -> c)
(#) f b =
  flip f b

infixl 9 #


{-| Forward function application with precedence set to 9. Allows you to avoid
parentheses when you want the argument to appear before the function name in an
inline expression.

    1 ||> toString ++ 2 ||> toString

    --> "12"

-}
(||>) : a -> (a -> b) -> b
(||>) a f =
  f a

infixl 9 ||>
