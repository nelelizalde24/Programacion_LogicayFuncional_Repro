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


invertir([], []).
invertir([X|T], R) :- invertir(T, RT), append(RT, [X], R).


ultimo([X], X).
ultimo([_|T], X) :-ultimo(T, X).


suma_lista([], 0).
suma_lista([X|T], S) :-suma_lista(T, ST),S is X + ST.


eliminar(X, [X|T], T).
eliminar(X, [Y|T], [Y|R]) :- X \= Y, eliminar(X, T, R).


duplicar([], []).
duplicar([X|T], [X,X|R]) :- duplicar(T, R).


intercalar([], L, L).
intercalar(L, [], L).
intercalar([X|Xs], [Y|Ys], [X,Y|R]) :- intercalar(Xs, Ys, R).