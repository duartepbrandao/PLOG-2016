:- use_module(library(lists)).

/********LENGTH**********/	
	
lineLength([H|_],N):-
	
	length(H,N).
	
linesLength([H|R],N).


/********GETS_SETS**********/

getLine(1,[Line|_],Line).
getLine(Line,[_|Rest],Linelist) :- Line > 1,Newline is Line - 1,
									getLine(Newline,Rest,Linelist).
									
getCol(1, [Piece|_], Piece).
getCol(Col, [_|Linelist], Piece) :- Col > 1,Newcol is Col - 1, getCol(Newcol, Linelist, Piece).

getPosition(TAB, X, Y, N):- getLine(Y, TAB, Line), getCol(X, Line, N).


/**********MAKE_TAB**********/

setCell(0,H):- H = A.
setCell(Value,H):- H = Value.

makeList(TAB,[H|R],N,X,Y):-  
							  getPosition(TAB,X,Y,Cell), 
							  setCell(Cell,H), 
							  NewX = X+1,
							  makeList(TAB,R,N,NewX,Y).
							  
makeList(TAB,[H|R],N,N,Y):- 
							  getPosition(TAB,N,Y,Cell), 
							  setCell(Cell,H).

makeList(_,[],_,_,_).


makeTab(TAB,[H],N,N):-	  
							  makeList(TAB,List,N,1,N),
							  H = List.
							  
makeTab(TAB,[H|R],N,Y):- 
							  makeList(TAB,List,N,1,Y),
							  H = List,
							  NewY is Y+1,
							  makeTab(TAB,R,N,NewY).

makeTab(_,[],_,_).

printboard([]):- nl,!.
 
printboard([X|List]) :-
write('|'),
	printLine(X),nl,
    printboard(List).
	
printLine([])	:-!.
printLine([0|List])	:-
write(' '),write('|'),printLine(List).
printLine([X|List])	:-
write(X),write('|'),printLine(List).


printResult([]):- nl,!.
printResult([X|List]):-
write('|'),
	printLineResult(X),nl,
    printResult(List).

	
%LEFT -1,UP -2, RIGHT -3, DOWN -4.
printLineResult([]):-!.
printLineResult([X|List]):-
(X = -1,write('<');
X = -2,write('^');
X = -3,write('>');
X = -4,write('v');
write(X)),
write('|'),
printLineResult(List).
	