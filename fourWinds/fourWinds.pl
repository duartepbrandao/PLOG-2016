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
	
	makeDomain(VARLIST,N2),
	
	lineControl(VARLIST,NUMLIST,1),
	
	colControl(VARLIST,NUMLIST,1),
	
	overPass(VARLIST,1,NUMLIST),
	
	nl,
	
	statistics(walltime, _), 	
	makeLabeling(VARLIST), 	
	statistics(walltime, [_, ElapsedTime | _]), 	
	format('An answer has been found!~nElapsed time: ~3d seconds', ElapsedTime),
	nl, fd_statistics, nl, nl,
	
	write('|###############|'), nl,
	write('| RESULT TABLE: |'), nl,
	write('|###############|'), nl, nl, nl,
	
	printboard(VARLIST), nl, nl, nl.
	
	
	
	


