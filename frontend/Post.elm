module Post exposing (..)

-- elm packages
import Markdown
import Html exposing (..)

-- Markdown parsing
-- blog posts are written in markdown

-- default parsing Options
options : Markdown.Options
options =
    { githubFlavored = Just { tables = True, breaks = True }
    , defaultHighlighting = Just "bash"
    , sanitize = False
    , smartypants = True
    }

-- render takes the JSON markdown string and renders it
-- in Markdown formate
render : String -> Html msg
render content =
    Markdown.toHtmlWith options [] content
