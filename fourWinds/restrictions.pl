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