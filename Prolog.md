# Prolog - Programación Lógica

## Índice

- [Introducción](#introducción)
- [Lógica de Primer Orden](#lógica-de-primer-orden)
- [Conceptos Fundamentales](#conceptos-fundamentales)
- [Proyecto Final - Sistema de Diagnóstico Médico](#proyecto-final---sistema-de-diagnóstico-médico)
  - [Arquitectura del Sistema](#arquitectura-del-sistema)
  - [Predicados Implementados](#predicados-implementados)
  - [Ejemplos de Uso](#ejemplos-de-uso)
- [Referencias](#referencias)

---

## Introducción

**Prolog** (Programación en Lógica) es un lenguaje de programación lógica basado en la lógica de primer orden. A diferencia de los lenguajes imperativos que especifican "cómo" hacer algo, Prolog se enfoca en "qué" queremos lograr, permitiendo que el intérprete encuentre la solución.

### Características principales:
- **Basado en cláusulas y reglas**: Utiliza hechos (clausulas de base de datos) y reglas (implicaciones lógicas)
- **Unificación**: Mecanismo para hacer coincidir términos
- **Backtracking**: Búsqueda automática de alternativas
- **Búsqueda automática**: Encuentra soluciones sin programación explícita del flujo de control

---

## Lógica de Primer Orden

### Componentes básicos:

**Constantes de individuo**: Hacen referencia específica a entidades
```prolog
juan, maria, tetanos, varicela
```

**Variables de individuo**: Hacen referencias a entidades genéricas (comienzan con mayúscula)
```prolog
X, Y, Paciente, Enfermedad
```

**Predicados**: Expresan relaciones entre individuos
```prolog
padre(juan, carlos).          % juan es padre de carlos
tiene_sintoma(tetanos, fiebre).  % tetanos tiene fiebre como síntoma
```

**Reglas**: Implicaciones lógicas (si-entonces)
```prolog
abuelo(X, Z) :- padre(X, Y), padre(Y, Z).
```

---

## Conceptos Fundamentales

### Unificación

Es el proceso de hacer que dos términos sean idénticos mediante la substitución de variables.

```prolog
% Unificación exitosa:
?- X = 5.
X = 5.

% Unificación con patrones:
?- diagnostico(Paciente, meningitis) = diagnostico(juan, meningitis).
Paciente = juan.
```

### Ejemplo: Cálculo recursivo

```prolog
% Factorial con recursión
factorial(0, 1).
factorial(X, F):- 
    X1 is X - 1,
    factorial(X1, F1), 
    F is X * F1.

% Fibonacci
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, F):-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1, F1),
    fibonacci(N2, F2),
    F is F1 + F2.

% Multiplicación usando sumas
multiplica(0, _, 0).
multiplica(X, Y, R):-
    X > 0,
    X1 is X - 1,
    multiplica(X1, Y, R1),
    R is R1 + Y.

% División usando restas
divide(X, Y, 0):-
    X < Y, !.
divide(X, Y, Q):-
    X >= Y,
    X1 is X - Y,
    divide(X1, Y, Q1),
    Q is Q1 + 1.
```

---

## Proyecto Final - Sistema de Diagnóstico Médico

### Descripción General

Se desarrolló un **Sistema Experto de Diagnóstico Médico** en Prolog capaz de:
- Diagnosticar enfermedades basándose en síntomas reportados
- Evaluar el nivel de riesgo de cada paciente
- Proporcionar tratamientos recomendados
- Generar reportes médicos completos
- Detectar síntomas contradictorios
- Crear un árbol de decisión interactivo

### Arquitectura del Sistema

#### **Base de Datos de Enfermedades**

Se implementaron 6 enfermedades con sus síntomas característicos:

```prolog
% Enfermedades leves
tiene_sintoma(varicela, ampollas_piel).
tiene_sintoma(varicela, fiebre).
tiene_sintoma(varicela, picazon_intensa).

% Enfermedades moderadas
tiene_sintoma(tetanos, rigidez_mandibula).
tiene_sintoma(tetanos, espasmos_musculares).
tiene_sintoma(tetanos, trismo).

tiene_sintoma(zika, fiebre_alta).
tiene_sintoma(zika, dolor_articulaciones).
tiene_sintoma(zika, erupciones_cutaneas).

% Enfermedades graves
tiene_sintoma(meningitis, fiebre_alta).
tiene_sintoma(meningitis, dolor_cabeza_severo).
tiene_sintoma(meningitis, rigidez_cuello).
tiene_sintoma(meningitis, confusion_mental).
tiene_sintoma(meningitis, nauseas).

tiene_sintoma(neumonia, fiebre_alta).
tiene_sintoma(neumonia, tos_persistente).
tiene_sintoma(neumonia, dificultad_respiratoria).
tiene_sintoma(neumonia, dolor_pecho).

tiene_sintoma(dengue_hemorragico, fiebre_alta).
tiene_sintoma(dengue_hemorragico, sangrado_encias).
tiene_sintoma(dengue_hemorragico, dolor_abdominal_intenso).
tiene_sintoma(dengue_hemorragico, vomito_persistente).
tiene_sintoma(dengue_hemorragico, debilidad_extrema).
```

#### **Clasificación de Severidad**

```prolog
gravedad_enfermedad(meningitis, grave).
gravedad_enfermedad(neumonia, grave).
gravedad_enfermedad(dengue_hemorragico, grave).
gravedad_enfermedad(tetanos, moderada).
gravedad_enfermedad(zika, moderada).
gravedad_enfermedad(varicela, leve).
```

#### **Síntomas Contradictorios**

```prolog
contradictorio(fiebre, picazon_ojos).
contradictorio(nauseas, estornudos).
```

### Predicados Implementados

#### 1. **`enfermedades_similares(E1, E2)`**
Determina si dos enfermedades comparten al menos 2 síntomas.

```prolog
enfermedades_similares(E1, E2) :-
    enfermedad(E1),
    enfermedad(E2),
    E1 \== E2,
    findall(Sintoma, 
        (tiene_sintoma(E1, Sintoma), tiene_sintoma(E2, Sintoma)), 
        SintomasCompartidos),
    length(SintomasCompartidos, NumCompartidos),
    NumCompartidos >= 2.
```

#### 2. **`sintomas_contradictorios(Paciente)`**
Detecta si un paciente tiene síntomas incompatibles.

```prolog
sintomas_contradictorios(Paciente) :-
    sintoma_confirmado(Paciente, S1),
    sintoma_confirmado(Paciente, S2),
    S1 \== S2,
    son_contradictorios(S1, S2),
    format('ALERTA: El paciente ~w tiene síntomas contradictorios: ~w y ~w~n', 
        [Paciente, S1, S2]).
```

#### 3. **`riesgo(Paciente, Enfermedad, Nivel)`**
Evalúa el nivel de riesgo (alto, medio, bajo) basado en cantidad y tipo de síntomas.

```prolog
% Riesgo ALTO: enfermedad grave con 3+ síntomas
riesgo(Paciente, Enfermedad, alto) :-
    gravedad_enfermedad(Enfermedad, grave),
    findall(S, (sintoma_confirmado(Paciente, S), tiene_sintoma(Enfermedad, S)), 
        SintomasConfirmados),
    length(SintomasConfirmados, NumConfirmados),
    NumConfirmados >= 3.

% Riesgo MEDIO: enfermedad grave con 1-2 síntomas o enfermedad moderada con 2+ síntomas
riesgo(Paciente, Enfermedad, medio) :- ...

% Riesgo BAJO: enfermedades leves o pocos síntomas
riesgo(Paciente, Enfermedad, bajo) :- ...
```

#### 4. **`arbol_diagnostico(Paciente, Enfermedad)`**
Árbol de decisión interactivo que realiza preguntas clave para diagnosticar.

Estructura de decisión:
```
¿Fiebre?
├─ Sí → ¿Problemas de piel?
│   ├─ Sí → ¿Ampollas con picazón? → Varicela
│   └─ No → ¿Dolor articulaciones? → Zika
└─ No → ¿Rigidez muscular?
    ├─ Sí → ¿Espasmos severos? → Tétanos
    └─ No → Indeterminado
```

#### 5. **`diagnosticar_y_tratar(Paciente, Diagnostico, Tratamiento)`**
Realiza diagnóstico completo en un paso, seleccionando la enfermedad más probable.

```prolog
diagnosticar_y_tratar(Paciente, Diagnostico, Tratamiento) :-
    % Encuentra todas las enfermedades posibles
    findall(enf(Enfermedad, Coincidencias), ... , EnfermedadesConCoincidencias),
    % Ordena por cantidad de síntomas coincidentes
    sort(EnfermedadesConCoincidencias, EnfermedadesOrdenadas),
    reverse(EnfermedadesOrdenadas, EnfermedadesDescendentes),
    % Toma la más probable
    EnfermedadesDescendentes = [enf(Diagnostico, _)|_],
    % Obtiene el tratamiento
    tratamiento(Diagnostico, Tratamiento).
```

#### 6. **`recomendacion(Paciente, Enfermedad, Texto)`**
Genera recomendaciones basadas en el nivel de riesgo.

```prolog
% Riesgo ALTO
recomendacion(Paciente, Enfermedad, Texto) :-
    riesgo(Paciente, Enfermedad, alto),
    format(atom(Texto), 
        'CRÍTICO: ~w presenta riesgo ALTO de ~w. REQUIERE HOSPITALIZACIÓN URGENTE.', 
        [Paciente, Enfermedad]).
```

#### 7. **`tratamiento_combinado(Paciente, Lista)`**
Lista todos los tratamientos para las enfermedades posibles del paciente.

#### 8. **`reporte(Paciente)`**
Genera un reporte médico completo incluyendo:
- Síntomas confirmados
- Enfermedades posibles con probabilidades
- Diagnóstico final
- Evaluación de severidad
- Recomendación médica

### Ejemplos de Uso

#### Ejemplo 1: Diagnóstico simple

```prolog
% Agregar síntomas del paciente
?- assert(sintoma_confirmado(carlos, fiebre_alta)).
?- assert(sintoma_confirmado(carlos, dolor_articulaciones)).
?- assert(sintoma_confirmado(carlos, erupciones_cutaneas)).

% Obtener diagnóstico inmediato
?- diagnosticar_y_tratar(carlos, Diag, Trat).

=== DIAGNÓSTICO Y TRATAMIENTO ===
Paciente: carlos
Diagnóstico: zika
Síntomas coincidentes: 3
Tratamiento: Descanso prolongado, hidratacion constante, analgesicos para el dolor...
Nivel de Riesgo: medio
=== FIN DEL DIAGNÓSTICO ===
```

#### Ejemplo 2: Reporte completo

```prolog
?- reporte(carlos).

╔════════════════════════════════════════════════════════════════╗
║           REPORTE MÉDICO COMPLETO DEL PACIENTE                ║
╚════════════════════════════════════════════════════════════════╝

Paciente: carlos

1. SÍNTOMAS CONFIRMADOS:
─────────────────────────
   Total de síntomas reportados: 3
   • fiebre_alta
   • dolor_articulaciones
   • erupciones_cutaneas

2. ANÁLISIS DE ENFERMEDADES POSIBLES:
─────────────────────────────────────
   • zika: 100.00%
   • neumonia: 25.00%

3. DIAGNÓSTICO FINAL:
─────────────────────
   Enfermedad: zika
   Tratamiento: Descanso prolongado, hidratacion constante...

4. EVALUACIÓN DE SEVERIDAD:
────────────────────────────
   Nivel de Gravedad: moderada
   Nivel de Riesgo para Paciente: medio

5. RECOMENDACIÓN MÉDICA:
─────────────────────────
   ATENCIÓN: carlos presenta riesgo MEDIO de zika...

╚════════════════════════════════════════════════════════════════╝
```

#### Ejemplo 3: Árbol de decisión interactivo

```prolog
?- arbol_diagnostico(juan, Enfermedad).
=== Diagnóstico médico para paciente: juan ===
Responda las siguientes preguntas con "si" o "no":

¿El paciente tiene fiebre o fiebre alta? (si/no): si.
¿El paciente tiene ampollas, erupciones o picazón en la piel? (si/no): si.
¿Son ampollas con picazón intensa? (si=varicela, no=verificar otros): si.

Diagnóstico: varicela
Tratamiento recomendado: Antivirales como aciclovir, mantener hidratacion...
```

---

## Referencias

- Archivos del proyecto:
  - [chat bot/eliza.pl](chat%20bot/eliza.pl) - Implementación del sistema médico
  - [Prolog/](Prolog/) - Otros archivos Prolog de ejercicios

- Conceptos relacionados:
  - Unificación en Prolog
  - Backtracking automático
  - Sistemas expertos
  - Bases de hechos y reglas
  - Lógica de primer orden
