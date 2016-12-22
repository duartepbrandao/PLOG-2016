:- use_module(library(lists)).
:- use_module(library(clpfd)).

:- include('testTABS').
:- include('utility').
:- include('restrictions.pl').

fourWinds(TAB,VARLIST):-

	length(TAB,N1),
	
	makeTab(TAB,AUXTAB,N1,1),
	
	searchTAB(AUXTAB,NUMLIST,VARLIST,N1,1,1),
	
	length(VARLIST,N2),
	
	domain(VARLIST,1,N2),
	
	lineControl(TAB,NUMLIST,1),
	
	colControl(TAB,NUMLIST,1),
	
	labeling([],VARLIST).
	
	
	
	


