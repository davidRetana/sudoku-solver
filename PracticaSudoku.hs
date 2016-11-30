
module PracticaSudoku (magic, printT) where
import Data.Array  -- cuando importamos Data.Array tmb importamos Data.Ix

type Sudoku = Array (Int,Int) Int

-- ******************************************************************************************************
-- magic en una funcion que dada una lista de enteros, hace las transformaciones 
-- necesarias para convertir la lista de enteros a un array bidimensional y 
-- posteriormente solucionarlo (llamando a la funcion solucion).
-- A continuacion, lo vuelve a transformar en una lista de enteros.

magic :: [Int] -> [Int]
magic s = elems $ head $ solucion sudoku
    where sudoku = inmediatos sudoku_prueba (assocs sudoku_prueba)
          sudoku_prueba = (listArray ((1,1),(9,9)) s)

-- ******************************************************************************************************

--borra un elemento de una lista (tantas veces como aparezca)	
borrar :: Int -> [Int] -> [Int]
borrar x s = [n | n <- s, n/=x]

-- diferencia la lista de valores [1..9] con la lista de enteros pasada
diferenciar :: [Int] -> [Int]
diferenciar xs = [x | x <- [1..9], not $ elem x xs]

--Dado un sudoku y una posicion devuelve los valores correspondientes
-- al cuadrante de dicha posicion
valores_cuadrante :: Sudoku -> (Int,Int) -> [Int]
valores_cuadrante sudoku (x,y)
    | x `mod` 3 == 0 = [sudoku ! (i,j) | i <- [x-2,x-1,x] , j <- auxiliar_cuadrante y]
    | x `mod` 3 == 2 = [sudoku ! (i,j) | i <- [x-1,x,x+1] , j <- auxiliar_cuadrante y]
    | otherwise = [sudoku ! (i,j) | i <- [x,x+1,x+2] , j <- auxiliar_cuadrante y]
    
auxiliar_cuadrante :: Int -> [Int]
auxiliar_cuadrante j
    | j `mod` 3 == 0 = [j-2,j-1,j]
    | j `mod` 3 == 2 = [j-1,j,j+1]
    | otherwise = [j,j+1,j+2]
    
--Dado un sudoku y una posicion devuelve los valores de la fila y la columna 
-- correspondiente a dicha posicion    
valores_fila_columna :: Sudoku -> (Int,Int) -> [Int]
valores_fila_columna sudoku (i,j) = [sudoku ! (i,x) | x<-[1..9]] ++ [sudoku ! (y,j) | y<-[1..9]]

--POSIBLES VALORES QUE PUEDEN IR EN UNA CASILLA DADA
--junta los valores de la fila, la columna y el cuadrante y los diferencia de [1..9]
posibles_valores :: Sudoku -> (Int,Int) ->[Int]
posibles_valores sudoku posicion = diferenciar $ (valores_cuadrante sudoku posicion) ++ (valores_fila_columna sudoku posicion)
          
--dado un sudoku y (assocs sudoku) devuelve ese mismo sudoku insertando todos
-- aquellos valores que sean inmediatos (es decir, si en una casilla solo cabe un
-- numero, pues lo inserta) (lo hace recursivamente).
inmediatos :: Sudoku -> [((Int,Int),Int)] -> Sudoku
inmediatos sudoku [] = sudoku  --ya no hay mas valores inmediatos que poner
inmediatos sudoku (y:ys)
    | (x == 0) && (length z == 1) = inmediatos sudoku' (assocs sudoku') --llamada recursiva (vuelta a empezar)
    | otherwise = inmediatos sudoku ys
    where x = snd y -- valor de la casilla correspondiente
          z = posibles_valores sudoku (fst y) --solo me interesa si es un solo elemento
          sudoku' = (sudoku // [((fst y),head z)]) --actualizo el sudoku con el valor en la casilla correspondiente

--funcion buena de posiciones vacias (con los valores posibles incorporados)
posicionesVacias :: Sudoku -> [((Int,Int),Int)] -> [((Int,Int),[Int])]
posicionesVacias sudoku s = [(fst x, posibles_valores sudoku (fst x)) | x<-s, (snd x == 0)]

--ordena las posiciones segun los valores que caben en ellas (de menor a mayor)
quicksort :: [((Int,Int),[Int])] -> [((Int,Int),[Int])]
quicksort [] = []
quicksort (x:xs) = quicksort [y | y<-xs, (length $ snd y) < (length $ snd x)] ++ [x] ++ quicksort [y | y<-xs, (length $ snd y) >= (length $ snd x)]

{-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%% FUNCION SOLUCION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-}

solucion :: Sudoku -> [Sudoku]
solucion sudoku
    | null variable = [sudoku] --Hemos acabado, tenemos el sudoku solucion (no hay posiciones vacias)
    | null valores = [] --no hay valores posibles para una casilla ==> camino equivocado, vuelta atras
    | otherwise = concat $ map solucion $ newSudokus sudoku posicion valores  --probamos en la casilla cada valor posible
    where (posicion,valores) = head variable
          variable = quicksort $ posicionesVacias sudoku (assocs sudoku)
		   
-- Dado un sudoku, una posicion, y los posibles valores para esa posicion, la funcion devuelve una lista con tantos sudokus como elementos tenga la lista
-- de valores dada. Va insertando cada valor de la lista en la posicion del sudoku que le hemos dado
newSudokus :: Sudoku -> (Int,Int) -> [Int] -> [Sudoku]
newSudokus sudoku posicion s = [ (sudoku // [(posicion,x)]) | x<-s]

{-%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% FUNCION PARA MOSTRAR POR PANTALLA %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%-}

-- funcion que dada una lista de char's (un string) devuelve esa misma lista de char's pero añadiendo un salto de linea cada 9 numeros
-- (se inserta el salto de linea cada 18 char's porque tambien se cuentas los espacios entre numeros).
printT :: [Char] -> [Char]
printT [] = []
printT s = ((take 18 s) ++ "\n") ++ (printT $ drop 18 s)
