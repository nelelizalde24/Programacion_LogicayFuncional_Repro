
eliza:-	writeln('Hola , mi nombre es  Eliza tu  chatbot,
	por favor ingresa tu consulta,
	usar solo minusculas con punto . al final:'),
	readln(Input),
	eliza(Input),!.
eliza(Input):- Input == ['Adios', '.'],
	writeln('Adios. espero poder verte ayudado.'), !.
eliza(Input):- Input == ['adios', '.'],
	writeln('Adios. espero poder verte ayudado.'), !.
eliza(Input) :-
	template(Stim, Resp, IndStim),
	match(Stim, Input),
	% si he llegado aquí es que he
	% hallado el template correcto:
	replace0(IndStim, Input, 0, Resp, R),
	writeln(R),
	readln(Input1),
	eliza(Input1), !.


template([hola, mi, nombre, es, s(_), '.'], ['Hola', 0, 'Como', estas, tu, '?'], [4]).
template([estoy, bien, y ,tu, '.'], ['tambien','estoy' ,'bien' , 'por que','estas', 'bien', '?' ],[]).
template([bien, _], ['Que', 'bien', 'me', 'alegro', ':)'], []).

template([estoy, mal, y ,tu, '.'], ['tambien','estoy' ,'mal' , 'por que','estas', 'mal', '?' ],[]).
template([mal, _], ['Que', 'mal', 'te', 'entiendo', ':('], []).

template([oye, necesito, ayuda, '.'], ['En', 'que', te, puedo, ayudar, '?'], []).
template([cual, es, el, teorema, de, pitagoras, '.'], ['La', 'formula', 'matematica', 'que', 'expresa', 'esta', 'relacion', 'es', 'a^{2}+b^{2}=c^{2}', 'donde (a) y (b) son los catetos y (c) es la hipotenusa'], []).

template([buendia, mi, nombre, es, s(_), '.'], ['buen dia', 'Como', estas, tu, 0, '?'], [4]).

template([hola, ',', mi, nombre, es, s(_), '.'], ['Hola', 0, 'Como', estas, tu, '?'], [5]).
template([buendia, ',', mi, nombre, es, s(_), '.'], ['Buendia', 'Como', estas, tu, 0, '?'], [5]).

template([hola, _], ['Hola', 'como', estas, tu, '?'], []).
template([buendia, _], ['Buendia', 'Como', estas, tu, '?'], []).

template([yo, s(_), yo, soy, s(_),'.'], [por, que, 0, eres, 1, '?'], [1, 4]).
template([yo, s(_), tu, '.'], [why, do, you, 0, me ,'?'], [1]).
template([yo, soy, s(_),'.'], [porque, eres, tu, 0, '?'], [2]).

% pregunta algo que le gusta a eliza
template([te, gustan, las, s(_), _], [flagLike], [3]).
template([te, gustan, los, s(_), _], [flagLike], [3]).
template([te, gusta, hacer, s(_), _], [flagLike], [3]).
template([te, gusta, s(_), _], [flagLike], [2]).

		 % pregunta algo que hace eliza
template([tu, eres, s(_), _], [flagDo], [2]).
% pregunta algo que es eliza
template([que, eres, tu, s(_)], [flagIs], [2]).
template([eres, s(_), '?'], [flagIs], [2]).

template([como, estas, tu, '?'], [yo, estoy, bien, ',', gracias, por, preguntar, '.'], []).

% Base de datos de enfermedades y síntomas
% Tétanos
tiene_sintoma(tetanos, rigidez_mandibula).
tiene_sintoma(tetanos, espasmos_musculares).
tiene_sintoma(tetanos, trismo).

% Varicela
tiene_sintoma(varicela, ampollas_piel).
tiene_sintoma(varicela, fiebre).
tiene_sintoma(varicela, picazon_intensa).

% Zika
tiene_sintoma(zika, fiebre_alta).
tiene_sintoma(zika, dolor_articulaciones).
tiene_sintoma(zika, erupciones_cutaneas).

% Tratamientos
tratamiento(tetanos, 'Aplicar vacuna antitetanica, reposo absoluto, evitar movimientos bruscos y hospitalizacion en caso grave').
tratamiento(varicela, 'Antivirales como aciclovir, mantener hidratacion, reposo y lociones calmantes para la picazon').
tratamiento(zika, 'Descanso prolongado, hidratacion constante, analgesicos para el dolor y consulta medica inmediata').

enfermedad(tetanos).
enfermedad(varicela).
enfermedad(zika).


template([yo, pienso, que, _], [bueno, esa, es, tu, opinion], []).
template([porque, _], [esa, no, es, una, buena, razon, '.'], []).
template([i, have, s(_), with, s(_), '.'], ['You', have, to, deal, with, your, 0, and, your, 1, in, a, mature, way, '.'], [2, 4]).
template([i, s(_),  _], [i, can, recommend, you, a, book, about, that, issue], []).
template([please, s(_), _], ['No', i, can, not, help, ',', i, am, just, a, machine], []). 
		 template([tell, me, a, s(_), _], ['No', i, can, not, ',', i, am, bad, at, that], []).

				  
template(_, ['Please', explain, a, little, more, '.'], []). 
% Lo que le gusta a eliza : flagLike
elizaLikes(X, R):- likes(X), R = ['Yeah', i, like, X].
elizaLikes(X, R):- \+likes(X), R = ['Nope', i, do, not, like, X].
likes(apples).
likes(ponies).
likes(zombies).
likes(manzanas).
likes(perros).
likes(animales).
likes(gatos).
likes(computadoras).
likes(carros).
likes(ejercicio).
likes(deporte).
likes(platicar).
likes(viajar).



% lo que hace eliza: flagDo
elizaDoes(X, R):- does(X), R = ['Yes', i, X, and, i, love, it].
elizaDoes(X, R):- \+does(X), R = ['No', i, do, not, X ,'.', it, is, too, hard, for, me].
does(study).
does(cook).
does(work).

% lo que es eliza: flagIs
elizaIs(X, R):- is0(X), R = ['Yes', yo, soy, X].
elizaIs(X, R):- \+is0(X), R = ['No', i, am, not, X].
is0(dumb).
is0(weird).
is0(nice).
is0(fine).
is0(happy).
is0(redundant).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Información de síntomas por enfermedad
sintomas_enfermedad(tetanos, [rigidez_mandibula, espasmos_musculares, trismo]).
sintomas_enfermedad(varicela, [ampollas_piel, fiebre, picazon_intensa]).
sintomas_enfermedad(zika, [fiebre_alta, dolor_articulaciones, erupciones_cutaneas]).

% Regla: diagnostico_exclusivo/2
% Se cumple cuando el paciente confirma un síntoma único que no se presenta en ninguna otra enfermedad
diagnostico_exclusivo(Paciente, Enfermedad) :-
	tiene_sintoma(Enfermedad, Sintoma),
	\+ tiene_sintoma_en_otra_enfermedad(Sintoma, Enfermedad),
	format('Diagnostico exclusivo para ~w: ~w (Síntoma único: ~w)~n', [Paciente, Enfermedad, Sintoma]).

% Predicado auxiliar: verifica si un síntoma aparece en alguna otra enfermedad
tiene_sintoma_en_otra_enfermedad(Sintoma, EnfermedadExcluida) :-
	tiene_sintoma(Enfermedad, Sintoma),
	Enfermedad \== EnfermedadExcluida.

% Base de datos de síntomas confirmados por paciente
% Formato: sintoma_confirmado(Paciente, Sintoma)
sintoma_confirmado(juan, rigidez_mandibula).
sintoma_confirmado(juan, espasmos_musculares).
sintoma_confirmado(maria, ampollas_piel).
sintoma_confirmado(maria, fiebre).
sintoma_confirmado(maria, picazon_intensa).
sintoma_confirmado(pedro, fiebre_alta).
sintoma_confirmado(pedro, dolor_articulaciones).

% Regla: probabilidad/3
% Calcula el porcentaje de síntomas confirmados respecto al total de síntomas de una enfermedad
% Porcentaje = (Confirmados / Totales) * 100
probabilidad(Paciente, Enfermedad, Porcentaje) :-
	% Obtener todos los síntomas de la enfermedad usando findall
	findall(Sintoma, tiene_sintoma(Enfermedad, Sintoma), TodosSintomas),
	length(TodosSintomas, TotalSintomas),
	% Obtener todos los síntomas confirmados del paciente que pertenecen a esta enfermedad
	findall(Sintoma, (sintoma_confirmado(Paciente, Sintoma), tiene_sintoma(Enfermedad, Sintoma)), SintomasConfirmados),
	length(SintomasConfirmados, SintomasConfirmadosCount),
	% Calcular el porcentaje
	(TotalSintomas > 0 ->
		Porcentaje is (SintomasConfirmadosCount / TotalSintomas) * 100
	;
		Porcentaje is 0
	),
	% Mostrar resultado
	format('Paciente: ~w~nEnfermedad: ~w~nSíntomas confirmados: ~w de ~w~nProbabilidad: ~2f%~n', 
		[Paciente, Enfermedad, SintomasConfirmadosCount, TotalSintomas, Porcentaje]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

match([],[]).
match([], _):- true.

match([S|Stim],[I|Input]) :-
	atom(S), % si I es un s(X) devuelve falso
	S == I,
	match(Stim, Input),!.

match([S|Stim],[_|Input]) :-
% I es un s(X), lo ignoro y continúo con el resto de la lista
	\+atom(S),
	match(Stim, Input),!.

replace0([], _, _, Resp, R):- append(Resp, [], R),!.
replace0([], _, Resp, R):- append(Resp, [], R),!.

% Eliza likes:
replace0([I|_], Input, _, Resp, R):-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagLike,
	elizaLikes(Atom, R).

% Eliza does:
replace0([I|_], Input, _, Resp, R):-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagDo,
	elizaDoes(Atom, R).

% Eliza is:
replace0([I|_], Input, _, Resp, R):-
	nth0(I, Input, Atom),
	nth0(0, Resp, X),
	X == flagIs,
	elizaIs(Atom, R).

replace0([I|Index], Input, N, Resp, R):-
	length(Index, M), M =:= 0,
	nth0(I, Input, Atom),
	select(N, Resp, Atom, R1), append(R1, [], R),!.

replace0([I|Index], Input, N, Resp, R):-
	nth0(I, Input, Atom),
	length(Index, M), M > 0,
	select(N, Resp, Atom, R1),
	N1 is N + 1,
	replace0(Index, Input, N1, R1, R),!.
