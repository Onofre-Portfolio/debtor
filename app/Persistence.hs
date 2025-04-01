{-# LANGUAGE DataKinds #-}

module Persistence where

import Data.Function ((&))
import Data.Text (pack, unpack)
import qualified Money
import System.Directory (doesFileExist)
import System.Environment (lookupEnv)
import qualified System.IO.Strict as S
import Text.Printf (printf)

type BRL = Money.Dense "BRL"

filePath :: IO String
filePath = do
  maybeDev <- lookupEnv "IS_DEBTOR_DEV_ENV"

  case maybeDev of
    Just "true" -> return "./talisodiga.txt"
    Nothing -> return "/usr/local/share/debtor/ledge.txt"

getThirdWord :: [String] -> String
getThirdWord [dense : currency : decimal] = decimal
getThirdWord _ = ""

getDenseNumber :: BRL -> String
getDenseNumber dense =
  unpack $
    Money.denseToDecimal Money.defaultDecimalConf Money.Round dense

persist :: BRL -> IO ()
persist amount = do
  fileName <- filePath
  writeFile fileName $ getDenseNumber amount

createFile :: () -> IO ()
createFile () = persist 0

ensureFile :: () -> IO ()
ensureFile () =
  do
    fileName <- filePath
    fileExists <- doesFileExist fileName

    if not fileExists
      then createFile ()
      else
        ( do
            content <- S.readFile fileName

            if content == "" then createFile () else return ()
        )

loadAmount :: () -> IO BRL
loadAmount () =
  do
    fileName <- filePath
    amount <- readFile fileName
    let maybe = Money.denseFromDecimal Money.defaultDecimalConf $ pack amount
    case maybe of
      Just a -> return (a :: BRL)
      Nothing -> fail "Corrupted data"

data Operation = Sum | Minus

getOperator :: Operation -> (BRL -> BRL -> BRL)
getOperator operation =
  case operation of
    Sum -> (+)
    Minus -> (-)

operate :: Operation -> IO ()
operate operation =
  do
    putStrLn "Amount:"
    amount <-
      ( do
          raw <- getLine
          let maybeAmount =
                Money.denseFromDecimal Money.defaultDecimalConf $
                  pack raw
          case maybeAmount of
            Just a -> return (a :: BRL)
            Nothing -> fail "Invalid value!"
        )
    if amount <= (0 :: BRL)
      then return ()
      else
        ( do
            currentAmount <- loadAmount ()
            let operator = getOperator operation
            persist (operator currentAmount amount)
        )
