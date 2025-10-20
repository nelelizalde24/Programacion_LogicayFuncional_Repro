lista([1,2,3,4,5]).
sumar([],0).
sumar([X|Y],R):-sumar(Y,R1), R is R1 + X.

rotar(X,X,0).
rotar([X|Y],L,N):-N1 is N-1, append(Y,[X],Y1),rotar(Y1,L,N1).