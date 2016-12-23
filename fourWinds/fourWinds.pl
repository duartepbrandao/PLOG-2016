:- use_module(library(lists)).
:- use_module(library(clpfd)).

:- include('testTABS').
:- include('utility').
:- include('restrictions.pl').

fourWinds(TAB,VARLIST):-

	length(TAB,N1),
	
	makeTab(TAB,AUXTAB,N1,1),
	
	searchTAB(AUXTAB,NUMLIST,N1,1,1),
	makeVarTab(TAB,VARLIST,N1,1,1),
	
	length(NUMLIST,N2),
	
	write(NUMLIST),
	nl,
	
	makeDomain(VARLIST,N2),
	
	lineControl(VARLIST,NUMLIST,1),
	
	colControl(VARLIST,NUMLIST,1),
	
	overPass(VARLIST,1,NUMLIST),
	
	makeLabeling(VARLIST),
	
	printboard(VARLIST).
	
	
	
	


