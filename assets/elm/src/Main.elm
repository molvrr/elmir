module Main exposing (..)

import Browser exposing (element)
import Html exposing (li, main_, text, ul)
import Html.Attributes exposing (class)
import Http
import Json.Decode as D
import List exposing (map)


type alias Model =
    List User


type alias User =
    { name : String }


type Message
    = LoadData (Result Http.Error (List User))


main : Program () Model Message
main =
    element { init = init, view = view, update = update, subscriptions = subscriptions }


init : () -> ( Model, Cmd Message )
init _ =
    ( [], Http.get { url = "/api/users", expect = Http.expectJson LoadData usersDecoder } )


view : Model -> Html.Html msg
view model =
    main_ [ class "flex justify-center items-center h-screen w-screen" ]
        [ viewUsers model
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


viewUsers : List User -> Html.Html msg
viewUsers users =
    ul [] (map viewUser users)


viewUser : User -> Html.Html msg
viewUser user =
    li []
        [ text user.name ]


usersDecoder : D.Decoder (List User)
usersDecoder =
    D.list userDecoder


userDecoder : D.Decoder User
userDecoder =
    D.map User (D.field "name" D.string)
