module Toolkit.Tuple.Operators exposing
  ( (..|>) )

{-|
@docs (..|>)
-}

{-| Forward operator for Toolkit.Tuple.map

    (1,2) ..|> (+) 1    --> (2,3)
-}
(..|>) : (a, a) -> (a -> b) -> (b, b)
(..|>) (a1, a2) f =
  (f a1, f a2)

infixl 0 ..|>
