
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

% Meningitis (Enfermedad grave)
tiene_sintoma(meningitis, fiebre_alta).
tiene_sintoma(meningitis, dolor_cabeza_severo).
tiene_sintoma(meningitis, rigidez_cuello).
tiene_sintoma(meningitis, confusion_mental).
tiene_sintoma(meningitis, nauseas).

% Neumonía (Enfermedad grave)
tiene_sintoma(neumonia, fiebre_alta).
tiene_sintoma(neumonia, tos_persistente).
tiene_sintoma(neumonia, dificultad_respiratoria).
tiene_sintoma(neumonia, dolor_pecho).

% Dengue hemorrágico (Enfermedad grave)
tiene_sintoma(dengue_hemorragico, fiebre_alta).
tiene_sintoma(dengue_hemorragico, sangrado_encias).
tiene_sintoma(dengue_hemorragico, dolor_abdominal_intenso).
tiene_sintoma(dengue_hemorragico, vomito_persistente).
tiene_sintoma(dengue_hemorragico, debilidad_extrema).

% Tratamientos
tratamiento(tetanos, 'Aplicar vacuna antitetanica, reposo absoluto, evitar movimientos bruscos y hospitalizacion en caso grave').
tratamiento(varicela, 'Antivirales como aciclovir, mantener hidratacion, reposo y lociones calmantes para la picazon').
tratamiento(zika, 'Descanso prolongado, hidratacion constante, analgesicos para el dolor y consulta medica inmediata').
tratamiento(meningitis, 'URGENTE: Hospitalizacion inmediata, antibioticos intravenosos, monitoreo constante de signos vitales').
tratamiento(neumonia, 'Antibioticos, oxigenoterapia si es necesaria, reposo absoluto y hospitalizacion en casos graves').
tratamiento(dengue_hemorragico, 'EMERGENCIA: Hospitalizacion urgente, reposicion de liquidos intravenosos, transfusiones si es necesario').

enfermedad(tetanos).
enfermedad(varicela).
enfermedad(zika).
enfermedad(meningitis).
enfermedad(neumonia).
enfermedad(dengue_hemorragico).

% Base de datos de síntomas contradictorios
% Dos síntomas son contradictorios si no pueden presentarse simultáneamente
contradictorio(fiebre, picazon_ojos).
contradictorio(nauseas, estornudos).

% Clasificación de gravedad de enfermedades
gravedad_enfermedad(meningitis, grave).
gravedad_enfermedad(neumonia, grave).
gravedad_enfermedad(dengue_hemorragico, grave).
gravedad_enfermedad(tetanos, moderada).
gravedad_enfermedad(zika, moderada).
gravedad_enfermedad(varicela, leve).

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
sintomas_enfermedad(meningitis, [fiebre_alta, dolor_cabeza_severo, rigidez_cuello, confusion_mental, nauseas]).
sintomas_enfermedad(neumonia, [fiebre_alta, tos_persistente, dificultad_respiratoria, dolor_pecho]).
sintomas_enfermedad(dengue_hemorragico, [fiebre_alta, sangrado_encias, dolor_abdominal_intenso, vomito_persistente, debilidad_extrema]).

% Regla: riesgo/3
% Determina el nivel de riesgo (alto, medio, bajo) de un paciente para una enfermedad específica
riesgo(Paciente, Enfermedad, alto) :-
	gravedad_enfermedad(Enfermedad, grave),
	% Contar síntomas confirmados del paciente para esta enfermedad
	findall(S, (sintoma_confirmado(Paciente, S), tiene_sintoma(Enfermedad, S)), SintomasConfirmados),
	length(SintomasConfirmados, NumConfirmados),
	% Si tiene 3 o más síntomas de una enfermedad grave, riesgo alto
	NumConfirmados >= 3,
	format('RIESGO ALTO: Paciente ~w presenta ~w síntomas de ~w (enfermedad grave)~n', [Paciente, NumConfirmados, Enfermedad]).

riesgo(Paciente, Enfermedad, medio) :-
	gravedad_enfermedad(Enfermedad, grave),
	findall(S, (sintoma_confirmado(Paciente, S), tiene_sintoma(Enfermedad, S)), SintomasConfirmados),
	length(SintomasConfirmados, NumConfirmados),
	% Si tiene 1-2 síntomas de una enfermedad grave, riesgo medio
	NumConfirmados >= 1,
	NumConfirmados < 3,
	format('RIESGO MEDIO: Paciente ~w presenta ~w síntomas de ~w (enfermedad grave)~n', [Paciente, NumConfirmados, Enfermedad]).

