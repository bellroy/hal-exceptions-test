{-# LANGUAGE OverloadedStrings #-}

module Main where

import AWS.Lambda.Runtime (mRuntime)
import Data.Aeson (FromJSON (..), withObject, (.:))
import Data.Text (Text)
import qualified Data.Text as T
import System.IO (BufferMode (..), hPutStrLn, hSetBuffering, stderr)

newtype Request = Request Text

instance FromJSON Request where
  parseJSON = withObject "Request" $ \o ->
    Request <$> o .: "message"

main :: IO ()
main = do
  hSetBuffering stderr NoBuffering
  let t = T.pack "lol"
  mRuntime $ \(Request t) -> do
    hPutStrLn stderr $ "About to throw: " <> show t
    error $ T.unpack t :: IO ()
