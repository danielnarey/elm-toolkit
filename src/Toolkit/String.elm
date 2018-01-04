module Toolkit.String exposing
  ( toBool )

{-|

Helpers for working with strings

# Conversions
@docs toBool

-}

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
