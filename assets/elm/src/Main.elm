module Main exposing (..)

import Browser exposing (element)
import Html exposing (li, main_, text, ul)
import Html.Attributes exposing (class)
import Http
import Json.Decode as D
import List exposing (map)


type alias Model =
    List Comic


type alias Comic =
    { title : String }


type Message
    = LoadData (Result Http.Error (List Comic))


main : Program () Model Message
main =
    element { init = init, view = view, update = update, subscriptions = subscriptions }


init : () -> ( Model, Cmd Message )
init _ =
    ( [], Http.get { url = "/api/comics", expect = Http.expectJson LoadData comicsDecoder } )


view : Model -> Html.Html msg
view model =
    main_ [ class "flex justify-center items-center h-screen w-screen" ]
        [ viewComics model
        ]


update : Message -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        LoadData result ->
            case result of
                Ok body ->
                    ( body, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )


subscriptions : Model -> Sub Message
subscriptions _ =
    Sub.none


viewComics : List Comic -> Html.Html msg
viewComics comics =
    ul [] (map viewComic comics)


viewComic : Comic -> Html.Html msg
viewComic comic =
    li []
        [ text comic.title ]


comicsDecoder : D.Decoder (List Comic)
comicsDecoder =
    D.list comicDecoder


comicDecoder : D.Decoder Comic
comicDecoder =
    D.map Comic (D.field "title" D.string)
