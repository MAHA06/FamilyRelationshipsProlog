man("John").
man("Mike").
man("Snoop").
female("Ana").
female("Betty").
female("Betty").
female("Doe").
female("Lizzy").
parent("Ana","John").
parent("Ana","Betty").
parent("Ana","Mike").
parent("Mike","Snoop").

parent("Doe","Lizzy").
parent("Lizzy","Snoop").
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

related(X,Y,Level):-
    parent(Z,X),
      NewLevel is Level+1,
    related(Z,X,NewLevel).

related(X,Y,Level):-
  Level>1,
  parent(X,U),
  NewLevel is Level-1,
  related(U,Y,NewLevel).  

related(X,Y):-
    related(X,Y,1);related(Y,X,1),!.


allSiblings(X,R):-
    findall(Y,sibling(X,Y),R).
allParents(X,R):-
    findall(Y,parent(Y,X),R).