riesgo(Paciente, Enfermedad, medio) :-
	gravedad_enfermedad(Enfermedad, moderada),
	findall(S, (sintoma_confirmado(Paciente, S), tiene_sintoma(Enfermedad, S)), SintomasConfirmados),
	length(SintomasConfirmados, NumConfirmados),
	% Si tiene 2 o más síntomas de una enfermedad moderada, riesgo medio
	NumConfirmados >= 2,
	format('RIESGO MEDIO: Paciente ~w presenta ~w síntomas de ~w (enfermedad moderada)~n', [Paciente, NumConfirmados, Enfermedad]).

riesgo(Paciente, Enfermedad, bajo) :-
	enfermedad(Enfermedad),
	(gravedad_enfermedad(Enfermedad, leve);
	 gravedad_enfermedad(Enfermedad, moderada)),
	findall(S, (sintoma_confirmado(Paciente, S), tiene_sintoma(Enfermedad, S)), SintomasConfirmados),
	length(SintomasConfirmados, NumConfirmados),
	% Si tiene pocos síntomas de enfermedad leve/moderada, riesgo bajo
	NumConfirmados >= 1,
	NumConfirmados < 2,
	format('RIESGO BAJO: Paciente ~w presenta ~w síntoma(s) de ~w~n', [Paciente, NumConfirmados, Enfermedad]).

riesgo(Paciente, Enfermedad, bajo) :-
	enfermedad(Enfermedad),
	gravedad_enfermedad(Enfermedad, leve),
	findall(S, (sintoma_confirmado(Paciente, S), tiene_sintoma(Enfermedad, S)), SintomasConfirmados),
	length(SintomasConfirmados, NumConfirmados),
	% Cualquier cantidad de síntomas de enfermedad leve es riesgo bajo
	NumConfirmados >= 1,
	format('RIESGO BAJO: Paciente ~w presenta síntomas de ~w (enfermedad leve)~n', [Paciente, Enfermedad]).

% Regla: diagnostico_basico/2
% Determina si un paciente tiene al menos un síntoma de una enfermedad
diagnostico_basico(Paciente, Enfermedad) :-
	enfermedad(Enfermedad),
	sintoma_confirmado(Paciente, Sintoma),
	tiene_sintoma(Enfermedad, Sintoma).

% Regla: tratamiento_combinado/2
% Lista todos los tratamientos para las enfermedades que el paciente podría tener
tratamiento_combinado(Paciente, Lista) :-
	% Encontrar todas las enfermedades que cumplen con diagnóstico básico
	findall(Enfermedad, diagnostico_basico(Paciente, Enfermedad), EnfermedadesPosibles),
	% Eliminar duplicados
	sort(EnfermedadesPosibles, EnfermedadesUnicas),
	% Obtener los tratamientos para cada enfermedad
	findall(
		tratamiento(Enfermedad, Tratamiento),
		(member(Enfermedad, EnfermedadesUnicas), tratamiento(Enfermedad, Tratamiento)),
		Lista
	),
	% Mostrar resultados
	format('~n=== Tratamientos Combinados para Paciente: ~w ===~n', [Paciente]),
	length(EnfermedadesUnicas, NumEnfermedades),
	format('Se detectaron ~w posibles enfermedades~n~n', [NumEnfermedades]),
	mostrar_tratamientos(Lista).

% Predicado auxiliar: mostrar_tratamientos/1
% Muestra de forma legible los tratamientos
mostrar_tratamientos([]).
mostrar_tratamientos([tratamiento(Enfermedad, Tratamiento)|Resto]) :-
	format('Enfermedad: ~w~nTratamiento: ~w~n~n', [Enfermedad, Tratamiento]),
	mostrar_tratamientos(Resto).

% Regla: recomendacion/3
% Genera recomendaciones específicas basadas en el nivel de riesgo del paciente
recomendacion(Paciente, Enfermedad, Texto) :-
	riesgo(Paciente, Enfermedad, alto),
	format(atom(Texto), 'CRÍTICO: ~w presenta riesgo ALTO de ~w. REQUIERE HOSPITALIZACIÓN URGENTE. Llame a emergencias inmediatamente. Monitoreo constante de signos vitales.', [Paciente, Enfermedad]).

