{-# LANGUAGE DataKinds #-}
--{-# LANGUAGE TypeApplications #-}

module Persistance where 

import System.Directory (doesFileExist)
import Data.Function ((&))
import qualified Money

type BRL = Money.Dense "BRL"

fileName :: String
fileName = "./talisodiga.txt"

persist :: BRL -> IO () 
persist amount = writeFile fileName (show amount)

createFile :: () -> IO () 
createFile () = persist 0

ensureFile :: () -> IO ()
ensureFile () = 
  do
    fileExists <- doesFileExist fileName 

    if (not fileExists) then createFile () else return ()

--loadAmount :: () -> BRL
--loadAmount file = 
--  do
--    fileExists <- doesFileExist fileName
--
--    if fileExists 
--       then 
--        do 
--          amount <- readFile fileName
--          Money.denseFromDecimal Money.decimalConf_digits $ read amount
--       else 
--        do 
--          amount <- readFile fileName
--          createFile () & \_ -> Money.denseFromDecimal Money.decimalConf_digits $ read amount

--increaseAmount :: BRL -> () 
--increaseAmount invoice =
--  do
--    if invoice <= 0 
--       then ()
--       else 
--        do
--          currentAmount <- loadAmount () 
--        
--          let newAmount = invoice + currentAmount
--          persist newAmount
