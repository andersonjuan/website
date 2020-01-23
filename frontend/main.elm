module Main exposing (main)

-- Elm package imports
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url

-- Website package imports
import Page.Post as Post
import Route exposing (Route, routeParser)


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
    | Blog

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
  = LinkClicked Browser.UrlRequest
  | UrlChanged Url.Url
  | NoOp



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
        [ header [] []
        , section [] []
        ]
    }

-- viewLink takes the string
-- and renders it as a link
viewLink : String -> Html msg
viewLink path =
  li [] [ a [ href path ] [ text path ] ]

-- Routing


-- stepUrl takes a url, model generates the appropriate
-- change in the page
stepUrl : Url.Url -> Model -> (Model, Cmd Msg)
stepUrl url model =
    Debug.todo "TODO"
