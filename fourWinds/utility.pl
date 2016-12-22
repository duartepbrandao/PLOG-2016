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

/************MAKE_VARTAB**************/

setVar(0,H,_,_):- H = A.
%setVar(_,H,1,NewCounter):- H = Counter, NewCounter is Counter+1.
setVar(_,H,Counter,NewCounter):- H = Counter, NewCounter is Counter+1.

makeVarList(TAB,[H|R],N,X,Y,Counter,NextCounter):-  
							  getPosition(TAB,X,Y,Cell), 
							  setVar(Cell,H,Counter,NewCounter), 
							  NewX is X+1,
							  makeVarList(TAB,R,N,NewX,Y,NewCounter,NewCounter).
							  
makeVarList(TAB,[H|R],N,N,Y,Counter,NextCounter):- 
							  getPosition(TAB,N,Y,Cell), 
							  setVar(Cell,H,Counter,NextCounter).

makeVarList(_,[],_,_,_,_,_).


makeVarTab(TAB,[H],N,N,Counter):-	  
							  makeVarList(TAB,List,N,1,N,Counter,NewCounter),
							  H = List.
							  
makeVarTab(TAB,[H|R],N,Y,Counter):- 
trace,	
							  makeVarList(TAB,List,N,1,Y,Counter,NewCounter),
							  H = List,
							  NewY is Y+1,
							  makeVarTab(TAB,R,N,NewY,NewCounter).

makeVarTab(_,[],_,_).

/************DRAW_TAB**************/

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
	
/**********POS_LIST***********/

%Cell = Number, X = XCoord, Y = YCoord.
checkCell(Cell,X,Y,H):- integer(Cell), H = Cell-X-Y.

checkCell(_,_,_,_).


searchTAB(TAB,[H|R],N,N,N):-  
							  getPosition(TAB,N,N,Cell), 
							  integer(Cell), H = Cell-N-N.
							  
searchTAB(TAB,[H|R],N,N,N).
							
							  
searchTAB(TAB,[H|R],N,N,Y):-  
							  getPosition(TAB,N,Y,Cell),
							  checkCell(Cell,N,Y,H),
							  NewY is Y+1,
							  (var(H), 
							  searchTAB(TAB,[H|R],N,1,NewY);
						      searchTAB(TAB,R,N,1,NewY)).
							  
searchTAB(TAB,[H|R],N,X,Y):-  
							  getPosition(TAB,X,Y,Cell),
							  checkCell(Cell,X,Y,H),
							  NewX is X+1,
							  (var(H), 
							  searchTAB(TAB,[H|R],N,NewX,Y);
							  searchTAB(TAB,R,N,NewX,Y)).

searchTAB(_,[],_,_,_).