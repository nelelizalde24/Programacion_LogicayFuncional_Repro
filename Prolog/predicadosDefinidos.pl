% predicadosDefinidos.pl
% Implementaciones simples de predicados Prolog comunes.
% Contiene: nth0/3, select/3, append/3, member/2, length/2,
% reverse/2, last/2, delete/3, prefix/2, flatten/2
%
% Cada predicado incluye una implementación educativa y ejemplos de uso
% como comentarios (consultas que puedes ejecutar en SWI-Prolog).

% nth0(Index, List, Elem)
% Índice 0-based: Elem es el elemento en la posición Index de List.
nth0(0, [H|_], H) :- !.
nth0(N, [_|T], E) :-
	N > 0,
	N1 is N - 1,
	nth0(N1, T, E).

% Ejemplo:
% ?- nth0(2, [a,b,c], X).  % X = c

% select(Elem, List, Rest)
% Succeeds si Rest es la lista resultante de quitar la primera ocurrencia
% de Elem de List.
select(E, [E|T], T).
select(E, [H|T], [H|R]) :-
	select(E, T, R).

% Ejemplo:
% ?- select(b, [a,b,c], R).  % R = [a,c]

% append(List1, List2, Result)
% Concatenación de listas.
append([], L, L).
append([H|T], L, [H|R]) :-
	append(T, L, R).

% Ejemplo:
% ?- append([1],[2],X). % X = [1,2]

% member(Elem, List)
% Verdadero si Elem aparece en List (al menos una vez).
member(E, [E|_]) :- !.
member(E, [_|T]) :-
	member(E, T).

% Ejemplo:
% ?- member(2, [1,2]). % true

% length(List, Len)
% Calcula la longitud de una lista.
length([], 0).
length([_|T], N) :-
	length(T, N1),
	N is N1 + 1.

% Ejemplo:
% ?- length([a,b],N). % N = 2

% reverse(List, Reversed)
% Invierte una lista (implementación simple, no optimizada).
reverse([], []).
reverse([H|T], R) :-
	reverse(T, RT),
	append(RT, [H], R).

% Ejemplo:
% ?- reverse([1,2],R). % R = [2,1]

% last(Elem, List)
% Unifica Elem con el último elemento de List.
last(X, [X]).
last(X, [_|T]) :-
	last(X, T).

% Ejemplo:
% ?- last(L, [a,b]). % L = b

% delete(Elem, List, Result)
% Elimina todas las ocurrencias de Elem en List, resultando en Result.
delete(_, [], []).
delete(E, [E|T], R) :-
	delete(E, T, R), !.
delete(E, [H|T], [H|R]) :-
	delete(E, T, R).

% Ejemplo:
% ?- delete(b, [b,a],R). % R = [a]

% prefix(Prefix, List)
% Prefix es un prefijo (incial) de List.
prefix([], _).
prefix([H|PT], [H|T]) :-
	prefix(PT, T).

% Ejemplo:
% ?- prefix([a], [a,b]). % true

% flatten(Nested, Flat)
% Aplana una lista arbitrariamente anidada.
% Nota: usa is_list/1 (disponible en SWI-Prolog). Si tu Prolog no tiene is_list/1,
% la cláusula que la usa puede necesitar adaptarse.
flatten([], []).
flatten(X, [X]) :-
	\+ is_list(X).
flatten([H|T], Flat) :-
	flatten(H, FH),
	flatten(T, FT),
	append(FH, FT, Flat).

% Ejemplo:
% ?- flatten([a,[b,c]], F). % F = [a,b,c]

% Fin de predicados definidos por el alumno

