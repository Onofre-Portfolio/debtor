module Main where

import System.Environment (getArgs)

tryParseCmd :: [String] -> Maybe String
tryParseCmd [cmd] = Just cmd
tryParseCmd _ = Nothing

main :: IO ()
main =
  do
    args <- getArgs
    case tryParseCmd args of
      Just cmd ->
        case cmd of
          "add" -> putStrLn "Add to the debt"
          "pay" -> putStrLn "Good job you have paid a part."
          _ -> putStrLn "Invalid command! [print help]"
      Nothing -> putStrLn "Please, provide a command [print help]"
