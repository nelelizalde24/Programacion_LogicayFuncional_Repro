% Acertijo de los investigadores - solver en Prolog
% Uso: consultar `go.` o `solve(S).` para obtener la solución.

% Dominio de valores (sin acentos, en minúsculas)
especialidades([genetica,microbiologia,bioquimica,inmunologia,neurociencia]).
horarios([6,8,10,12,14]).
bebidas([cafe,te,jugo,mate,agua]).
equipos([microscopio,centrifuga,pcr,espectrometro,incubadora]).
paises([mexico,chile,espana,argentina,peru]).

% solve(-Persons)
% Persons es la lista de estructuras p(Nombre,Especialidad,Hora,Bebida,Equipo,Pais)
solve(Persons) :-
	Names = [ana,bruno,carlos,diana,elisa],

	especialidades(Specs), horarios(Times), bebidas(Drinks), equipos(Equips), paises(Countries),

	% Variables para cada persona
	Persons = [ p(ana,Sa,Ta,Da,Ea,Ca),
				p(bruno,Sb,Tb,Db,Eb,Cb),
				p(carlos,Sc,Tc,Dc,Ec,Cc),
				p(diana,Sd,Td,Dd,Ed,Cd),
				p(elisa,Se,Te,De,Ee,Ce)
			  ],

	% Asignaciones: cada columna es una permutación del dominio correspondiente
	permutation(Specs,[Sa,Sb,Sc,Sd,Se]),
	permutation(Times,[Ta,Tb,Tc,Td,Te]),
	permutation(Drinks,[Da,Db,Dc,Dd,De]),
	permutation(Equips,[Ea,Eb,Ec,Ed,Ee]),
	permutation(Countries,[Ca,Cb,Cc,Cd,Ce]),

	% Reglas del acertijo:
	% 1. El investigador de Genética llega a las 6am.
	member(p(_,genetica,6,_,_,_),Persons),

	% 2. Ana no trabaja ni en Genética ni en Neurociencia.
	Sa \= genetica, Sa \= neurociencia,

	% 3. La persona que usa la Centrífuga bebe Té.
	member(p(_,_,_,te,centrifuga,_),Persons),

	% 4. La investigadora de Perú llega a las 10am.
	member(p(_,_,10,_,_,peru),Persons),

	% 5. Carlos usa el Espectrómetro.
	member(p(carlos,_,_,_,espectrometro,_),Persons),

	% 6. Quien bebe Café llega dos horas antes que quien bebe Jugo.
	member(p(_,_,Tcafe,cafe,_,_),Persons), member(p(_,_,Tjugo,jugo,_,_),Persons),
	Tjugo is Tcafe + 2,

	% 7. La persona que trabaja en Inmunología usa PCR.
	member(p(_,inmunologia,_,_,pcr,_),Persons),

	% 8. La especialista en Bioquímica es de Chile.
	member(p(_,bioquimica,_,_,_,chile),Persons),

	% 9. La Incubadora es utilizada por alguien que llega a las 14pm.
	member(p(_,_,14,_,incubadora,_),Persons),

	% 10. El investigador de Argentina bebe Mate.
	member(p(_,_,_,mate,_,argentina),Persons),

	% 11. Elisa no bebe Té ni Café.
	De \= te, De \= cafe,

	% 12. Diana trabaja en Microbiología.
	Sd = microbiologia,

	% 13. El que llega a las 8am usa el Microscopio.
	member(p(_,_,8,_,microscopio,_),Persons),

	% 14. Bruno no es de México.
	Cb \= mexico,

	% 15. La persona de España trabaja en Neurociencia.
	member(p(_,neurociencia,_,_,_,espana),Persons),

	% 16. El usuario del equipo PCR llega después que el especialista en Microbiología.
	member(p(_,_,Tpcr,_,pcr,_),Persons), member(p(_,microbiologia,Tmicro,_,_,_),Persons),
	Tpcr > Tmicro,

	% 17. El de México usa el equipo que NO es Microscopio ni Incubadora.
	member(p(_,_,_,_,EquipMexico,mexico),Persons), EquipMexico \= microscopio, EquipMexico \= incubadora,

	% 18. La persona que bebe Agua no usa ni PCR ni Espectrómetro.
	member(p(_,_,_,agua,EquipAgua,_),Persons), EquipAgua \= pcr, EquipAgua \= espectrometro,

	% 19. El especialista en Neurociencia llega después de la persona que bebe Jugo.
	member(p(_,neurociencia,Tneuro,_,_,_),Persons), member(p(_,_,Tjugo2,jugo,_,_),Persons),
	Tneuro > Tjugo2,

	% 20. El de Perú NO bebe Agua.
	\+ member(p(_,_,_,agua,_,peru),Persons),

	% Restricciones adicionales lógicas (ya implícitas por permutation pero expresadas por claridad)
	% (Por ejemplo: Carlos usa espectrometro ya fijado; Diana es microbiologia ya fijado.)

	true.

% Predicado para imprimir la solución de forma legible
print_solution(Persons) :-
	nl, write('Solución:'), nl, nl,
	forall(member(p(Name,Spec,Time,Drink,Equip,Country),Persons),
		   ( format('~w: Especialidad=~w, Hora=~w, Bebida=~w, Equipo=~w, País=~w~n', [Name,Spec,Time,Drink,Equip,Country]) )),
	nl.

% Ejecutable principal
go :-
	solve(Persons), print_solution(Persons), !.

% Fallback: mostrar todas las soluciones posibles si se quita el corte
