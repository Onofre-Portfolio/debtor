module Main where

import Persistance
  ( Operation (..),
    ensureFile,
    getDenseNumber,
    loadAmount,
    operate,
  )
import System.Environment (getArgs)
import Text.Printf (printf)

tryParseCmd :: [String] -> Maybe String
tryParseCmd [cmd] = Just cmd
tryParseCmd _ = Nothing

main :: IO ()
main =
  do
    ensureFile ()
    args <- getArgs
    case tryParseCmd args of
      Just cmd ->
        case cmd of
          "see" ->
            do
              debt <- loadAmount ()
              printf "There is your debt: R$%s\n" $ getDenseNumber debt
          "add" ->
            do
              operate Sum
              newAmount <- loadAmount ()
              printf "Updated debt: R$%s\n" $ getDenseNumber newAmount
          "pay" ->
            do
              operate Minus
              newAmount <- loadAmount ()
              putStrLn "Good job you have paid a part!"
              printf "Updated debt: R$%s\n" $ getDenseNumber newAmount
          _ -> putStrLn "Invalid command! [print help]"
      Nothing -> putStrLn "Please, provide a command [print help]"