recomendacion(Paciente, Enfermedad, Texto) :-
	riesgo(Paciente, Enfermedad, medio),
	format(atom(Texto), 'ATENCIÓN: ~w presenta riesgo MEDIO de ~w. Se recomienda CONSULTA MÉDICA INMEDIATA. No demore más de 2 horas. Prepare documentación médica previa.', [Paciente, Enfermedad]).

recomendacion(Paciente, Enfermedad, Texto) :-
	riesgo(Paciente, Enfermedad, bajo),
	format(atom(Texto), 'OBSERVACIÓN: ~w presenta riesgo BAJO de ~w. Se recomienda DESCANSO, HIDRATACIÓN y MONITOREO. Consulte si los síntomas persisten después de 3 días.', [Paciente, Enfermedad]).

% Regla auxiliar: mostrar_recomendaciones/1
% Muestra todas las recomendaciones para un paciente
mostrar_recomendaciones(Paciente) :-
	format('~n=== RECOMENDACIONES MÉDICAS PARA: ~w ===~n~n', [Paciente]),
	(riesgo(Paciente, Enfermedad, Nivel),
	 recomendacion(Paciente, Enfermedad, Texto),
	 format('~w~n~n', [Texto]),
	 fail
	;
	 true),
	writeln('=== FIN DE RECOMENDACIONES ===').

% Predicado auxiliar: contar_sintomas_coincidentes/3
% Cuenta cuántos síntomas de una enfermedad tiene el paciente confirmados
contar_sintomas_coincidentes(Paciente, Enfermedad, NumCoincidencias) :-
	findall(S, (sintoma_confirmado(Paciente, S), tiene_sintoma(Enfermedad, S)), SintomasCoincidentes),
	length(SintomasCoincidentes, NumCoincidencias).

% Regla: diagnosticar_y_tratar/3
% Realiza diagnóstico completo y retorna tratamiento en un solo paso
diagnosticar_y_tratar(Paciente, Diagnostico, Tratamiento) :-
	% Encontrar todas las enfermedades posibles basadas en síntomas
	findall(
		enf(Enfermedad, Coincidencias),
		(enfermedad(Enfermedad), 
		 contar_sintomas_coincidentes(Paciente, Enfermedad, Coincidencias),
		 Coincidencias > 0),
		EnfermedadesConCoincidencias
	),
	% Verificar que hay al menos una enfermedad posible
	EnfermedadesConCoincidencias \== [],
	% Ordenar por número de coincidencias (descendente) y tomar la primera
	sort(EnfermedadesConCoincidencias, EnfermedadesOrdenadas),
	reverse(EnfermedadesOrdenadas, EnfermedadesDescendentes),
	EnfermedadesDescendentes = [enf(Diagnostico, NumSintomas)|_],
	% Obtener el tratamiento
	tratamiento(Diagnostico, Tratamiento),
	% Mostrar resumen
	format('~n=== DIAGNÓSTICO Y TRATAMIENTO ===~n', []),
	format('Paciente: ~w~n', [Paciente]),
	format('Diagnóstico: ~w~n', [Diagnostico]),
	format('Síntomas coincidentes: ~w~n', [NumSintomas]),
	format('Tratamiento: ~w~n', [Tratamiento]),
	% Mostrar nivel de riesgo si aplica
	(riesgo(Paciente, Diagnostico, Nivel) ->
		format('Nivel de Riesgo: ~w~n', [Nivel])
	;
		true),
	writeln('=== FIN DEL DIAGNÓSTICO ===').

% Predicado auxiliar: calcular_probabilidad/3
% Calcula el porcentaje de probabilidad de una enfermedad basado en síntomas coincidentes
calcular_probabilidad(Paciente, Enfermedad, Probabilidad) :-
	% Obtener total de síntomas de la enfermedad
	findall(S, tiene_sintoma(Enfermedad, S), TodosSintomas),
	length(TodosSintomas, TotalSintomas),
	% Obtener síntomas coincidentes
	contar_sintomas_coincidentes(Paciente, Enfermedad, NumCoincidencias),
	% Calcular probabilidad
	(TotalSintomas > 0 ->
		Probabilidad is (NumCoincidencias / TotalSintomas) * 100
	;
		Probabilidad is 0
	).

