;;; ================================================================
;;; ÁRBOL GENEALÓGICO MEJORADO
;;; ================================================================

;;; Base de datos de personas con sus características
(defparameter *personas* '(
    ;; FAMILIA MATERNA (MADRE FEMENINO)
    (luvia :genero femenino :relacion tia :lado familia_mama :caracteristicas (gorda peloNegro tesBlanca))
    (flor :genero femenino :relacion tia :lado familia_mama :caracteristicas (delgada peloCastano tesBlanca))
    (yaneri :genero femenino :relacion prima :lado familia_mama :caracteristicas (delgada peloNegro tesBlanca))
    
    ;; FAMILIA PATERNA (PADRE FEMENINO)
    (lorena :genero femenino :relacion tia :lado familia_papa :caracteristicas (delgada tesBlanca alta))
    (chuy :genero femenino :relacion tia :lado familia_papa :caracteristicas (delgada tesMorena alta))
    (mima :genero femenino :relacion tia :lado familia_papa :caracteristicas (delgada tesMorena alta))
    (gaby :genero femenino :relacion tia :lado familia_papa :caracteristicas (gorda tesMorena alta))
))

;;; Función para buscar una persona por nombre
(defun buscar-persona (nombre)
  (find nombre *personas* :key #'car))

;;; Función para mostrar información de una persona
(defun mostrar-persona (nombre)
  (let ((persona (buscar-persona nombre)))
    (if persona
        (progn
          (format t "~%=== Información de ~a ===~%" nombre)
          (format t "Género: ~a~%" (getf (cdr persona) :genero))
          (format t "Relación: ~a~%" (getf (cdr persona) :relacion))
          (format t "Lado: ~a~%" (getf (cdr persona) :lado))
          (format t "Características: ~a~%" (getf (cdr persona) :caracteristicas)))
        (format t "Persona ~a no encontrada.~%" nombre))))

;;; Función para listar todas las personas
(defun listar-todas-personas ()
  (format t "~%=== LISTA DE TODAS LAS PERSONAS ===~%")
  (dolist (persona *personas*)
    (format t "~%- ~a~%" (car persona))
    (format t "  Relación: ~a~%" (getf (cdr persona) :relacion))
    (format t "  Lado: ~a~%" (getf (cdr persona) :lado))
    (format t "  Características: ~a~%" (getf (cdr persona) :caracteristicas))))

;;; Función para obtener personas por lado (familia_mama o familia_papa)
(defun personas-por-lado (lado)
  (format t "~%=== FAMILIA POR LADO: ~a ===~%" lado)
  (dolist (persona *personas*)
    (when (eq (getf (cdr persona) :lado) lado)
      (format t "~%- ~a (~a)~%" (car persona) (getf (cdr persona) :relacion))
      (format t "  Características: ~a~%" (getf (cdr persona) :caracteristicas)))))

;;; Función para obtener personas por relación (tia, prima, etc.)
(defun personas-por-relacion (relacion)
  (format t "~%=== PERSONAS CON RELACIÓN: ~a ===~%" relacion)
  (dolist (persona *personas*)
    (when (eq (getf (cdr persona) :relacion) relacion)
      (format t "~%- ~a~%" (car persona))
      (format t "  Lado: ~a~%" (getf (cdr persona) :lado))
      (format t "  Características: ~a~%" (getf (cdr persona) :caracteristicas)))))

;;; Función para búsqueda interactiva por características
(defun buscar-por-caracteristicas (caracteristica)
  (format t "~%=== PERSONAS CON CARACTERÍSTICA: ~a ===~%" caracteristica)
  (let ((encontradas nil))
    (dolist (persona *personas*)
      (when (member caracteristica (getf (cdr persona) :caracteristicas))
        (push (car persona) encontradas)))
    (if encontradas
        (format t "~{~a~^, ~}~%" encontradas)
        (format t "No se encontraron personas con esa característica.~%"))))

;;; Función para árbol genealógico visual
(defun mostrar-arbol-genealogico ()
  (format t "~%╔════════════════════════════════════════════════════════╗~%")
  (format t "║         ÁRBOL GENEALÓGICO DE LA FAMILIA              ║~%")
  (format t "╚════════════════════════════════════════════════════════╝~%")
  
  (format t "~%📍 FAMILIA MATERNA (Lado Madre):~%")
  (format t "┌─────────────────────────────────────────────────────┐~%")
  (personas-por-lado 'familia_mama)
  (format t "└─────────────────────────────────────────────────────┘~%")
  
  (format t "~%📍 FAMILIA PATERNA (Lado Padre):~%")
  (format t "┌─────────────────────────────────────────────────────┐~%")
  (personas-por-lado 'familia_papa)
  (format t "└─────────────────────────────────────────────────────┘~%"))

;;; Función para menú interactivo
(defun menu-principal ()
  (loop
    (format t "~%╔════════════════════════════════════════════════════════╗~%")
    (format t "║       ÁRBOL GENEALÓGICO - MENÚ PRINCIPAL              ║~%")
    (format t "╠════════════════════════════════════════════════════════╣~%")
    (format t "║ 1. Ver árbol genealógico completo                     ║~%")
    (format t "║ 2. Listar todas las personas                          ║~%")
    (format t "║ 3. Buscar persona por nombre                          ║~%")
    (format t "║ 4. Ver personas por lado (familia_mama/familia_papa)  ║~%")
    (format t "║ 5. Ver personas por relación (tia, prima, etc.)       ║~%")
    (format t "║ 6. Buscar por característica                          ║~%")
    (format t "║ 7. Salir                                              ║~%")
    (format t "╚════════════════════════════════════════════════════════╝~%")
    (format t "Selecciona una opción: ")
    (let ((opcion (read)))
      (case opcion
        (1 (mostrar-arbol-genealogico))
        (2 (listar-todas-personas))
        (3 (progn
             (format t "Ingresa el nombre de la persona: ")
             (let ((nombre (read)))
               (mostrar-persona nombre))))
        (4 (progn
             (format t "Ingresa el lado (familia_mama o familia_papa): ")
             (let ((lado (read)))
               (personas-por-lado lado))))
        (5 (progn
             (format t "Ingresa la relación (tia o prima): ")
             (let ((relacion (read)))
               (personas-por-relacion relacion))))
        (6 (progn
             (format t "Ingresa la característica (gorda, delgada, peloNegro, peloCastano, tesBlanca, tesMorena, alta, chaparra): ")
             (let ((caracteristica (read)))
               (buscar-por-caracteristicas caracteristica))))
        (7 (progn
             (format t "~%¡Hasta luego!~%")
             (return)))
        (otherwise (format t "Opción no válida. Intenta de nuevo.~%"))))))

;;; Función para iniciar el programa
(defun iniciar ()
  (format t "~%¡Bienvenido al Árbol Genealógico!~%")
  (menu-principal))

;;; Para ejecutar: (iniciar)
