:- include('utility').

lineControl(VARLIST,[N-X-Y|R],Index):- 
		getLine(Y,VARLIST, Line), getCol(X,VARLIST, Col), 
		count(Index, Line, #=, LineAppearances), 
		count(Index, Col, #=, ColAppearances), 
		LineAppearances #= N + 2 - ColAppearances, 
		NewIndex is Index + 1,
		lineControl(VARLIST,R,NewIndex).
			
lineControl(_,[],_).
			
colControl(VARLIST,[N-X-Y|R],Index):- 
		getLine(Y,VARLIST, Line), getCol(X,VARLIST, Col), 
		count(Index, Line, #=, LineAppearances), 
		count(Index, Col, #=, ColAppearances), 
		ColAppearances #= N + 2 - LineAppearances, 
		NewIndex is Index + 1,
		colControl(VARLIST,R,NewIndex).
		
colControl(_,[],_).