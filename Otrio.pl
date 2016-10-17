:- use_module(library(lists)).

/**********GETS & SETS***********/



getCell(Line,Col,Pos,Tab,Cell) :- getPiece(Line,Col,Tab,Piece), getCol(Pos,Piece,Cell).

getPiece(Line,Col,Tab,Piece) :- getLine(Line, Tab, Linelist), 
									getCol(Col, Linelist, Piece).
									
getLine(1,[Line|_],Line).
getLine(Line,[_|Rest],Linelist) :- Line > 1,Newline is Line - 1,
									getLine(Newline,Rest,Linelist).
									
getCol(1, [Piece|_], Piece).
getCol(Col, [_|Linelist], Piece) :- Col > 1,Newcol is Col - 1, getCol(Newcol, Linelist, Piece).

setCol(1,[_|Rest],Piece,[Piece|Rest]).

setCol(Col,[H|Rest],Piece,[H|More]) :- Col > 1,Newcol is Col - 1, setCol(Newcol,Rest,Piece,More).

setPiece(Line,Col,Pos,Piece,Tab1,Tab2) :- getPiece(Line,Col,Tab1,Cell), setCol(Pos,Cell,Piece,NewCell), 
											getLine(Line,Tab1,Linelist), setCol(Col,Linelist,NewCell,NewLine),
											setCol(Line,Tab1,NewLine,Tab2).



/**********TABLE***********/



tab([[[b0,m0,s0],[b0,m0,s0],[b0,m0,s0]],
	 [[b0,m0,s0],[b0,m0,s0],[b0,m0,s0]],
	 [[b0,m0,s0],[b0,m0,s0],[b0,m0,s0]]
	]).

printboard([]):- !.
    
printboard([X|List]) :-
    write(X),nl,
    printboard(List).

	
list([' ',' ',' ']).

game:- tab(Board), printboard(Board).



/**********GAME FUNCTIONS***********/

test(A1,A2,Atomo) :- name(A1,[Char1]), name(A2,[Char2]), name(Atomo,[Char1,Char2]).

makePlay(Player, Size, Line, Col, Tab1, Tab2) :- Size == 'big', playBig(Player, Line, Col, Tab1, Tab2);
												 Size == 'medium', playMedium(Player, Line, Col, Tab1, Tab2);
												 Size == 'small', playSmall(Player, Line, Col, Tab1, Tab2).
												 

playBig(Player, Line, Col, Tab1, Tab2) :- getCell(Line,Col,1,Tab1,Cell), Cell == 'b0', test('b',Player,Piece), setPiece(Line,Col,1,Piece, Tab1, Tab2).
playMedium(Player, Line, Col, Tab1, Tab2) :- getCell(Line,Col,2,Tab1,Cell), Cell == 'm0', test('m',Player,Piece), setPiece(Line,Col,2,Piece, Tab1, Tab2).
playSmall(Player, Line, Col, Tab1, Tab2) :- getCell(Line,Col,3,Tab1,Cell), Cell == 's0', test('s',Player,Piece), setPiece(Line,Col,3,Piece, Tab1, Tab2).


