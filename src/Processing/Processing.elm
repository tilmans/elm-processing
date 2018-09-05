module Processing.Processing exposing (Model, getCustom, getMouse, processing)

import Browser
import Canvas exposing (Commands)
import CanvasColor as Color
import Dict exposing (Dict)
import Html exposing (Html, div)
import Html.Attributes exposing (style)


type alias SetupFunction =
    List ( String, String )


type alias DrawFunction =
    Model -> Commands -> Commands


type Model
    = Model InternalModel


type alias InternalModel =
    { mouse : ( Int, Int )
    , state : Dict String String
    }


type alias Flags =
    {}


type Msg
    = NoOp


getCustom : String -> Model -> String
getCustom string (Model model) =
    model.state |> Dict.get string |> Maybe.withDefault ""


getMouse : Model -> ( Int, Int )
getMouse (Model model) =
    model.mouse


init : SetupFunction -> Flags -> ( Model, Cmd Msg )
init setup flags =
    ( Model (InternalModel ( 0, 0 ) (Dict.fromList setup)), Cmd.none )


view : DrawFunction -> Model -> Html Msg
view draw model =
    let
        width =
            500

        height =
            300
    in
    Canvas.element
        width
        height
        [ style "border" "1px solid black" ]
        (Canvas.empty
            |> Canvas.clearRect 0 0 width height
            |> draw model
        )


update msg model =
    ( model, Cmd.none )


subscriptions model =
    Sub.none


processing : SetupFunction -> DrawFunction -> Program Flags Model Msg
processing setup draw =
    Browser.element
        { init = init setup
        , view = view draw
        , update = update
        , subscriptions = subscriptions
        }
