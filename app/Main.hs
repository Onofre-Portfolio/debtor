module Main where

import Persistence
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

showHelp :: () -> IO ()
showHelp () =
  putStrLn
    ( "\nUsage:\n"
        ++ "[<Executable>] <command>\n"
        ++ "  see -- Check the current debt\n"
        ++ "  add -- Increase the debt\n"
        ++ "  pay -- Pay a part, or total, of the debt\n"
        ++ "  h   -- Print this menu"
    )

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
          "h" -> showHelp ()
          _ -> putStrLn "Invalid command!" >> showHelp ()
      Nothing -> putStrLn "Please, provide a command!" >> showHelp ()
