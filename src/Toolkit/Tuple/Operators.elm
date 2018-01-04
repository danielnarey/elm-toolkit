module Toolkit.Tuple.Operators exposing
  ( (..|>) )

{-|

Some experimental operators for working with 2-tuples

@docs (..|>)

-}

{-| Forward operator for
[Toolkit.Tuple.map](http://package.elm-lang.org/packages/danielnarey/elm-toolkit/latest/Toolkit-Tuple#map)

    (1,2)
    ..|> (+) 1

    --> (2,3)

-}
(..|>) : (a, a) -> (a -> b) -> (b, b)
(..|>) (a1, a2) f =
  (f a1, f a2)

infixl 0 ..|>
