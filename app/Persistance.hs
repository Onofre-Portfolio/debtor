{-# LANGUAGE DataKinds #-}
--{-# LANGUAGE TypeApplications #-}

module Persistance where 

import Data.Text (unpack, pack)
import System.Directory (doesFileExist)
import Data.Function ((&))
import qualified Money
import Text.Printf (printf)

type BRL = Money.Dense "BRL"

fileName :: String
fileName = "./talisodiga.txt"

getThirdWord :: [String] -> String 
getThirdWord [dense:currency:decimal] = decimal
getThirdWord _ = ""

getDenseNumber :: BRL -> String 
getDenseNumber dense = 
  unpack 
  $ Money.denseToDecimal Money.defaultDecimalConf Money.Round dense

persist :: BRL -> IO () 
persist amount = writeFile fileName $ getDenseNumber amount

createFile :: () -> IO () 
createFile () = persist 0

ensureFile :: () -> IO ()
ensureFile () = 
  do
    fileExists <- doesFileExist fileName 

    if not fileExists then createFile () else return ()

loadAmount :: () -> IO BRL
loadAmount () = 
  do
    amount <- readFile fileName
    let maybe = Money.denseFromDecimal Money.defaultDecimalConf $ pack amount 
    case maybe of 
      Just a -> return (a :: BRL)
      Nothing -> fail "Corrupted data"
