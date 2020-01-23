module Page.Post exposing (Post)

-- elm packages
import Markdown
import Html exposing (..)

-- website imports
import Asset exposing (Asset(..), post)

-- Post represents the content of a blog post
type alias Post =
    { title : String -- title of the post
    , date : String -- date when it was created
    , content : String -- filename of the markdown
    }

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

-- decode
-- takes an Asset and returns at as a Post if possible
decode : Asset -> Maybe Post
decode (Asset filepath) =
    -- I want to expand assets to images so use case here
    Just { title = ""
         , date = ""
         , content = filepath }


-- render takes the post
-- and renders it as a
render : Post -> Html msg
render post =
    case post of
        ({ title, date, content }) ->
            Markdown.toHtmlWith options [] content
