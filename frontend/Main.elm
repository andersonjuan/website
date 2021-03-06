module Main exposing (main)

-- Elm package imports
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url
import Http

-- Website package imports
import Post as Post
import Route exposing (Route, routeParser)
import Asset
import Json.Decode exposing (Decoder, string, field)

-- MAIN
-- Mandatory main function for the Single-Page Application

main : Program () Model Msg
main =
  Browser.application
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    , onUrlChange = UrlChanged
    , onUrlRequest = LinkClicked
    }



-- MODEL
-- Holds the client-side context

-- Page represents the type of Pages we can have
type Page
    = Home
    | Post

type alias Model =
  { page : Page
  , key : Nav.Key
  , url : Url.Url
  }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    ( Model Home key url, Cmd.none )


-- UPDATE
-- Handles updates to the page

-- Msg type, holds the possible message for Cmd
type Msg
  = Blog (Result Http.Error String) -- recieved a post from the server
  | LinkClicked Browser.UrlRequest -- a link was clinked
  | UrlChanged Url.Url -- the url changed
  | NoOp -- nothing



-- update contains the logic for routing updates to the
-- page
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            stepUrl url model

        Blog result ->
            -- see if the server responded with the page
            case result of
                Ok post ->
                    (model, Cmd.none)

                Err _ ->
                    (model, Cmd.none)

        NoOp -> (model, Cmd.none)



-- SUBSCRIPTIONS
-- handles incoming messages to elm

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW
-- generates the actual html page

view : Model -> Browser.Document Msg
view model =
    { title = "Super Cool Title"
    , body =
        [ renderHeader
        , section [] []
        ]
    }

-- viewLink takes the string
-- and renders it as a link
viewLink : String -> Html msg
viewLink path =
  li [] [ a [ href path ] [ text path ] ]

-- renderHeader renders the headers of the site
-- Defines the header of a page or section.
-- It often contains a logo, the title of the web site, and a navigational table of content.
renderHeader : Html msg
renderHeader =
    header [type_ "menu"]
    [ h3 [] [text "Super Cool Title"
    , nav [] []
    ]

-- Routing


-- stepUrl takes a url, model generates the appropriate
-- change in the page
stepUrl : Url.Url -> Model -> (Model, Cmd Msg)
stepUrl url model =
    Debug.todo "TODO"



-- HTTP Interactions

-- fetchBlog takes the string representing the URL
-- and attempts to grab the page
fetchBlog : String -> Cmd Msg
fetchBlog blogUrl =
    Http.get
    { url = blogUrl
    , expect = Http.expectJson Blog decodeMarkdown
    }

-- decodeMarkdown unwraps the markdown string from
-- the recieved JSON
decodeMarkdown : Decoder String
decodeMarkdown =
    field "text" string
