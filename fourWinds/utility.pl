:- use_module(library(lists)).
:- use_module(library(clpfd)).
:- use_module(library(restrictions)).

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

getfullCol([H1|R1], X,[H2|R2]):- getCol(X, H1, H2), getfullCol(R1, X, R2).
getfullCol([],_,[]).


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


setVar(0,H,Counter,NewCounter):- H = A, NewCounter is Counter.
setVar(_,H,Counter,NewCounter):- H = Counter, NewCounter is Counter+1.

makeVarList(TAB,[H],N,N,Y,Counter,NewCounter):- 
							  getPosition(TAB,N,Y,Cell), 
							  setVar(Cell,H,Counter,NewCounter).

makeVarList(TAB,[H|R],N,X,Y,Counter,NewCounter):-  
							  getPosition(TAB,X,Y,Cell), 
							  setVar(Cell,H,Counter,NextCounter), 
							  NewX is X+1,
							  makeVarList(TAB,R,N,NewX,Y,NextCounter,NewCounter).
							 							  
makeVarList(_,[],_,_,_,_,_).

makeVarTab(TAB,[H],N,N,Counter):-	  
							  makeVarList(TAB,List,N,1,N,Counter,NewCounter),
							  H = List.
							  
makeVarTab(TAB,[H|R],N,Y,Counter):- 	
							  makeVarList(TAB,List,N,1,Y,Counter,NewCounter),
							  H = List,
							  NewY is Y+1,
							  makeVarTab(TAB,R,N,NewY,NewCounter).

makeVarTab(_,[],_,_,_).

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


searchTAB(TAB,[H],N,N,N):-  
							  getPosition(TAB,N,N,Cell), 
							  checkCell(Cell,N,N,H).							
							  
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

/***********MAKE_DOMAIN************/

makeDomain([H|R],N):- domain(H,1,N), makeDomain(R,N).

makeDomain([],_).

makeLabeling([H|R]):- labeling([],H), makeLabeling(R).

makeLabeling([]).

/***********OVERPASS_CONTROL***********/

overPass(VarList,N,[_-X-Y|R]):- 	
									getLine(Y,VarList,Line), 
									getfullCol(VarList,X,Col),
									%write(N),
									%nl,
									%write(Line),
									%nl,
									%write(Col),
									%nl,
									controlOverpass(Line,N,X,1),
									controlOverpass(Col,N,Y,1),
									%write('Here3'),
									NewN is N + 1,
									overPass(VarList,NewN,R).

overPass(_,_,[]).