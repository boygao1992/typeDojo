module Main where

import Prelude

import Data.Int (fromString) as Int
import Data.Maybe (Maybe(..), fromMaybe)
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (log) as Console
import Effects (genRandomString, persistDojoSession)
import JSMiddleware (jsonBodyParser)
import Node.Express.App (App)
import Node.Express.App (get, put, use, listenHttp, useExternal) as E
import Node.Express.Handler (Handler)
import Node.Express.Middleware.Static (static) as E
import Node.Express.Request (getQueryParam) as E
import Node.Express.Response (sendJson, setStatus) as E
import Node.Process (lookupEnv) as Node

respondError :: String -> Handler
respondError error = do
  E.setStatus 400
  E.sendJson { error }

indexHandler :: Handler
indexHandler =
  E.static "dist/page/"

getDojoHandler :: Handler
getDojoHandler = do
  dojo <- liftEffect $ genRandomString 500
  E.sendJson dojo

createRecordHandler :: Handler
createRecordHandler = do
  -- bodyParam <- E.getBody :: HandlerM (F String)
  -- let body = either (const "") identity $ runExcept bodyParam
  -- liftEffect $ Console.log $ "body: " <> body
  -- liftEffect $ persistDojoSession body
  durationParam <- E.getQueryParam "duration"
  case durationParam of
    Nothing ->
      respondError "Duration is required."
    Just duration ->
      liftEffect $ persistDojoSession duration
  E.sendJson { status: "Recorded" }

appSetup :: App
appSetup = do
  liftEffect $ Console.log "Setting up"
  E.useExternal jsonBodyParser
  E.use indexHandler
  E.get "/dojo" getDojoHandler
  E.put "/dojo/record" createRecordHandler


main :: Effect Unit
main = do
  portEnv <- Node.lookupEnv "Port"
  let port = case portEnv of
              Nothing -> 8080
              Just portL ->
                fromMaybe 8080 $ Int.fromString portL

  _ <- E.listenHttp appSetup port \_ ->
    Console.log $ "Listening on " <> show port
  pure unit
