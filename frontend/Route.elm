module Route exposing (Route, routeParser)

import Url.Parser exposing (Parser, (</>), (<?>), int, map, oneOf, s, string)
import Url.Parser.Query as Query

type Route
    = BlogPost Int String
    | BlogQuery (Maybe String)

-- routeParser takes apart a route to look for a valid URL
-- ex) /blog/1/hello-world --> Just (BlogPost 1 "hello-world")
-- ex) /blog/hello -> Nothing
routeParser : Parser (Route -> a) a
routeParser =
    oneOf
        [ map BlogPost (s "blog" </> int </> string)
        , map BlogQuery (s "blog" <?> Query.string "post")
        ]
