lista([1,2,3,4,5]).
sumar([],0).
sumar([X|Y],R):-sumar(Y,R1), R is R1 + X.

rotar(X,X,0).
rotar([X|Y],L,N):-N1 is N-1, append(Y,[X],Y1),rotar(Y1,L,N1).


cabeza_cola([C|T],C,T).


pertenece(X, T):- member(X, T).

longitud([],0).
longitud([X|Y],N):- longitud(Y,N1), N is N1+1.

concatenar(X, Y, R):- append(X,Y,R).