% Regla: reporte/1
% Genera un reporte completo del diagnóstico y tratamiento del paciente
reporte(Paciente) :-
	writeln(''),
	writeln('╔════════════════════════════════════════════════════════════════╗'),
	writeln('║           REPORTE MÉDICO COMPLETO DEL PACIENTE                ║'),
	writeln('╚════════════════════════════════════════════════════════════════╝'),
	format('~nPaciente: ~w~n~n', [Paciente]),
	
	% 1. SÍNTOMAS CONFIRMADOS
	writeln('1. SÍNTOMAS CONFIRMADOS:'),
	writeln('─────────────────────────'),
	(findall(S, sintoma_confirmado(Paciente, S), SintomasConfirmados),
	 SintomasConfirmados \== [] ->
		(length(SintomasConfirmados, NumSintomas),
		 format('   Total de síntomas reportados: ~w~n', [NumSintomas]),
		 writeln('   • '),
		 forall(member(S, SintomasConfirmados), format('   • ~w~n', [S]))
		)
	;
		writeln('   No hay síntomas confirmados registrados')
	),
	nl,
	
	% 2. ENFERMEDADES POSIBLES Y PROBABILIDADES
	writeln('2. ANÁLISIS DE ENFERMEDADES POSIBLES:'),
	writeln('─────────────────────────────────────'),
	findall(
		prob(Enfermedad, Prob),
		(enfermedad(Enfermedad),
		 contar_sintomas_coincidentes(Paciente, Enfermedad, NumCoin),
		 NumCoin > 0,
		 calcular_probabilidad(Paciente, Enfermedad, Prob)),
		ProbabilidadesLista
	),
	(ProbabilidadesLista \== [] ->
		(sort(ProbabilidadesLista, ProbOrdenadas),
		 reverse(ProbOrdenadas, ProbDescendentes),
		 forall(member(prob(Enf, P), ProbDescendentes),
		 	format('   • ~w: ~2f%~n', [Enf, P]))
		)
	;
		writeln('   No se encontraron enfermedades coincidentes')
	),
	nl,
	
	% 3. DIAGNÓSTICO FINAL
	writeln('3. DIAGNÓSTICO FINAL:'),
	writeln('─────────────────────'),
	(diagnosticar_y_tratar(Paciente, Diag, Trat) ->
		(format('   Enfermedad: ~w~n', [Diag]),
		 format('   Tratamiento: ~w~n', [Trat])
		)
	;
		writeln('   No se puede determinar diagnóstico con los síntomas proporcionados')
	),
	nl,
	
	% 4. SEVERIDAD Y NIVEL DE RIESGO
	writeln('4. EVALUACIÓN DE SEVERIDAD:'),
	writeln('────────────────────────────'),
	(diagnosticar_y_tratar(Paciente, DiagFinal, _) ->
		(gravedad_enfermedad(DiagFinal, Gravedad),
		 format('   Nivel de Gravedad: ~w~n', [Gravedad]),
		 (riesgo(Paciente, DiagFinal, NivelRiesgo) ->
		 	format('   Nivel de Riesgo para Paciente: ~w~n', [NivelRiesgo])
		 ;
		 	true
		 )
		)
	;
		true
	),
	nl,
	
	% 5. RECOMENDACIÓN
	writeln('5. RECOMENDACIÓN MÉDICA:'),
	writeln('─────────────────────────'),
	(diagnosticar_y_tratar(Paciente, DiagFinal2, _) ->
		(recomendacion(Paciente, DiagFinal2, TextoRec) ->
			format('   ~w~n', [TextoRec])
		;
			writeln('   No hay recomendación disponible')
		)
	;
		writeln('   Sin recomendación disponible')
	),
	nl,
	
	writeln('╚════════════════════════════════════════════════════════════════╝'),
	writeln('').

% Regla: enfermedades_similares/2
% Determina si dos enfermedades son similares si comparten al menos 2 síntomas
enfermedades_similares(E1, E2) :-
	enfermedad(E1),
	enfermedad(E2),
	E1 \== E2,  % Las enfermedades deben ser diferentes
	% Obtener todos los síntomas compartidos entre E1 y E2
	findall(Sintoma, (tiene_sintoma(E1, Sintoma), tiene_sintoma(E2, Sintoma)), SintomasCompartidos),
	length(SintomasCompartidos, NumCompartidos),
	NumCompartidos >= 2.

