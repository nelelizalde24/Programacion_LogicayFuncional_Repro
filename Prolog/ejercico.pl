factorial(0, 1).
factorial(X, F):- X1 is X - 1,
factorial(X1 , F1), F is X * F1.

fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, F) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1, F1),
    fibonacci(N2, F2),
    F is F1 + F2.

potencia(_, 0, 1).
potencia(A, B, R) :-
    B > 0,
    B1 is B - 1,
    potencia(A, B1, R1),
    multiplicar(A, R1, R).

dividir(A, B, 0) :-
    A < B.
dividir(A, B, Q) :-
    A >= B,
    A1 is A - B,
    dividir(A1, B, Q1),
    Q is Q1 + 1.
