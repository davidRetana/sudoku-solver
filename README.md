# sudoku-solver
Sudoku solver written in Haskell

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RESOLUTOR DE SUDOKUS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

PREVIO:
	Para poder ejecutar codigo Haskell debemos tener instalado en nuestro
	ordenador bien sea el compilador GHC (Glasgow Haskell Compiler), o bien
	el interprete de Haskell llamado HUGS.
	Puedes bajarlos directamente desde los siguientes enlaces:
	GHC => https://www.haskell.org/ghc/
	Hugs => https://www.haskell.org/hugs/

	Si nuestro sistema es un UNIX, podemos hacerlo mediante la terminal con
	los sigientes comandos:
	UBUNTU => sudo apt-get install ghc6
	CENTOS => sudo yum install ghc6

	UBUNTU => sudo apt-get install hugs
	CENTOS => sudo tum install hugs

	Debemos tener los archivos main.hs y PracticaSudoku.hs en la misma carpeta.
	Los archivos de texto que contienen los sudokus a resolver deben estar 
	tambien en la misma carpeta que los archivos anteriores.

SI COMPILAMOS EL CODIGO:
	1.-Compilar el archivo main.hs en GHC y posteriormente ejecutarlo.
	Para compilar y obtener un a.out, debemos ejecutar el siguiente comando
	desde una terminal
	> ghc main.hs
	Echo esto, ejecutar el ejecutable generado con el siguiente comando:
	> ./a.out
	Una vez dentro del programa, elegir la opcion del menu mostrado.

	1.-(BIS) Compilar y obtener el ejecutable con otro nombre con la opción -o
	> ghc -o main main.hs
	Echo esto, ejecutar el ejecutable generado con el siguiente comando:
	> ./main.out

SI INTERPRETAMOS EL CODIGO:
	1.- Abrir el archivo main con el programa HUGS pinchando dos veces sobre el
	2.-Teclear "main" y pulsar enter.
  	2.1.- Al elegir la opcion de resolver el sudoku, nos pedira la direccion del archivo
        de texto donde lo tenemos guardado.

Nota: Los sudokus a resolver deben guardarse en un archivo de texto (yo utilizo .txt)
      poniendo ceros en las posiciones vacias y separando los numeros por espacios,
      separando las filas con "enter".

      Un ejemplo seria el siguiente:

      0 0 0 0 7 0 8 9 0
      0 0 9 0 0 8 0 6 4
      5 0 0 4 0 9 7 0 2
      0 0 7 0 4 0 0 2 0
      0 0 2 0 0 1 0 8 0
      8 4 0 0 2 7 0 5 0
      0 0 3 0 9 0 5 0 0
      0 7 0 0 8 6 0 0 9
      2 0 0 0 0 3 0 0 1

      La solución se guardara en un archivo de texto con el nombre de entrada seguido de
      Solucion, es decir, si nuestro archivo de entrada se llama sudoku1.txt, el archivo 
      que contendra la solucion se llamara sudoku1Solucion.txt

Se entregan unos ficheros de texto que contienen varios sudokus de distintos niveles de 
dificultad, se pueden cargar para comprobar que el programa los resuelve o puedes buscar
algun otro y crearte tu propio fichero de texto con el sudoku buscado.
