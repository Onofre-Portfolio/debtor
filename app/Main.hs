module Main where

import System.Environment (getArgs)
import Persistance (ensureFile, loadAmount, getDenseNumber)
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
          "add" -> putStrLn "Add to the debt"
          "pay" -> putStrLn "Good job you have paid a part."
          _ -> putStrLn "Invalid command! [print help]"
      Nothing -> putStrLn "Please, provide a command [print help]"
