module Blog exposing (..)

-- elm imports
import Http
import Json.Decode exposing (Decoder, field, string)


-- local imports

type Request
    = Blog (Result Http.Error String)
    | None

fetchBlog : String -> Cmd Msg
fetchBlog blogUrl =
    Http.get
    { url = blogUrl
    , expect = Http.expectJson Request decodeMarkdown
    }


decodeMarkdown : Decoder String
decodeMarkdown =
    field "text" string
