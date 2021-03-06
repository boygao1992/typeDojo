module Main where

import Prelude

import Control.Monad.Except (runExcept)
import Data.Either (either)
import Data.Int (fromString) as Int
import Data.Maybe (Maybe(..), fromMaybe)
import Effect (Effect)
import Effect.Class (liftEffect)
import Effect.Console (log) as Console
import Effect.Ref (modify_, new) as Ref
import Effects (persistDojoSession, genRandomDojo)
import JSMiddleware (jsonBodyParser)
import Node.Express.App (App)
import Node.Express.App (get, put, use, listenHttp, useExternal) as E
import Node.Express.Handler (Handler)
import Node.Express.Middleware.Static (static) as E
import Node.Express.Request (getBody) as E
import Node.Express.Response (sendJson, setStatus) as E
import Node.Process (lookupEnv) as Node
import Random.PseudoRandom (randomSeed)
import Types (StateRef, initialState)

respondError :: String -> Handler
respondError error = do
  E.setStatus 400
  E.sendJson { error }

indexHandler :: Handler
indexHandler =
  E.static "dist/page/"

getDojoHandler :: StateRef -> Handler
getDojoHandler stateRef = do
  dojo <- liftEffect $ genRandomDojo stateRef 500
  liftEffect $ Ref.modify_ _ { dojo = dojo } stateRef
  E.sendJson dojo

createRecordHandler :: Handler
createRecordHandler = do
  bodyParam <- E.getBody
  let body = either (const "") identity $ runExcept (bodyParam :: _ String)
  liftEffect $ Console.log $ "body: " <> body
  liftEffect $ persistDojoSession body
  E.sendJson { status: "Recorded" }

appSetup :: StateRef -> App
appSetup stateRef = do
  liftEffect $ Console.log "Setting up"
  E.useExternal jsonBodyParser
  E.use indexHandler
  E.get "/dojo" (getDojoHandler stateRef)
  E.put "/dojo/record" createRecordHandler

main :: Effect Unit
main = do
  portEnv <- Node.lookupEnv "Port"
  let port = case portEnv of
              Nothing -> 8080
              Just portL ->
                fromMaybe 8080 $ Int.fromString portL

  seed <- randomSeed
  stateRef <- Ref.new $ initialState seed
  _ <- E.listenHttp (appSetup stateRef) port \_ ->
    Console.log $ "Listening on " <> show port
  pure unit
