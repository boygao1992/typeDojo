module Main where

import Prelude

import Data.Int (fromString) as Int
import Data.Maybe (Maybe(..), fromMaybe)
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (log) as Console
import Effects (genRandomString)
import Node.Express.App (App)
import Node.Express.App (get, use, listenHttp) as E
import Node.Express.Handler (Handler)
import Node.Express.Response (sendJson, sendFile) as E
import Node.Process (lookupEnv) as Node
import Node.Express.Middleware.Static (static) as E

indexHandler :: Handler
indexHandler =
  E.static "dist/page/"

getDojoHandler :: Handler
getDojoHandler = do
  dojo <- liftEffect $ genRandomString 300
  E.sendJson dojo

appSetup :: App
appSetup = do
  liftEffect $ Console.log "Setting up"
  E.use indexHandler
  E.get "/dojo" getDojoHandler


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
