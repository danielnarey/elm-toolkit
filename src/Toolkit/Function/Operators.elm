module Toolkit.Function.Operators exposing
  ( (||>), (@@|>), (#) )

{-|
@docs (||>), (@@|>), (#)
-}

{-| Forward function application with precedence set to 9. Allows you to avoid
parentheses when you want the argument to appear before the function name in an
inline expression.

    1 ||> toString ++ 2 ||> toString    --> "12"
-}
(||>) : a -> (a -> b) -> b
(||>) a f =
  f a

infixl 9 ||>


{-| Forward operator for
[`uncurry`](http://package.elm-lang.org/packages/elm-lang/core/latest/Basics#uncurry)
with 2 parameters

    (1,2) @@|> (+)    --> 3
-}
(@@|>) : (a, b) -> (a -> b -> c) -> c
(@@|>) params f =
  uncurry f params

infixl 0 @@|>


{-| An operator for
[`flip`](http://package.elm-lang.org/packages/elm-lang/core/5.0.0/Basics#flip).
Think of the `#` symbol as appearing where the missing argument would go.

    4 |> (/) 2        --> 0.5
    4 |> flip (/) 2   --> 2
    4 |> (/) # 2      --> 2


-}
(#) : (a -> b -> c) -> b -> (a -> c)
(#) f b =
  flip f b

infixl 9 #
