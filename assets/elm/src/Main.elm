port module Main exposing (..)

import Browser exposing (element)
import Html exposing (div, img, main_, text)
import Html.Attributes exposing (class, src)
import Http
import Json.Decode as D
import List exposing (map)


port csrfToken : (String -> msg) -> Sub msg


type alias Model =
    { comics : List Comic, token : Maybe String }


type alias Comic =
    { title : String, cover : Maybe String }


type Message
    = LoadData (Result Http.Error (List Comic))
    | CsrfToken String


main : Program () Model Message
main =
    element { init = init, view = view, update = update, subscriptions = subscriptions }


init : () -> ( Model, Cmd Message )
init _ =
    ( { comics = [], token = Nothing }, Http.get { url = "/api/comics", expect = Http.expectJson LoadData comicsDecoder } )


view : Model -> Html.Html msg
view model =
    main_ [ class "flex justify-center items-center h-screen w-screen" ]
        [ viewComics model.comics
        ]


update : Message -> Model -> ( Model, Cmd msg )
update msg model =
    case msg of
        LoadData result ->
            case result of
                Ok body ->
                    ( { model | comics = body }, Cmd.none )

                Err _ ->
                    ( model, Cmd.none )

        CsrfToken token ->
            ( { model | token = Just token }, Cmd.none )


subscriptions : Model -> Sub Message
subscriptions _ =
    csrfToken CsrfToken


viewComics : List Comic -> Html.Html msg
viewComics comics =
    div [ class "flex" ] (map viewComic comics)


viewComic : Comic -> Html.Html msg
viewComic comic =
    div [ class "flex flex-col items-center" ]
        [ showCover comic, text comic.title ]


showCover : Comic -> Html.Html msg
showCover { cover } =
    case cover of
        Just coverUrl ->
            img [ class "max-h-80 rounded drop-shadow", src coverUrl ] []

        Nothing ->
            text "Sem capa"


comicsDecoder : D.Decoder (List Comic)
comicsDecoder =
    D.list comicDecoder


comicDecoder : D.Decoder Comic
comicDecoder =
    D.map2 Comic (D.field "title" D.string) (D.field "cover" (D.nullable D.string))
