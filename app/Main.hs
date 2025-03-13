module Main where

main :: IO ()
main =
  do
    command <- getLine
    case command of 
      "add" -> putStrLn "Add to the debt"
      "pay" -> putStrLn "Good job you have paid a part."
      _ -> putStrLn "Invalid command! [print help]"
