module Toolkit.List.Operators exposing
  ( (|++), (|::), (:|++), (:|::)
  , (.|>), (:|>)
  )


{-|

Some experimental operators for working with lists

# Appending lists and single elements
@docs (|++), (|::), (:|++), (:|::)

# Mapping functions
@docs (.|>)

# Wrapping a single element and applying a list function
@docs (:|>)

-}


{-| Append the RHS to the end of the LHS; equivalent to `++`, but
left-associative with precedence set to `0` (same as `|>`)

    ("ba" |> String.reverse) ++ "c"

    --> "abc"

    "ba"
      |> String.reverse
      ++ "c"

    --> ERROR

    "ba"
      |> String.reverse
      |++ "c"

    --> "abc"

-}
(|++) : appendable -> appendable -> appendable
(|++) a b =
  a ++ b

infixl 0 |++


{-| Append the item on the RHS to the end of the list on the LHS

    [1]
      |:: 2

    --> [1,2]

    [1]
      |:: 2
      |:: 3

    --> [1,2,3]

-}
(|::) : List a -> a -> List a
(|::) list a =
  list ++ [ a ]

infixl 0 |::


{-| Wrap LHS in a list, then append RHS list to it; equivalent to `::`, but
left-associative with precedence set to `0` (same as `|>`)

    ("a" ++ "b")
      :: ["cd","ef"]

    --> ["ab","cd","ef"]

    "a" ++ "b"
      :: ["cd","ef"]

    --> ERROR

    "a" ++ "b"
     :|++ ["cd","ef"]

    --> ["ab","cd","ef"]

-}
(:|++) : a -> List a -> List a
(:|++) a list =
   a :: list

infixl 0 :|++


{-| Wrap LHS in a list, then append the item on RHS to the list

    1
     :|:: 2

    --> [1,2]

-}
(:|::) : a -> a -> List a
(:|::) a b =
  [a, b]

infixl 0 :|::


{-| Forward operator for List.map

    [ 1
    , 4
    , 9
    ]
     .|> sqrt

    --> [1,2,3]

-}
(.|>) : List a -> (a -> b) -> List b
(.|>) list f =
  List.map f list

infixl 0 .|>


{-| Wrap LHS in a list, then apply RHS function

    1
     :|> List.head

    --> Just 1

-}
(:|>) : a -> (List a -> b) -> b
(:|>) a f =
  f [ a ]

infixl 0 :|>
