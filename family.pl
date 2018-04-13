:- dynamic visited/1.

man("Ahmed").
man("Khalid").
man("Moh").
man("Bander").

female("Asma").
female("Abeer").
female("Reem").
female("Amal").

parent("Ahmed","Khalid").
parent("Asma","Khalid").
parent("Moh","Ahmed").
parent("Abeer","Ahmed").
parent("Moh","Reem").
parent("Abeer","Reem").
parent("Ahmed","Amal").
parent("Asma","Amal").
parent("Reem","Bander").




child(X,Y):-
    parent(Y,X),!.


decendanent(X,Y):-
    child(X,Y),!.
decendanent(X,Y):-
    child(Z,Y),
    decendanent(X,Z).


sibling(X,Y):-
    parent(Z,X),
    parent(Z,Y),
    X\=Y.
ancestor(X,Y):-
    parent(X,Y).

ancestor(X,Y):-
    parent(Z,Y),
    ancestor(X,Z).

father(X,Y):-man(X),
    parent(X,Y),!.

mother(X,Y):-female(X),
    parent(X,Y),!.

brother(X,Y):-
    man(X),
    sibling(X,Y).

sister(X,Y):-
    female(X),
    sibling(X,Y).


	

related(X,X,_).

related(X,Y,Direction):-
	Direction>0,
    parent(Z,X),
    not(visited(Z)),
    assertz(visited(Z)),
    related(Z,Y,Direction).

 related(X,Y,Direction):-
  	
 	 parent(X,U),
  	not(visited(U)),
    assertz(visited(U)),
 	 related(U,Y,0). 


relatedCheck(X,Y):-
	retractall(visited(O)),
    related(X,Y,1).

grandparent(X,Y):-
	parent(Z,Y),
	parent(X,Z).

grandfather(X,Y):-
	man(X)
	,grandparent(X,Y).

grandmother(X,Y):-
	female(X),
	grandparent(X,Y).

cousin(X,Y):-
	parent(Z,X),
	sibling(Z,U),
	parent(U,Y).

auntOrUncle(X,Y):-
	parent(Z,Y),
	sibling(X,Z).

aunt(X,Y):-
	female(X),
	auntOrUncle(X,Y).

uncle(X,Y):-
	man(X),
	auntOrUncle(X,Y).
	
nieceOrNephew(X,Y):-
	parent(Z,Y),
	grandparent(Z,X).

niece(X,Y):-
	female(X),
	nieceOrNephew(X,Y).

nephew(X,Y):-
	man(X),
	nieceOrNephew(X,Y).


allAncestors(X,R):-
	findall(Y,ancestor(Y,X),R).

allSiblings(X,R):-
    findall(Y,sibling(X,Y),R).

allParents(X,R):-
    findall(Y,parent(Y,X),R).
allRelatives(X,R):-

	findall(Y,relatedCheck(Y,X),R).