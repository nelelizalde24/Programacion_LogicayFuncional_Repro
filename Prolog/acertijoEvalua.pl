

investigadores(ana).
investigadores(bruno).
investigadores(carlos).
investigadores(diana).
investigadores(elisa).

especialidades(genetica).
especialidades(microbiologia).
especialidades(neurociencia).
especialidades(bioquimica).
especialidades(inmunologia).

horarios(6).
horarios(8).
horarios(10).
horarios(12).
horarios(14).

bebidas(cafe).
bebidas(te).
bebidas(jugo).
bebidas(mate).
bebidas(agua).

equipos(microscopio).
equipos(centrifuga).
equipos(pcr).
equipos(espectrometro).
equipos(incubadora).

paises(mexico).
paises(chile).
paises(espana).
paises(argentina).
paises(peru).

predicado(Nombre,Especialidad,Hora,Bebida,Equipo,Pais).

predicado(_,genetica,6,_,_,_).
predicado(ana,Especialidad,_,_,_,_) :- Especialidad \= genetica, Especialidad \= neurociencia.
predicado(_,_,_,te,centrifuga,_).
predicado(_,_,10,_,_,peru).
predicado(carlos,_,_,_,espectrometro,_).
predicado(_,_,Tcafe,cafe,_,_) :- Tjugo is Tcafe + 2, predicado(_,_,Tjugo,_,_,_).
predicado(_,inmunologia,_,_,pcr,_).
predicado(_,bioquimica,_,_,_,chile).
predicado(_,_,14,_,incubadora,_).
predicado(_,_,_,mate,_,argentina).
predicado(elisa,_,_,Bebida,_,_):- Bebida \= cafe , Bebida \= te.
predicado(diana,microbiologia,_,_,_,_).
predicado(_,_,8,_,microscopio,_).
predicado(bruno,_,_,_,_,Pais) :- Pais \= mexico. 
predicado(_,neurociencia,_,_,_,espana).
% predicado(_,Especialidad,Hora,_,Equipo,_):- 
predicado(_,_,_,_,_,Equipo,mexico):- Eqipo \= espectrometro, Equipo \= incubadora.
predicado(_,_,_,_,agua,Equipo,_):- Eqipo \= pcr, Equipo \= espectrometro.


