:- use_module(library(lists)).

/**********GETS & SETS***********/



getCell(Line,Col,Pos,Tab,Cell) :- getPiece(Line,Col,Tab,Piece), getCol(Pos,Piece,Cell).

getPiece(Line,Col,Tab,Piece) :- getLine(Line, Tab, Linelist), 
									getCol(Col, Linelist, Piece),!.
									
getLine(1,[Line|_],Line).
getLine(Line,[_|Rest],Linelist) :- Line > 1,Newline is Line - 1,
									getLine(Newline,Rest,Linelist).
									
setLine(1,[_|Rest],Piece,[Piece|Rest]).
setLine(Line,[H|Rest],Piece,[H|More]) :- Line > 1, Newline is Line - 1,
										setLine(Newline,Rest,Piece,More),!.
									
									
getCol(1, [Piece|_], Piece).
getCol(Col, [_|Linelist], Piece) :- Col > 1,Newcol is Col - 1, getCol(Newcol, Linelist, Piece).

setCol(1,[_|Rest],Piece,[Piece|Rest]).

setCol(Col,[H|Rest],Piece,[H|More]) :- Col > 1,Newcol is Col - 1, setCol(Newcol,Rest,Piece,More).

setPiece(Line,Col,Pos,Piece,Tab1,Tab2) :- getPiece(Line,Col,Tab1,Cell), setCol(Pos,Cell,Piece,NewCell), 
											getLine(Line,Tab1,Linelist), setCol(Col,Linelist,NewCell,NewLine),
											setCol(Line,Tab1,NewLine,Tab2).
setHand(Line,Col,Piece,Hand1,Hand2) :- getLine(Line,Hand1,Cell), setCol(Col,Cell,Piece,Hand3),
										setCol(Line,Hand1,Hand3,Hand2).



/**********TABLE***********/



tab([[[b0,m0,s0],[b1,m0,s0],[b0,m0,s0]],
	 [[b1,m0,s0],[b1,m0,s0],[b0,m0,s0]],
	 [[b0,m0,s0],[b0,m0,s0],[b0,m0,s0]]
	]).

printboard([]):- !.
    
printboard([X|List]) :-
    write(X),nl,
    printboard(List).

	
list([' ',' ',' ']).

game:- tab(Board), hand(Hand1),/*escolher modo de jogo*/ /*Escolher nr jogadores (NrPlayers) */ gamecycle(Board,Hand1,1,2).

gamecycle(Board, Hand, CurrentPlayer, NrPlayers) :-
printboard(Board),
/* print hand */

choosePiece(CurrentPlayer, Size),
choosePos(CurrentPlayer, Line, Col),
makePlay(CurrentPlayer, Size, Col, Line, Hand, NewHand,Board,NewBoard),
(

   checkWin(CurrentPlayer, Size, NewBoard, Col, Line);
   (

/* verificar ganhou*/

/* senao change Player */
   changePlayer(CurrentPlayer,NewCurrentPlayer,NrPlayers),
   gamecycle(NewBoard, NewHand, NewCurrentPlayer, NrPlayers)
  )
).





changePlayer(CurrentPlayer,1, CurrentPlayer).
changePlayer(CurrentPlayer, NewCurrentPlayer, NrPlayers):-
NewCurrentPlayer is CurrentPlayer + 1.


choosePiece(CurrentPlayer, Size):-
nl,
write('Player '),
write(CurrentPlayer),
write(', choose the size of the piece:(big,medium or small)'),
nl,
	read(Size).

choosePos(CurrentPlayer, Line, Col):-
nl,
write('Player '),
write(CurrentPlayer),
write(', choose the position of the piece:(x-y)'),
nl,
read(Line-Col).




/**********ITEMS**********/

hand([[3,3,3],[3,3,3],[3,3,3],[3,3,3]]).
/*winCond(Player, List)*/
winCondLocal(1, [b1,m1,s1]).
winCondLocal(2, [b2,m2,s2]).
winCondLocal(3, [b3,m3,s3]).
winCondLocal(4, [b4,m4,s4]).

