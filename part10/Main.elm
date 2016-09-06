module Main exposing (..)

import Page.Home
import Page.Repository
import Navigation
import Page exposing (Page(..))
import Tuple2
import Html exposing (Html, div, h1, header, text, span)
import Html.Attributes exposing (class)
import Html.App as Html


type Model
    = Home Page.Home.Model
    | Repository Page.Repository.Model
    | NotFound


type Msg
    = HomeMsg Page.Home.Msg
    | RepositoryMsg Page.Repository.Msg


main : Program Never
main =
    Navigation.program (Navigation.makeParser Page.parser)
        { init = init
        , subscriptions = subscriptions
        , view = view
        , update = update
        , urlUpdate = urlUpdate
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    case model of
        Home pageModel ->
            -- TODO use Sub.map to translate from Page.Home.subscriptions
            Sub.map HomeMsg

        Repository pageModel ->
            -- Repository has no subscriptions, so there's nothing to translate!
            Sub.map RepositoryMsg

        NotFound ->
            -- NotFound has no subscriptions, so there's nothing to translate!
            Sub.map Err


init : Result String Page -> ( Model, Cmd Msg )
init result =
    case result of
        Ok (Page.Home) ->
            Html.map HomeMsg
            -- TODO use Html.map to translate from Page.Home.view
            ( NotFound, Cmd.none )

        Ok (Page.Repository repoOwner repoName) ->
            -- TODO use Html.map to translate from Page.Repository.view
            Html.map RepositoryMsg
            ( NotFound, Cmd.none )

        Ok (Page.NotFound) ->
            Html. NotFound (or error?)
            ( NotFound, Cmd.none )

        Err err ->
            Html.map Err
            ( NotFound, Cmd.none )


view : Model -> Html Msg
view model =
    withHeader <|
        case model of
            Home pageModel ->
                Page.Home.view pageModel
                -- TODO use Html.map to translate from Page.Home.view
                text "Nothing to see here yet. Still need to translate Home!"

            Repository pageModel ->
                -- TODO use Html.map to translate from Page.Repository.view
                text "Nothing to see here yet. Still need to translate Repository!"

            NotFound ->
                h1 [] [ text "Page Not Found" ]


withHeader : Html msg -> Html msg
withHeader innerContent =
    div [ class "content" ]
        [ header []
            [ h1 [] [ text "ElmHub" ]
            , span [ class "tagline" ] [ text "Like GitHub, but for Elm things." ]
            ]
        , innerContent
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( HomeMsg pageMsg, Home pageModel ) ->
            -- TODO use Tuple2.mapEach and (Cmd.map HomeMsg)
            -- to translate from Page.Home.update
            --
            -- mapEach : (a -> newA) -> (b -> newB) -> ( a, b ) -> ( newA, newB )
            ( model, Cmd.none )

        ( RepositoryMsg pageMsg, Repository pageModel ) ->
            -- TODO use Tuple2.mapEach and (Cmd.map RepositoryMsg)
            -- to translate from Page.Repository.update
            ( model, Cmd.none )

        _ ->
            ( model, Cmd.none )


urlUpdate : Result String Page -> Model -> ( Model, Cmd Msg )
urlUpdate result model =
    case result of
        Ok (Page.Home) ->
            -- TODO use Tuple2.mapEach and (Cmd.map HomeMsg)
            -- to translate from Page.Home.init
            --
            -- mapEach : (a -> newA) -> (b -> newB) -> ( a, b ) -> ( newA, newB )
            ( model, Cmd.none )

        Ok (Page.Repository repoOwner repoName) ->
            -- TODO use Tuple2.mapEach and (Cmd.map RepositoryMsg)
            -- to translate from Page.Repository.init
            --
            -- HINT: Page.Repository.init is a function that takes 2 arguments.
            ( model, Cmd.none )

        Ok (Page.NotFound) ->
            ( NotFound, Cmd.none )

        Err err ->
            ( NotFound, Cmd.none )
