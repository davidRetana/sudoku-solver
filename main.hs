
{-******************************************************************************************************
                                     MENU PRINCIPAL
******************************************************************************************************-}

import PracticaSudoku --asi importamos las funciones magic y printT

menu :: IO()
menu = do putStrLn "\nDime el nombre del fichero de entrada: "
          nombreIn <- getLine
          contenido <- readFile nombreIn --contenido del fichero en un string
          let palabras :: [String]
              palabras = words contenido
              sudoku :: [Int]
              sudoku = map read palabras
              nombre = fst $ span (/='.') nombreIn --para luego el fichero de salida
              solucionSudoku = magic sudoku
              imprimir = printT $ unwords $ map show solucionSudoku
          putStrLn $ ['\n'] ++ imprimir
          writeFile (nombre ++ "Solucion.txt") imprimir
          putStrLn "La solucion se ha guardado en un archivo de texto."
          menuInsiste

menuInsiste :: IO()        
menuInsiste = do putStrLn stringMenu
                 opcion <- getLine
                 if opcion == "1" then menu else putStrLn stringDespedida

main :: IO()
main = menuInsiste

stringMenu :: String
stringMenu = "\n1.-Cargar y resolver un Sudoku\n2.-Salir\nElegir: "

stringDespedida :: String
stringDespedida = "\n**************************************\n-Adios\n-David Retana Ribeiro\n-Facultad de Ciencias Matematicas (UCM)\n-Enero-2016\n *************************************"