winCond(1, 'big', [b1,_,_]).
winCond(2, 'big', [b2,_,_]).
winCond(3, 'big', [b3,_,_]).
winCond(4, 'big', [b4,_,_]).
winCond(1, 'medium', [_,m1,_]).
winCond(2, 'medium', [_,m2,_]).
winCond(3, 'medium', [_,m3,_]).
winCond(4, 'medium', [_,m4,_]).
winCond(1, 'small', [_,_,s1]).
winCond(2, 'small', [_,_,s2]).
winCond(3, 'small', [_,_,s3]).
winCond(4, 'small', [_,_,s4]).

winner(Player):-  nl, write('Player '), write(Player), write(' Won!!'), nl.

/**********GAME FUNCTIONS***********/

jointname(A1,A2,Atomo) :- name(A1,[Char1]), name(A2,[Char2]), name(Atomo,[Char1,Char2]).

makePlay(Player, Size, Line, Col, Hand1, Hand2, Tab1, Tab2) :- Size == 'big', checkHand(Player, 1,Hand1,Hand2), playBig(Player, Line, Col, Tab1, Tab2);
												 Size == 'medium', checkHand(Player, 2,Hand1,Hand2), playMedium(Player, Line, Col, Tab1, Tab2);
												 Size == 'small', checkHand(Player, 3,Hand1,Hand2), playSmall(Player, Line, Col, Tab1, Tab2).

checkHand(Player, Size, Hand1, Hand2) :-  getPiece(Player, Size, Hand1, Value), \+(Value = 0), NewValue is Value - 1, setHand(Player, Size, NewValue, Hand1, Hand2).

/*checkHand(Player, Size, Hand1, Hand2) :-  getCol(Player, Hand1, PlayerHand), getCol(Size, PlayerHand, Value), \+(Value = 0), newValue is Value - 1, setCol()*/	
										  
playBig(Player, Line, Col, Tab1, Tab2) :- getCell(Line,Col,1,Tab1,Cell), Cell == 'b0', jointname('b',Player,Piece), setPiece(Line,Col,1,Piece, Tab1, Tab2).
playMedium(Player, Line, Col, Tab1, Tab2) :- getCell(Line,Col,2,Tab1,Cell), Cell == 'm0', jointname('m',Player,Piece), setPiece(Line,Col,2,Piece, Tab1, Tab2).
playSmall(Player, Line, Col, Tab1, Tab2) :- getCell(Line,Col,3,Tab1,Cell), Cell == 's0', jointname('s',Player,Piece), setPiece(Line,Col,3,Piece, Tab1, Tab2).

checkWin(Player, Size, Tab, Line, Col):- (checkLocalWin(Player, Tab, Line, Col),  winner(Player);
										 checkLineWin(Player, Size, Tab, 1), winner(Player);
										 checkColWin(Player, Size, Tab, 1), winner(Player)),!.


checkLocalWin(Player, Tab, Line, Col):- (getPiece(Line, Col, Tab, Cell), winCondLocal(Player, A), Cell == A).
										

checkLineWin(Player, Size, Tab, Line):- Line < 3,
										getPiece(Line, 1, Tab, Cell1),
										getPiece(Line, 2, Tab, Cell2),
										getPiece(Line, 3, Tab, Cell3), 
										winCond(Player, Size, A), 
										(Cell1 == A, Cell2 == A, Cell3 == A;
										NewLine is Line + 1, checkLineWin(Player, Size, Tab, NewLine)).

checkLineWin(Player, Size, Tab, 3):- getPiece(Line, 1, Tab, Cell1), 
									 getPiece(Line, 2, Tab, Cell2),
									 getPiece(Line, 3, Tab, Cell3),
									 winCond(Player, Size, A), (Cell1 == A, Cell2 == A, Cell3 == A).
									 
checkColWin(Player, Size, Tab, Col):- Col < 3, 
									  getPiece(NewLine0, 1, Tab, Cell1), 
									  getPiece(NewLine1, 2, Tab, Cell2),
									  getPiece(NewLine2, 3, Tab, Cell3), 
									  winCond(Player, Size, A),
									  (Cell1 == A, Cell2 == A, Cell3 == A;
									  NewCol is Col + 1, checkLineWin(Player, Size, Tab, NewCol)).
									  
checkColWin(Player, Size, Tab, 3):- getPiece(1, Col, Tab, Cell1), 
									getPiece(2, Col, Tab, Cell2), 
									getPiece(3, Col, Tab, Cell3), 
									winCond(Player, Size, A),
									(Cell1 == A, Cell2 == A, Cell3 == A).
									 
									

/*********** WIN CONS************/