% Predicado auxiliar: verifica si dos síntomas son contradictorios (relación simétrica)
son_contradictorios(S1, S2) :-
	contradictorio(S1, S2).
son_contradictorios(S1, S2) :-
	contradictorio(S2, S1).

% Regla: sintomas_contradictorios/1
% Detecta si un paciente tiene síntomas contradictorios confirmados
sintomas_contradictorios(Paciente) :-
	sintoma_confirmado(Paciente, S1),
	sintoma_confirmado(Paciente, S2),
	S1 \== S2,
	son_contradictorios(S1, S2),
	format('ALERTA: El paciente ~w tiene síntomas contradictorios: ~w y ~w~n', [Paciente, S1, S2]).

% Árbol de Decisión Médico
% arbol_diagnostico/2 - Diagnóstica una enfermedad basándose en preguntas clave

% Predicado principal que inicia el árbol de decisión
arbol_diagnostico(Paciente, Enfermedad) :-
	format('=== Diagnóstico médico para paciente: ~w ===~n', [Paciente]),
	writeln('Responda las siguientes preguntas con "si" o "no":'),
	nl,
	% Iniciar el árbol de decisión con la primera pregunta
	pregunta_fiebre(Paciente, Enfermedad),
	format('~nDiagnóstico: ~w~n', [Enfermedad]),
	tratamiento(Enfermedad, Tratamiento),
	format('Tratamiento recomendado: ~w~n', [Tratamiento]).

% Nodo 1: ¿Tiene fiebre?
pregunta_fiebre(Paciente, Enfermedad) :-
	write('¿El paciente tiene fiebre o fiebre alta? (si/no): '),
	read(Respuesta),
	(Respuesta == si ->
		% Si tiene fiebre, preguntar por síntomas de piel
		pregunta_piel(Paciente, Enfermedad)
	;
		% No tiene fiebre, preguntar por rigidez muscular
		pregunta_rigidez(Paciente, Enfermedad)
	).

% Nodo 2a: ¿Tiene problemas en la piel?
pregunta_piel(Paciente, Enfermedad) :-
	write('¿El paciente tiene ampollas, erupciones o picazón en la piel? (si/no): '),
	read(Respuesta),
	(Respuesta == si ->
		% Tiene fiebre y problemas de piel, distinguir entre varicela y zika
		pregunta_tipo_piel(Paciente, Enfermedad)
	;
		% Tiene fiebre pero no problemas de piel - puede ser otra enfermedad
		Enfermedad = indeterminado,
		writeln('Los síntomas no coinciden con las enfermedades en la base de datos.')
	).

% Nodo 3a: ¿Qué tipo de problema de piel?
pregunta_tipo_piel(Paciente, Enfermedad) :-
	write('¿Son ampollas con picazón intensa? (si=varicela, no=verificar otros): '),
	read(Respuesta),
	(Respuesta == si ->
		Enfermedad = varicela
	;
		% Verificar si es zika preguntando por dolor articular
		pregunta_articulaciones(Paciente, Enfermedad)
	).

% Nodo 3b: ¿Dolor en articulaciones?
pregunta_articulaciones(Paciente, Enfermedad) :-
	write('¿El paciente tiene dolor en las articulaciones? (si/no): '),
	read(Respuesta),
	(Respuesta == si ->
		Enfermedad = zika
	;
		Enfermedad = indeterminado,
		writeln('Los síntomas no coinciden exactamente con las enfermedades conocidas.')
	).

% Nodo 2b: ¿Tiene rigidez muscular?
pregunta_rigidez(Paciente, Enfermedad) :-
	write('¿El paciente tiene rigidez en la mandíbula o espasmos musculares? (si/no): '),
	read(Respuesta),
	(Respuesta == si ->
		% Verificar si es tétanos
		pregunta_espasmos(Paciente, Enfermedad)
	;
		Enfermedad = indeterminado,
		writeln('No se puede determinar la enfermedad con los síntomas proporcionados.')
	).

% Nodo 3c: ¿Tiene espasmos musculares severos?
pregunta_espasmos(Paciente, Enfermedad) :-
	write('¿Los espasmos musculares son severos o hay trismo (dificultad para abrir la boca)? (si/no): '),
	read(Respuesta),
	(Respuesta == si ->
		Enfermedad = tetanos
	;
		Enfermedad = indeterminado,
		writeln('Los síntomas sugieren problema muscular pero no tétanos clásico.')
	).

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
