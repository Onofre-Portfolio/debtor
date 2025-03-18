module Persistance where 

import System.Directory (doesFileExist)
import Data.Function ((&))

fileName :: String
fileName = "./talisodiga.txt"

persist :: String -> IO () 
persist amount = writeFile fileName amount

createFile :: () -> IO () 
createFile () = persist "0.0"   

loadAmount :: () -> IO String 
loadAmount file = 
  do
    fileExists <- doesFileExist fileName

    if fileExists then readFile fileName else createFile () & \_ -> readFile fileName


