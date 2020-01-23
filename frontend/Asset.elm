module Asset exposing (Asset(..), post)

{- Assets such as images, etc.

This is the only module for being in charge of them, never expose the URLs

-}

import Html exposing (Attribute, Html)
import Html.Attributes as Attr

-- defines the assets that can be used by the client app
type Asset
    = Asset String

-- Images

-- retrieves the given post
post : String -> Asset
post filename =
    Asset ("/static/blog/" ++ filename)
