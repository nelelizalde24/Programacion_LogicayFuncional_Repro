# CLISP - Programación Funcional

## Índice

- [Introducción a CLISP](#introducción-a-clisp)
- [Conceptos Fundamentales](#conceptos-fundamentales)
- [Operadores Aritméticos y Expresiones](#operadores-aritméticos-y-expresiones)
- [Funciones Básicas](#funciones-básicas)
- [Control de Flujo](#control-de-flujo)
- [Operaciones con Listas](#operaciones-con-listas)
- [Funciones Definidas por el Usuario](#funciones-definidas-por-el-usuario)
- [Ejercicios y Actividades](#ejercicios-y-actividades)
- [Examen de Práctica](#examen-de-práctica)

---

## Introducción a CLISP

**CLISP** (Common Lisp) es un lenguaje de programación funcional potente y flexible. Se basa en el paradigma de programación funcional donde:
- Las funciones son objetos de primera clase
- Los datos se representan como listas
- La evaluación es el mecanismo principal de ejecución

### Características principales:
- **Lenguaje interpretado**: Se ejecuta línea a línea
- **Manejo de listas**: Las listas son la estructura de datos fundamental
- **Funciones de orden superior**: Las funciones pueden recibir y retornar funciones
- **Recursión**: Herramienta clave para resolver problemas
- **Síntesis de programas**: Código que genera código

### Instalación y Ejecución

Para ejecutar archivos en CLISP desde la línea de comandos:
```bash
clisp archivo.lsp
```

O de forma interactiva:
```bash
clisp
[1]> (load "archivo.lsp")
[2]> (nombre_funcion parámetros)
```

---

## Conceptos Fundamentales

### Símbolos y Valores

En CLISP, los símbolos son identificadores que representan conceptos:
```lisp
; Símbolos simples
juan
maria
gato

; Números
42
3.14
-10

; Cadenas
"Hola mundo"
"Sistema experto"
```

### Variables y Asignación

```lisp
; setq: asigna un valor a una variable
(setq nombre "Juan")
(setq edad 25)
(setq lista '(1 2 3 4 5))

; defparameter: define parámetros globales
(defparameter *contador* 0)
(defparameter *lista-personas* '(juan maria carlos))

; let: define variables locales
(let ((x 10) (y 20))
  (+ x y))  ; => 30
```

### Evaluación y Cita

```lisp
; Evaluación normal
(+ 2 3)  ; => 5

; Cita (quote): previene la evaluación
'juan           ; => juan (no lo evalúa)
'(1 2 3)        ; => (1 2 3) lista literal
'(+ 2 3)        ; => (+ 2 3) expresión sin evaluar

; Backquote y coma para templating
`(persona ,nombre edad ,edad)  ; interpola variables
```

---

## Operadores Aritméticos y Expresiones

### Notación Prefija

CLISP usa notación prefija (operador primero):
```lisp
; Suma
(+ 2 3)        ; => 5
(+ 1 2 3 4 5)  ; => 15

; Resta
(- 10 3)       ; => 7
(- 20 5 3)     ; => 12

; Multiplicación
(* 4 5)        ; => 20
(* 2 3 4)      ; => 24

; División
(/ 20 4)       ; => 5
(/ 100 3)      ; => 33.333...

; Potencia
(expt 2 3)     ; => 8 (2^3)

; Resto/Módulo
(mod 10 3)     ; => 1
(rem 10 3)     ; => 1
```

### Árboles Binarios de Expresiones

La expresión `3 * 3 + 2 - 3 + 10 / 2 = 5` se representa como:

```
        +
       / \
      +   /
     / \ / \
    -  2 10 2
   / \
  *   3
 / \
3   3
```

En CLISP (notación prefija):
```lisp
(+ (- (+ (* 3 3) 2) 3) (/ 10 2))  ; => 5
```

### Ejemplos de Expresiones Complejas

```lisp
; 6 + 4 * 7 + 5 + 6 + 3 + 2 - 3
(+ (+ (+ (+ (+ 6 (* 4 7)) 5) 6) 3) 2) 3)  ; => 40

; 6 + 12 + 9 + 8 * 3 * 6 * 2 + 2
(+ (+ (+ 6 12) 9) (* (* (* 8 3) 6) 2) 2)  ; => 323

; 6 / 2 * 5 + 6 * 3 + 9 + 8 + 9
(+ (+ (+ (* (/ 6 2) 5) (* 6 3)) 9) 8) 9)  ; => 68
```

---

## Funciones Básicas

### Funciones de E/S (Entrada/Salida)

```lisp
; princ: imprime sin salto de línea
(princ "Hola")           ; => Holanil

; format: imprime formateado
(format t "Hola ~a~%" nombre)      ; t = salida estándar
(format t "Número: ~d~%" 42)       ; ~d para números enteros
(format t "Real: ~f~%" 3.14)       ; ~f para decimales

; writeln: escribe con salto de línea
(writeln "Mensaje")

; read: lee una expresión Lisp
(setq x (read))         ; espera entrada del usuario

; read-line: lee una línea de texto
(setq nombre (read-line))
```

### Operadores Lógicos

```lisp
; and: AND lógico
(and t t)              ; => t (verdadero)
(and t nil)            ; => nil (falso)
(and (> 5 3) (< 2 4))  ; => t

; or: OR lógico
(or nil nil)           ; => nil
(or t nil)             ; => t
(or (< 5 3) (> 10 5))  ; => t

; not: negación
(not t)                ; => nil
(not nil)              ; => t
(not (= 5 5))          ; => nil
```

### Operadores Relacionales

```lisp
; Igualdad y comparación numérica
(= 5 5)               ; => t
(= 5 6)               ; => nil
(> 10 5)              ; => t
(< 3 8)               ; => t
(>= 5 5)              ; => t
(<= 3 5)              ; => t
(/= 5 3)              ; => t (no igual)

; Comparación de símbolos
(eq 'juan 'juan)      ; => t
(eql 'juan 'juan)     ; => t
(equal '(1 2) '(1 2)) ; => t
```

---

## Control de Flujo

### if - Condicional Simple

```lisp
; Sintaxis: (if condición valor-verdadero valor-falso)
(if (> 5 3)
    (format t "5 es mayor que 3~%")
    (format t "5 no es mayor que 3~%"))

; if con múltiples acciones (requiere progn)
(if (< edad 18)
    (progn
      (format t "Eres menor de edad~%")
      (format t "No puedes votar~%"))
    (format t "Puedes votar~%"))
```

### when - Cuando la Condición es Verdadera

```lisp
; when: ejecuta acciones si la condición es verdadera
; (equivalente a if sin rama falsa, pero permite múltiples acciones sin progn)
(when (> edad 18)
  (format t "Eres mayor de edad~%")
  (format t "Tienes responsabilidades legales~%"))

(when (string= nombre "")
  (format t "El nombre no puede estar vacío~%"))
```

### unless - Cuando la Condición es Falsa

```lisp
; unless: ejecuta acciones si la condición es FALSA
; (negación de when)
(unless (< edad 18)
  (format t "Eres mayor de edad~%"))

(unless (= saldo 0)
  (format t "Tienes dinero disponible~%"))
```

### cond - Múltiples Condiciones

```lisp
; cond: permite múltiples condiciones (como switch/case)
(cond
  ((< edad 13) (format t "Eres un niño~%"))
  ((< edad 18) (format t "Eres un adolescente~%"))
  ((< edad 65) (format t "Eres un adulto~%"))
  (t (format t "Eres un adulto mayor~%")))  ; t es la opción por defecto
```

### case - Selección por Valor

```lisp
; case: selecciona según el valor de una expresión
(case dia
  ((lunes martes miercoles jueves viernes) 
    (format t "Día laboral~%"))
  ((sabado domingo) 
    (format t "Fin de semana~%"))
  (otherwise 
    (format t "Día desconocido~%")))
```

---

## Operaciones con Listas

### Funciones de Acceso

```lisp
; car: primer elemento
(car '(1 2 3 4 5))        ; => 1
(car '(a b c))            ; => a

; cdr: resto de la lista (todos menos el primero)
(cdr '(1 2 3 4 5))        ; => (2 3 4 5)
(cdr '(a b c))            ; => (b c)

; Combinaciones:
; caar: car del car
(caar '((1 2) 3 4))       ; => 1

; cadr: car del cdr (segundo elemento)
(cadr '(a b c))           ; => b

; caddr: tercer elemento
(caddr '(a b c d))        ; => c

; cadddr: cuarto elemento
(cadddr '(a b c d e))     ; => d
```

### Construcción de Listas

```lisp
; append: concatena listas
(append '(1 2) '(3 4))           ; => (1 2 3 4)
(append '(a b) '(c d) '(e f))    ; => (a b c d e f)

; cons: construye una lista (agrega elemento al inicio)
(cons 1 '(2 3 4))        ; => (1 2 3 4)
(cons 'a '(b c))         ; => (a b c)

; list: crea una nueva lista
(list 1 2 3)             ; => (1 2 3)
(list 'a 'b 'c)          ; => (a b c)

; length: obtiene el largo de una lista
(length '(a b c))        ; => 3
(length '(1 2 3 4 5))    ; => 5
```

### Búsqueda en Listas

```lisp
; member: verifica si un elemento está en la lista
(member 2 '(1 2 3 4))           ; => (2 3 4)
(member 'b '(a b c))            ; => (b c)
(member 5 '(1 2 3 4))           ; => nil

; assoc: busca en lista de asociación (pares clave-valor)
(setq persona '((nombre . "Juan") (edad . 25) (ciudad . "Madrid")))
(assoc 'nombre persona)         ; => (nombre . "Juan")
(cdr (assoc 'edad persona))     ; => 25

; mapcar: aplica una función a cada elemento
(mapcar #'(lambda (x) (* x 2)) '(1 2 3 4))  ; => (2 4 6 8)
(mapcar #'abs '(-1 -2 3 -4))                ; => (1 2 3 4)
```

### Ejemplo: Actividad de car y cdr

Dada la lista `(a b (d l) (c x) m n)`:

```lisp
; Obtener (d l)
(cadddr '(a b (d l) (c x) m n))         ; => (d l)

; Obtener x
(car (cdr (car (cddddr '(a b (d l) (c x) m n)))))  ; => x

; Obtener d
(car (cadddr '(a b (d l) (c x) m n)))   ; => d
```

---

## Funciones Definidas por el Usuario

### defun - Definir Funciones

```lisp
; Sintaxis: (defun nombre (parámetros) cuerpo)

; Función simple
(defun suma (a b)
  (+ a b))

(suma 5 3)  ; => 8

; Función con múltiples operaciones
(defun area-rectangulo (ancho alto)
  (* ancho alto))

(area-rectangulo 5 10)  ; => 50

; Función recursiva: Factorial
(defun factorial (x)
  (if (= x 0)
    1
    (* x (factorial (- x 1)))))

(factorial 5)  ; => 120

; Función recursiva: Fibonacci
(defun fibonacci (x)
  (if (< x 2)
    1
    (+ (fibonacci (- x 1)) (fibonacci (- x 2)))))

(fibonacci 6)  ; => 13

; Potencia con multiplicaciones recursivas
(defun potencia (base exponente)
  (if (= exponente 0)
    1
    (* base (potencia base (- exponente 1)))))

(potencia 2 8)  ; => 256

; División usando restas
(defun division (dividendo divisor)
  (if (< dividendo divisor)
    0
    (+ 1 (division (- dividendo divisor) divisor))))

(division 20 3)  ; => 6
```

### Funciones con Condicionales

```lisp
; Función con if
(defun es-positivo (n)
  (if (> n 0)
    (format t "~a es positivo~%" n)
    (format t "~a no es positivo~%" n)))

; Función con when
(defun paga-impuesto (ingresos)
  (when (> ingresos 30000)
    (format t "Debes pagar impuestos~%")))

; Función con unless
(defun acceso-permitido (edad)
  (unless (< edad 18)
    (format t "Puedes entrar~%")))

; Función con cond
(defun clasifica-numero (n)
  (cond
    ((< n 0) "Negativo")
    ((= n 0) "Cero")
    ((< n 10) "Pequeño")
    ((< n 100) "Mediano")
    (t "Grande")))

(clasifica-numero 57)  ; => "Mediano"
```

---

## Ejercicios y Actividades

### Actividad 1: Validar Paréntesis

Crear una función que valide si una cadena de paréntesis está balanceada:

```lisp
(defun validar-parentesis (cadena)
  (let ((contador 0))
    (loop for char across cadena
      do (cond
           ((char= char #\() (incf contador))
           ((char= char #\)) (decf contador))))
    (= contador 0)))

(validar-parentesis "((()))")      ; => T
(validar-parentesis "())()()")     ; => NIL
```

### Actividad 2: Descomposición en Sumas

Crear un algoritmo que imprima todas las posibles descomposiciones de un número como suma de números menores:

```lisp
; Ejemplo: 5 se descompone como:
; 5
; 4 + 1
; 3 + 2
; 3 + 1 + 1
; 2 + 2 + 1
; 2 + 1 + 1 + 1
; 1 + 1 + 1 + 1 + 1
```

### Actividad 3: Sueldo de Trabajador

Calcular el sueldo con aumento según antigüedad:

```lisp
(defun calcular-sueldo (antiguedad)
  (let ((sueldo-base 40000)
        (aumento 0))
    (cond
      ((>= antiguedad 10) (setq aumento 0.10))
      ((>= antiguedad 5) (setq aumento 0.07))
      ((>= antiguedad 3) (setq aumento 0.05))
      (t (setq aumento 0.03)))
    (+ sueldo-base (* sueldo-base aumento))))

(calcular-sueldo 12)  ; => 44000
(calcular-sueldo 2)   ; => 41200
```

### Actividad 4: Nivel de Lavadora

```lisp
(defun nivel-lavadora (peso-libras)
  (cond
    ((>= peso-libras 30) "ERROR: Limite excedido")
    ((>= peso-libras 22) "MÁXIMO: 150 litros")
    ((>= peso-libras 15) "ALTO: 120 litros")
    ((>= peso-libras 8)  "MEDIO: 80 litros")
    (t "MÍNIMO: 40 litros")))

(nivel-lavadora 25)   ; => "MÁXIMO: 150 litros"
(nivel-lavadora 10)   ; => "MEDIO: 80 litros"
```

### Actividad 5: Control de Acceso a Fiesta

```lisp
(defun acceso-fiesta (edad)
  (cond
    ((> edad 15) "Puedes entrar pero con regalo")
    ((= edad 15) "Puedes entrar totalmente gratis")
    (t "No está permitido tu pase a la fiesta")))

(acceso-fiesta 16)  ; => "Puedes entrar pero con regalo"
(acceso-fiesta 15)  ; => "Puedes entrar totalmente gratis"
(acceso-fiesta 14)  ; => "No está permitido tu pase a la fiesta"
```

---

## Examen de Práctica

### Preguntas Teóricas

**1. Diferencias entre if, cond, when y unless:**

| Estructura | Uso | Características |
|-----------|-----|-----------------|
| `if` | Dos ramas (verdadero/falso) | Requiere `progn` para múltiples acciones |
| `cond` | Múltiples condiciones | Permite más de 2 opciones |
| `when` | Solo rama verdadera | Permite múltiples acciones sin `progn` |
| `unless` | Rama falsa | Negación de `when` |

**2. car vs cdr:**

- `car`: Retorna el primer elemento de una lista
- `cdr`: Retorna el resto de la lista (sin el primer elemento)
- Combinaciones: `caar`, `cadr`, `caddr`, `cadddr`, etc.

### Ejercicios Resueltos

#### Ejercicio 1: N-ésimo Elemento

```lisp
(defun n-esimo (n lista)
  (if (= n 1)
    (car lista)
    (n-esimo (- n 1) (cdr lista))))

(n-esimo 3 '(a b c d e))  ; => c
```

#### Ejercicio 2: Filtrar Positivos

```lisp
(defun filtra-positivos (lista)
  (mapcar #'(lambda (x) (when (> x 0) x))
          lista))

(filtra-positivos '(-2 0 3 -5 7))  ; => (nil nil 3 nil 7)

; Versión mejorada que realmente filtra:
(defun filtra-positivos-v2 (lista)
  (remove-if-not #'(lambda (x) (> x 0)) lista))

(filtra-positivos-v2 '(-2 0 3 -5 7))  ; => (3 7)
```

#### Ejercicio 3: Clasificación de Números

```lisp
(defun clasifica-numero (n)
  (cond
    ((< n 0) "Negativo")
    ((= n 0) "Cero")
    ((<= n 10) "Pequeño")
    ((<= n 100) "Mediano")
    (t "Grande")))

(clasifica-numero -5)   ; => "Negativo"
(clasifica-numero 0)    ; => "Cero"
(clasifica-numero 7)    ; => "Pequeño"
(clasifica-numero 57)   ; => "Mediano"
(clasifica-numero 500)  ; => "Grande"
```

#### Ejercicio 4: Suma de Pares

```lisp
(defun suma-pares (lista)
  (let ((suma 0))
    (dolist (n lista suma)
      (unless (oddp n)
        (setq suma (+ suma n))))))

(suma-pares '(1 2 3 4 5 6))  ; => 12

; Versión con recursión:
(defun suma-pares-rec (lista)
  (if (null lista)
    0
    (let ((n (car lista)))
      (if (evenp n)
        (+ n (suma-pares-rec (cdr lista)))
        (suma-pares-rec (cdr lista))))))
```

#### Ejercicio 5: Procesamiento de Listas

```lisp
(defun procesa-lista (lista)
  (cond
    ((null lista) "Lista vacía")
    ((numberp (car lista))
     (if (> (car lista) 50)
       "Grande"
       "Pequeño"))
    ((listp (car lista)) "Sublista detectada")
    (t "Caso general")))

(procesa-lista '())              ; => "Lista vacía"
(procesa-lista '(60 1 2))        ; => "Grande"
(procesa-lista '((1 2) 3 4))     ; => "Sublista detectada"
(procesa-lista '(10 20 30))      ; => "Pequeño"
```

---

## Problemas Clásicos y Desafíos

### Problema 1: Cruzar el Puente con Linterna

**Problema**: Cuatro personas necesitan cruzar un puente de noche con una sola linterna. El puente solo puede soportar a dos personas a la vez. Cada persona tarda diferentes tiempos en cruzar (1, 2, 5 y 10 minutos). Cuando dos personas cruzan, lo hacen al ritmo del más lento.

**Pregunta**: ¿Cómo pueden todos cruzar el puente en 17 minutos?

**Solución**:
```
Personas: X₁=1min, X₂=2min, X₃=5min, X₄=10min

Paso 1: X₁ y X₂ cruzan → 2 minutos (X₂ es el más lento)
Paso 2: X₁ regresa → 1 minuto
Paso 3: X₃ y X₄ cruzan → 10 minutos (X₄ es el más lento)
Paso 4: X₂ regresa → 2 minutos
Paso 5: X₁ y X₂ cruzan → 2 minutos

Total: 2 + 1 + 10 + 2 + 2 = 17 minutos ✓
```

### Problema 2: Las Cinco Casas (Acertijo de Einstein)

**Problema**: En una calle hay cinco casas de colores diferentes. En cada casa vive una persona de una nacionalidad distinta. Cada propietario bebe una bebida única, fuma una marca de cigarrillos diferente y tiene una mascota distinta.

**Pistas**:
1. El británico vive en la casa roja
2. El sueco tiene un perro
3. El danés bebe té
4. El noruego vive en la primera casa
5. El alemán fuma Prince
6. La casa verde está inmediatamente a la izquierda de la blanca
7. El dueño de la casa verde bebe café
8. El propietario que fuma Pall Mall cría pájaros
9. El dueño de la casa amarilla fuma Dunhill
10. El hombre del centro bebe leche
11. El fumador de Blends vive al lado del que tiene un gato
12. El que tiene un caballo vive al lado del fumador de Dunhill
13. El fumador de Bluemaster bebe cerveza
14. El fumador de Blends vive al lado del que bebe agua
15. El noruego vive al lado de la casa azul

**Pregunta**: ¿Quién es el dueño del pez?

**Respuesta**: El ALEMÁN es el dueño del pez.

### Problema 3: El Granjero, el Coyote, el Pollo y el Maíz

**Problema**: Un granjero necesita cruzar un río con un coyote, un pollo y maíz. Su bote solo puede llevar al granjero y un item a la vez. Además:
- El coyote se come al pollo si los deja solos
- El pollo se come el maíz si los deja solos
- El coyote no se come el maíz

**Pregunta**: ¿Cómo cruzan todos el río?

**Solución**:
```
Inicial: [G, C, P, M] | []

1. G y P cruzan → [C, M] | [G, P]
2. G regresa    → [G, C, M] | [P]
3. G y C cruzan → [M] | [G, C, P]
4. G y P regresan → [G, P, M] | [C]
5. G y M cruzan → [P] | [G, C, M]
6. G regresa    → [G, P] | [C, M]
7. G y P cruzan → [] | [G, C, P, M] ✓
```

---

## Arboles de Búsqueda y Listas de Asociación

### Listas de Asociación (Alist)

Una lista de asociación es una estructura que almacena pares clave-valor:

```lisp
; Definición de lista de asociación
(setq persona '((nombre . "Juan") 
                (edad . 25) 
                (ciudad . "Madrid")
                (profesion . "Programador")))

; Acceso con assoc
(assoc 'nombre persona)          ; => (nombre . "Juan")
(assoc 'edad persona)            ; => (edad . 25)

; Obtener solo el valor con cdr
(cdr (assoc 'edad persona))      ; => 25
(cdr (assoc 'ciudad persona))    ; => "Madrid"
```

### Ejemplo: Base de Datos de Nodos

```lisp
(defparameter *nodes* 
  '((living-room 
      (You are in the living-room. A wizard is snoring loudly on the couch.))
    (garden 
      (You are in a beautiful garden. There is a well in front of you.))
    (attic 
      (You are in the attic. There is a giant welding torch in the corner.))))

; Acceder a nodos
(assoc 'garden *nodes*)
; => (GARDEN (YOU ARE IN A BEAUTIFUL GARDEN. ...))

; Obtener descripción
(cadr (assoc 'garden *nodes*))
; => (YOU ARE IN A BEAUTIFUL GARDEN. THERE IS A WELL IN FRONT OF YOU.)
```

### Árbol Genealógico

```lisp
; Base de datos de relaciones familiares
(defparameter *familia* 
  '((juan (padre-de (carlos maria)))
    (carlos (padre-de (luis)))
    (maria (padre-de (ana pablo)))
    (luis (padre-de ()))
    (ana (padre-de ()))
    (pablo (padre-de ()))))

; Función para obtener hijos
(defun obtener-hijos (persona familia)
  (cadr (assoc persona familia)))

(obtener-hijos 'juan *familia*)    ; => (CARLOS MARIA)
(obtener-hijos 'carlos *familia*)  ; => (LUIS)
```

---

## Archivos de Ejemplo del Proyecto

Los siguientes archivos contienen implementaciones prácticas:

- **arbologenalogico.lsp** - Implementación de árbol genealógico
- **AreaVolumen.lsp** - Cálculos de área y volumen
- **ejercicioClisp.lsp** - Ejercicios varios
- **introClisp.lsp** - Introducción y conceptos básicos

Todos estos archivos se encuentran en la carpeta `Clisp/` del proyecto.

---







**Lista de Asociacion**

Es una lista dentro de una lista dentro de una lista

```lisp
(detparameter *nodes* '(
                          (femenino (
                                     (fuego (azula . "maestra fuego"))
                                     (tierra (top))
                                     (agua (karata))
                                    )
                          )
                         (masculino ( 
                                      (aire (Hola rayo masculino))
                                      (fuego (Hola fuego))
                                      (tierra (hola tierra))
                                      (agua (poder de agua))
                                    )
                         
                         )
                         (ovni (
                                (aire (alto))
                                (fuego (hola fuego))
                                (tierra (hola tierra))
                              )
                         
                         )
                       )
)
```
(Arboles de busqueda, busqueda a lo ancho)

---

**Actividad Arbol genealogico**

[arbolGenealogico](Codigo/arbologenalogico.lsp)


---
**Actividad De Funciones** 

[FuncionesAct](actividadesFunLog.pdf)

  1. **Problemas con car y cdr**

      ```
      Lista: (a b c d e) → d               R: (cadddr '(a b c d e))
      
      Lista: ((1 2) (3 4) (5 6)) → 5       R: (caaddr '((1 2) (3 4) (5 6)))

      Lista: ((a b) (c d) (e f)) → e       R: (caaddr '((a b) (c d) (e f)))

      Lista: ((x y) ((p q) (r s)) (z w)) → z  R: (caaddr '((x y) ((p q) (r s)) (z w)))

      Lista: ((1 (2 3)) (4 (5 6))) → 6     R: (cadr (cadadr '((1 (2 3)) (4 (5 6)))))

      Lista: (((a b) c) d e) → c           R: (cadar '(((a b) c) d e))

      Lista: (((1 2) 3) ((4 5) 6)) → 6     R: (cadadr '(((1 2) 3) ((4 5) 6)))

      Lista: ((p (q (r s))) t u) → (r s)   R: (car (cdadar '((p (q (r s))) t u)))

      Lista: (((a) b) (c (d e)) f) → d     R: (car (cadadr '(((a) b) (c (d e)) f)))

      Lista: ((1 (2 (3 4))) (5 6)) → 3     R: (caar (cdadar '((1 (2 (3 4))) (5 6))))

      Lista: (((x) (y)) ((z) (w))) → (w)   R: (cadadr '(((x) (y)) ((z) (w))))

      Lista: ((a (b (c d))) (e f)) → c     R: (caar (cdadar '((a (b (c d))) (e f))))

      Lista: ((1 (2 (3 (4 5)))) (6 7)) → 4 R: (caadar (cdadar '((1 (2 (3 (4 5)))) (6 7))))

      Lista: (((a b) c) ((d e) f) ((g h) i)) → g  R: (car (caaddr '(((a b) c) ((d e) f) ((g h) i))))

      Lista: (((x y) (z w)) ((p q)(r s))) → r   R:  (car (cadadr '(((x y) (z w)) ((p q)(r s)))))

      Lista: ((1 (2 (3 (4 (5 6))))) (7 8)) → 5  R:  (caar(cdadar (cdadar '((1 (2 (3 (4 (5 6))))) (7 8)))))

      Lista: ((a (b (c (d e)))) (f g)) → d  R: (caadar (cdadar '((a (b (c (d e)))) (f g))))

      Lista: (((1 2) (3 4)) ((5 6) (7 8))) → 7   R: (car (cadadr '(((1 2) (3 4)) ((5 6) (7 8)))))

      Lista: ((x (y (z (w v))))) → w  R: (caadar (cdadar '((x (y (z (w v)))))))

      Lista: (((a b c) (d e f)) ((g h i) (j k l))) → j  R: (car (cadadr '(((a b c) (d e f)) ((g h i) (j k l)))))

      ```


  2. **Ejercicios de lisp**

     **2.1 Ejercicio 1**

     Dada una lista de pares clave-valor, usar ‘assoc‘ para obtener el valor de la
     clave ‘’edad‘. Lista de ejemplo:

      (setq persona '((nombre . "Ana") (edad . 23) (ciudad . "Morelia")))

      Pregunta: ¿cómo obtener la edad con ‘assoc‘, ‘cdr‘ y ‘car‘?

      ```lisp
      (cdr (assoc 'edad persona))

      ```
      **2.2 Ejercicio 2**

       Usar ‘if‘ para escribir una función que diga si el primer elemento de una lista
       es un número positivo o no. Ejemplo:

       (mi-funcion '(5 3 2)) ; => "positivo"

       (mi-funcion '(-2 1 4)) ; => "no positivo"
       
       ```lisp
        (defun numpositivo (lista)
          (if (> (car lista) 0) 
                (format t "Es positivo el primer numero de la lista ~a ~%" (car lista))
                (format t "Es negativo el primer numero de la lista ~a ~%" (car lista))
          )
        )

        (defparameter *nodes* '(5 3 2))
       ```

       **2.3 Ejercicio 3**

        Definir una función que recorra una lista de números con ‘mapcar‘ y devuelva
        una nueva lista que contenga solo el doble de los números pares. Restricción:
        usar ‘if‘ dentro de ‘mapcar‘.

       **2.4 Ejercicio 4**

        Usar ‘cond‘ para hacer una función que reciba un símbolo que puede ser
        ‘rojo‘, ‘azul‘ o ‘verde‘ y regrese un mensaje:

         • rojo → "Color cálido"
         • azul → "Color frío"
         • verde → "Color neutro"
         • cualquier otro → "Color desconocido"

       **2.5 Ejercicio 5**

        Escribir una función que use ‘case‘ para clasificar un día de la semana (‘lunes‘,
        ‘martes‘, ...):

         • lunes a viernes → "día laboral"
         • sábado, domingo → "fin de semana"

       **2.6 Ejercicio 6**

        Definir una función que reciba una lista y con ‘when‘ imprima el primer
        elemento si la lista no está vacía.

       **2.7 Ejercicio 7**

        Definir una función que reciba una lista y con ‘unless‘ imprima "lista vacía"
        cuando la lista no tenga elementos

       **2.8 Ejercicio 8**

        Dada una lista de listas, usar ‘mapcar‘, ‘car‘ y ‘cdr‘ para obtener una nueva
        lista con los primeros elementos de cada sublista. 
        
        Ejemplo:(mi-funcion '((1 2) (3 4) (5 6))) ; => (1 3 5).

       **2.9 Ejercicio 9**

        Dada una lista de asociación:

         (setq alumnos '((juan . 8) (maria . 10) (ana . 9)))

         Escribir una función que, dado un nombre, devuelva "Aprobado" si la calificación es >= 8, o "Reprobado" en caso contrario. 
         Usar ‘assoc‘, ‘cdr‘ y ‘if‘


       **2.10 Ejercicio 10**

       Definir una función que use ‘cond‘ para evaluar una lista de números y de volver:

         • "vacía" si no hay elementos,
         • "un solo elemento" si la lista tiene uno,
         • "larga" si tiene más de uno.


**Examen de Practica Lisp**

   **Instrucciones.**

   Responde a cada ejercicio escribiendo las funciones en Lisp.

   1. Explica la diferencia entre usar ‘if‘, ‘cond‘, ‘when‘ y ‘unless‘.
   2. ¿Qué devuelven ‘car‘ y ‘cdr‘? ¿Cómo se pueden combinar para obtener elementos intermedios de una lista?

   **Ejercicio 1 - N-ésimo elemento con car/cdr**

   Escribe una funcion '(n-esimo n lista)' que devuelva el n-esimo elemento de una lista utilizando solo 'car' y 'cdr'.

   Ejemplo:  (n-esimo 3 '(a b c d e)) ;; => c

   **Ejercicio 2 - Filtrar positivos con when**

   Escribe una función ‘(filtra-positivos lista)‘ que reciba una lista de números y devuelva una nueva lista con solo los números positivos. Usa ‘when‘ dentro de un ‘mapcar‘ o ‘loop‘.

   Ejemplo: (filtra-positivos '(-2 0 3-5 7)) ;; => (3 7)

   **Ejercicio 3 - Clasificacion con cond** 

   Escribe una función ‘(clasifica-numero n)‘ que:

    • Devuelva ‘"Negativo"‘ si n < 0
    • Devuelva ‘"Cero"‘ si n = 0
    • Devuelva ‘"Pequeño"‘ si 1 <= n <= 10
    • Devuelva ‘"Mediano"‘ si 11 <= n <= 100
    • Devuelva ‘"Grande"‘ si n > 100
    Ejemplo:
    (clasifica-numero 57) ;; => "Mediano"


   **Ejercicio 4 - Suma de pares con unless**

   Escribe una función ‘(suma-pares lista)‘ que:

    • Devuelva la suma de todos los números pares en la lista.
    • Ignore los impares usando ‘unless‘.
    Ejemplo:
    (suma-pares '(1 2 3 4 5 6)) ;; => 12


   **Ejercicio 5 - Procesamiento de car y cdr**

   Escribe una función ‘(procesa-lista lista)‘ que:

    1. Si la lista está vacía → devuelve ‘"Lista vacía"‘.
    2. Si el primer elemento (‘car‘) es un número mayor a 50 → devuelve ‘"Grande"‘.
    3. Si el primer elemento es una sublista → devuelve ‘"Sublista detectada"‘.
    4. En cualquier otro caso → devuelve ‘"Caso general"‘.
    Ejemplos:
    (procesa-lista '()) ;; => "Lista vacía"
    (procesa-lista '(60 1 2)) ;; => "Grande"
    (procesa-lista '((1 2) 3 4)) ;; => "Sublista detectada"
    (procesa-lista '(10 20 30)) ;; => "Caso general"

---
