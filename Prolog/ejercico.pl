factorial(0, 1).
factorial(X, F):- X1 is X - 1,
factorial(X1 , F1), F is X * F1.