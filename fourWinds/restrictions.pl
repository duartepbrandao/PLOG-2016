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

controlLineOverpass(Line,Index,X,X):-
		NewX is X + 1,
		controlLineOverpass(Line,Index,X,NewX).

controlLineOverpass(Line,Index,X,AltX):-
		AltX < X,
		getCol(AltX,Line,Cell),
		NewAltX is AltX + 1,
		getCol(NewAltX,Line,NewCell),
		(NewCell #= Index #/\ Cell #= Index) #\/ (Cell #\= Index),
		controlLine(Line,Index,X,NewAltX).
		
controlLineOverpass(Line,Index,X,AltX):-
		AltX > X,
		getCol(AltX,Line,Cell),
		NewAltX is AltX - 1,
		getCol(NewAltX,Line,NewCell),
		(NewCell #= Index #/\ Cell #= Index) #\/ (Cell #\= Index),
		NewNewAltX is AltX + 1,
		controlLine(Line,Index,X,NewAltX).
		
controlLineOverpass(Line,_,_,AltX):- length(Line,N), AltX > N.

controlColOverpass(Col,Index,X,X):-
		NewX is X + 1,
		controlColOverpass(Col,Index,X,NewX).
		
controlColOverpass(Col,Index,X,AltX):-
		AltX < X,
		getCol(AltX,Col,Cell),
		NewAltX is AltX + 1,
		getCol(NewAltX,Col,NewCell),
		(NewCell #= Index #/\ Cell #= Index) #\/ (Cell #\= Index),
		controlLine(Col,Index,X,NewAltX).
		
controlColOverpass(Col,Index,X,AltX):-
		AltX > X,
		getCol(AltX,Col,Cell),
		NewAltX is AltX - 1,
		getCol(NewAltX,Col,NewCell),
		(NewCell #= Index #/\ Cell #= Index) #\/ (Cell #\= Index),
		NewNewAltX is AltX + 1,
		controlLine(Col,Index,X,NewAltX).
		
controlColOverpass(Col,_,_,AltX):- length(Col,N), AltX > N.