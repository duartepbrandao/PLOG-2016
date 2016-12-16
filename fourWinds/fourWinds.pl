:- use_module(library(lists)).
:- use_module(library(clpfd)).

:- include('testTABS').
:- include('utility').

fourWinds(TAB,RESULT):-

	length(TAB,N),
	lineLength(TAB,N),
	
	length(RESULT,N),
	lineLength(RESULT,N).
	


