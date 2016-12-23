:- include('utility').

lineControl(VARLIST,[N-X-Y|R],Index):- 
		getLine(Y,VARLIST, Line), getfullCol(VARLIST, X, Col), 
		count(Index, Line, #=, LineAppearances), 
		count(Index, Col, #=, ColAppearances), 
		LineAppearances #= N + 2 - ColAppearances, 
		NewIndex is Index + 1,
		lineControl(VARLIST,R,NewIndex).
			
lineControl(_,[],_).
			
colControl(VARLIST,[N-X-Y|R],Index):- 
		getLine(Y,VARLIST, Line), getfullCol(VARLIST, X, Col), 
		count(Index, Line, #=, LineAppearances), 
		count(Index, Col, #=, ColAppearances), 
		ColAppearances #= N + 2 - LineAppearances, 
		NewIndex is Index + 1,
		colControl(VARLIST,R,NewIndex).
		
colControl(_,[],_).

/***********OVERPASS_CONTROL**************/
/*
controlLineOverpass(Line,Index,X,X):-
		NewX is X + 1,
		controlLineOverpass(Line,Index,X,NewX).

controlLineOverpass(Line,Index,X,AltX):-
		AltX < X,
		getCol(AltX,Line,Cell),
		NewAltX is AltX + 1,
		getCol(NewAltX,Line,NewCell),
		(NewCell #= Index #/\ Cell #= Index) #\/ (Cell #\= Index),
		controlLineOverpass(Line,Index,X,NewAltX).
		
controlLineOverpass(Line,Index,X,AltX):-
		AltX > X,
		getCol(AltX,Line,Cell),
		NewAltX is AltX - 1,
		getCol(NewAltX,Line,NewCell),
		(NewCell #= Index #/\ Cell #= Index) #\/ (Cell #\= Index),
		NewNewAltX is AltX + 1,
		controlLineOverpass(Line,Index,X,NewNewAltX).
		
controlLineOverpass(Line,_,_,AltX):- length(Line,N), AltX > N.

controlColOverpass(Col,Index,Y,Y):-
		NewY is Y + 1,
		controlColOverpass(Col,Index,Y,NewY).
	
controlColOverpass(Col,Index,Y,AltY):-
		AltY < Y,
		getCol(AltY,Col,Cell),
		NewAltY is AltY + 1,
		getCol(NewAltY,Col,NewCell),
		(NewCell #= Index #/\ Cell #= Index) #\/ (Cell #\= Index),
		controlColOverpass(Col,Index,Y,NewAltY).
		
controlColOverpass(Col,Index,Y,AltY):-
		AltY > Y,
		getCol(AltY,Col,Cell),
		NewAltY is AltY - 1,
		getCol(NewAltY,Col,NewCell),
		(NewCell #= Index #/\ Cell #= Index) #\/ (Cell #\= Index),
		NewNewAltY is AltY + 1,
		controlColOverpass(Col,Index,Y,NewNewAltY).
		
controlColOverpass(Col,_,_,AltY):- length(Col,N), AltY > N.
*/
controlOverpass(Col,Index,Point,Point):-
		NewPoint is Point + 1,
		controlOverpass(Col,Index,Point,NewPoint).
	
controlOverpass(Col,Index,Point,AltPoint):-
		AltPoint < Point,
		getCol(AltPoint,Col,Cell),
		NewAltPoint is AltPoint + 1,
		getCol(NewAltPoint,Col,NewCell),
		(NewCell #= Index #/\ Cell #= Index) #\/ (Cell #\= Index),
		controlOverpass(Col,Index,Point,NewAltPoint).
		
controlOverpass(Col,Index,Point,AltPoint):-
		AltPoint > Point,
		getCol(AltPoint,Col,Cell),
		NewAltPoint is AltPoint - 1,
		getCol(NewAltPoint,Col,NewCell),
		(NewCell #= Index #/\ Cell #= Index) #\/ (Cell #\= Index),
		NewNewAltPoint is AltPoint + 1,
		controlOverpass(Col,Index,Point,NewNewAltPoint).
		
controlOverpass(Col,_,_,AltPoint):- length(Col,N), AltPoint > N.