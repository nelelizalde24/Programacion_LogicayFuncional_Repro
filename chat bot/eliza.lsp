;;; ====================================================================
;;; ELIZA CHATBOT EN COMMON LISP
;;; Sistema de conversación con integración médica
;;; ====================================================================

;;; ====================================================================
;;; BASE DE DATOS DE ENFERMEDADES Y SÍNTOMAS
;;; ====================================================================

;; Definición de enfermedades
(defvar *enfermedades* 
  '(tetanos varicela zika meningitis neumonia dengue_hemorragico))

;; Síntomas por enfermedad
(defvar *sintomas-enfermedad* 
  '((tetanos rigidez_mandibula espasmos_musculares trismo)
    (varicela ampollas_piel fiebre picazon_intensa)
    (zika fiebre_alta dolor_articulaciones erupciones_cutaneas)
    (meningitis fiebre_alta dolor_cabeza_severo rigidez_cuello confusion_mental nauseas)
    (neumonia fiebre_alta tos_persistente dificultad_respiratoria dolor_pecho)
    (dengue_hemorragico fiebre_alta sangrado_encias dolor_abdominal_intenso vomito_persistente debilidad_extrema)))

;; Tratamientos por enfermedad
(defvar *tratamientos*
  '((tetanos "Aplicar vacuna antitetanica, reposo absoluto, evitar movimientos bruscos y hospitalizacion en caso grave")
    (varicela "Antivirales como aciclovir, mantener hidratacion, reposo y lociones calmantes para la picazon")
    (zika "Descanso prolongado, hidratacion constante, analgesicos para el dolor y consulta medica inmediata")
    (meningitis "URGENTE: Hospitalizacion inmediata, antibioticos intravenosos, monitoreo constante de signos vitales")
    (neumonia "Antibioticos, oxigenoterapia si es necesaria, reposo absoluto y hospitalizacion en casos graves")
    (dengue_hemorragico "EMERGENCIA: Hospitalizacion urgente, reposicion de liquidos intravenosos, transfusiones si es necesario")))

;; Gravedad de enfermedades
(defvar *gravedad-enfermedad*
  '((meningitis grave)
    (neumonia grave)
    (dengue_hemorragico grave)
    (tetanos moderada)
    (zika moderada)
    (varicela leve)))

;; Síntomas contradictorios
(defvar *sintomas-contradictorios*
  '((fiebre picazon_ojos)
    (nauseas estornudos)))

;; Base de datos de síntomas confirmados por paciente
;; Formato: (paciente (lista-de-sintomas))
(defvar *sintomas-paciente*
  '((juan (rigidez_mandibula espasmos_musculares))
    (maria (ampollas_piel fiebre picazon_intensa))
    (pedro (fiebre_alta dolor_articulaciones))))

;;; ====================================================================
;;; BASE DE DATOS DE GUSTOS Y ACTIVIDADES DE ELIZA
;;; ====================================================================

(defvar *eliza-likes*
  '(apples ponies zombies manzanas perros animales gatos 
    computadoras carros ejercicio deporte platicar viajar musica))

(defvar *eliza-does*
  '(study cook work))

(defvar *eliza-is*
  '(dumb weird nice fine happy redundant))

;;; ====================================================================
;;; BASE DE DATOS DE CANCIONES POR GÉNERO
;;; ====================================================================

(defvar *canciones*
  '((rock "Bohemian Rhapsody - Queen" "Hotel California - Eagles" 
         "Stairway to Heaven - Led Zeppelin" "Sweet Child O Mine - Guns N Roses"
         "Comfortably Numb - Pink Floyd" "Paint It Black - The Rolling Stones"
         "Smells Like Teen Spirit - Nirvana" "Black - Pearl Jam"
         "Purple Haze - Jimi Hendrix" "Imagine - John Lennon")
    (pop "Blinding Lights - The Weeknd" "Shape of You - Ed Sheeran"
         "Levitating - Dua Lipa" "Anti-Hero - Taylor Swift"
         "As It Was - Harry Styles" "Good as Hell - Lizzo"
         "Uptown Special - Billie Eilish" "Break My Soul - Beyonce"
         "Flowers - Miley Cyrus" "Love Me Like You Do - Ellie Goulding")
    (reggaeton "Gasolina - Daddy Yankee" "Tití Me Preguntó - Bad Bunny"
               "Ella Baila Sola - Eslabón Armado" "Dakiti - Bad Bunny"
               "Razones - A.Norme" "Mi Gente - J Balvin"
               "Con Altura - Rosalía" "Tití - Bad Bunny"
               "Perreo - Ivy Queen" "Yo No Eres Ni Roja Ni Morena - Enrique Iglesias")
    (hiphop "Lose Yourself - Eminem" "God s Plan - Drake"
            "Hotline Bling - Drake" "In da Club - 50 Cent"
            "Snooze - SZA" "No Role Modelz - J Cole"
            "HUMBLE - Kendrick Lamar" "One Dance - Drake"
            "Bad Guy - Billie Eilish" "Rap God - Eminem")
    (jazz "Take Five - Dave Brubeck" "Autumn Leaves - Bill Evans"
          "All the Things You Are - Charlie Parker" "Fly Me to the Moon - Frank Sinatra"
          "So What - Miles Davis" "Body and Soul - John Coltrane"
          "Giant Steps - John Coltrane" "My Favorite Things - John Coltrane"
          "Impressions - John Coltrane" "In a Sentimental Mood - Duke Ellington")
    (clasica "Moonlight Sonata - Beethoven" "Swan Lake - Tchaikovsky"
             "Canon in D - Pachelbel" "Fur Elise - Beethoven"
             "Eine kleine Nachtmusik - Mozart" "The Four Seasons - Vivaldi"
             "Clair de Lune - Debussy" "Nocturne Op 9 No 2 - Chopin"
             "Prelude in C Major - Bach" "Pathetique - Beethoven")
    (electronica "Kernkraft 400 - Zombie Nation" "Strobe - Deadmau5"
                 "Animals - Martin Garrix" "Clarity - Zedd"
                 "Titanium - David Guetta" "Scary Monsters and Nice Sprites - Skrillex"
                 "Hex Girlfriend - CHVRCHES" "Midnight City - M83"
                 "Alone - Alan Walker" "Levels - Avicii")
    (salsa "Lloraras - Oscar D Leon" "A Pedir Su Mano - Juan Luis Guerra"
           "Mi Gente - Willie Colón" "El Cantante - Hector Lavoe"
           "Lloraras - Grupo Salsa Viva" "Lloraras - Hector Lavoe"
           "Lloraras - Eddie Santiago" "Lloraras - La Sonora Matancera"
           "A Pedir Su Mano - Juan Luis Guerra" "El Manisero - Beny More")))

;;; ====================================================================
;;; FUNCIONES AUXILIARES
;;; ====================================================================

;; Función para leer una línea de entrada como lista de palabras
(defun leer-entrada ()
  (let ((linea (read-line)))
    (with-input-from-string (s linea)
      (loop for palabra = (read s nil nil)
            while palabra
            collect (if (symbolp palabra) 
                        (intern (string-downcase (symbol-name palabra)))
                        palabra)))))

;; Función para imprimir una lista como oración
(defun imprimir-lista (lista)
  (format t "~{~a~^ ~}~%" lista))

;; Obtener síntomas de una enfermedad
(defun obtener-sintomas (enfermedad)
  (cdr (assoc enfermedad *sintomas-enfermedad*)))

;; Obtener tratamiento de una enfermedad
(defun obtener-tratamiento (enfermedad)
  (cadr (assoc enfermedad *tratamientos*)))

;; Obtener gravedad de una enfermedad
(defun obtener-gravedad (enfermedad)
  (cadr (assoc enfermedad *gravedad-enfermedad*)))

;; Verificar si un síntoma pertenece a una enfermedad
(defun tiene-sintoma-p (enfermedad sintoma)
  (member sintoma (obtener-sintomas enfermedad)))

;; Obtener síntomas confirmados de un paciente
(defun obtener-sintomas-paciente (paciente)
  (cadr (assoc paciente *sintomas-paciente*)))

;; Agregar síntoma a un paciente
(defun agregar-sintoma-paciente (paciente sintoma)
  (let ((entrada (assoc paciente *sintomas-paciente*)))
    (if entrada
        (pushnew sintoma (cadr entrada))
        (push (list paciente (list sintoma)) *sintomas-paciente*))))

;; Contar síntomas coincidentes entre paciente y enfermedad
(defun contar-sintomas-coincidentes (paciente enfermedad)
  (let ((sintomas-paciente (obtener-sintomas-paciente paciente))
        (sintomas-enfermedad (obtener-sintomas enfermedad)))
    (length (intersection sintomas-paciente sintomas-enfermedad))))

;; Calcular probabilidad de enfermedad
(defun calcular-probabilidad (paciente enfermedad)
  (let* ((total-sintomas (length (obtener-sintomas enfermedad)))
         (sintomas-confirmados (contar-sintomas-coincidentes paciente enfermedad)))
    (if (> total-sintomas 0)
        (* (/ sintomas-confirmados total-sintomas) 100.0)
        0.0)))

;; Buscar canciones por género (máximo 10)
(defun buscar-canciones (genero)
  (let ((canciones (cdr (assoc genero *canciones*))))
    (if canciones
        (subseq canciones 0 (min 10 (length canciones)))
        '("No encontre canciones de ese genero"))))

;;; ====================================================================
;;; FUNCIONES MÉDICAS AVANZADAS
;;; ====================================================================

;; Determinar nivel de riesgo
(defun calcular-riesgo (paciente enfermedad)
  (let ((gravedad (obtener-gravedad enfermedad))
        (num-sintomas (contar-sintomas-coincidentes paciente enfermedad)))
    (cond
      ((and (eq gravedad 'grave) (>= num-sintomas 3)) 'alto)
      ((and (eq gravedad 'grave) (>= num-sintomas 1)) 'medio)
      ((and (eq gravedad 'moderada) (>= num-sintomas 2)) 'medio)
      ((and (or (eq gravedad 'leve) (eq gravedad 'moderada)) (>= num-sintomas 1)) 'bajo)
      (t nil))))

;; Diagnóstico básico - enfermedades posibles
(defun diagnostico-basico (paciente)
  (remove-duplicates
    (remove nil
      (mapcar #'(lambda (enfermedad)
                  (if (> (contar-sintomas-coincidentes paciente enfermedad) 0)
                      enfermedad
                      nil))
              *enfermedades*))))

;; Diagnóstico y tratamiento completo
(defun diagnosticar-y-tratar (paciente)
  (let* ((enfermedades-posibles 
           (mapcar #'(lambda (enf)
                       (list enf (contar-sintomas-coincidentes paciente enf)))
                   *enfermedades*))
         (enfermedades-filtradas 
           (remove-if #'(lambda (x) (<= (cadr x) 0)) enfermedades-posibles))
         (enfermedades-ordenadas 
           (sort enfermedades-filtradas #'> :key #'cadr)))
    (if enfermedades-ordenadas
        (let* ((diagnostico (caar enfermedades-ordenadas))
               (num-sintomas (cadar enfermedades-ordenadas))
               (tratamiento (obtener-tratamiento diagnostico))
               (gravedad (obtener-gravedad diagnostico))
               (riesgo (calcular-riesgo paciente diagnostico)))
          (format t "~%=== DIAGNOSTICO Y TRATAMIENTO ===~%")
          (format t "Paciente: ~a~%" paciente)
          (format t "Diagnostico: ~a~%" diagnostico)
          (format t "Sintomas coincidentes: ~a~%" num-sintomas)
          (format t "Gravedad: ~a~%" gravedad)
          (when riesgo
            (format t "Nivel de Riesgo: ~a~%" riesgo))
          (format t "Tratamiento: ~a~%" tratamiento)
          (format t "=== FIN DEL DIAGNOSTICO ===~%")
          (list diagnostico tratamiento))
        (progn
          (format t "No se puede determinar diagnostico con los sintomas proporcionados.~%")
          nil))))

;; Reporte completo del paciente
(defun generar-reporte (paciente)
  (format t "~%╔════════════════════════════════════════════════════════════════╗~%")
  (format t "║           REPORTE MEDICO COMPLETO DEL PACIENTE                ║~%")
  (format t "╚════════════════════════════════════════════════════════════════╝~%")
  (format t "~%Paciente: ~a~%~%" paciente)
  
  ;; 1. Síntomas confirmados
  (format t "1. SINTOMAS CONFIRMADOS:~%")
  (format t "─────────────────────────~%")
  (let ((sintomas (obtener-sintomas-paciente paciente)))
    (if sintomas
        (progn
          (format t "   Total de sintomas reportados: ~a~%" (length sintomas))
          (dolist (s sintomas)
            (format t "   • ~a~%" s)))
        (format t "   No hay sintomas confirmados registrados~%")))
  (terpri)
  
  ;; 2. Análisis de enfermedades posibles
  (format t "2. ANALISIS DE ENFERMEDADES POSIBLES:~%")
  (format t "─────────────────────────────────────~%")
  (let ((probabilidades 
          (sort 
            (remove-if #'(lambda (x) (<= (cadr x) 0))
              (mapcar #'(lambda (enf)
                          (list enf (calcular-probabilidad paciente enf)))
                      *enfermedades*))
            #'> :key #'cadr)))
    (if probabilidades
        (dolist (prob probabilidades)
          (format t "   • ~a: ~,2f%~%" (car prob) (cadr prob)))
        (format t "   No se encontraron enfermedades coincidentes~%")))
  (terpri)
  
  ;; 3. Diagnóstico final
  (format t "3. DIAGNOSTICO FINAL:~%")
  (format t "─────────────────────~%")
  (diagnosticar-y-tratar paciente)
  (terpri)
  
  (format t "╚════════════════════════════════════════════════════════════════╝~%"))

;;; ====================================================================
;;; SISTEMA DE TEMPLATES Y PATTERN MATCHING
;;; ====================================================================

;; Estructura de template: (patron respuesta indices)
(defvar *templates*
  '(
    ;; Saludos básicos
    ((hola mi nombre es * |.|) (hola 3 como estas tu ?) (3))
    ((buendia mi nombre es * |.|) (buen dia como estas tu 3 ?) (3))
    ((hola |,| mi nombre es * |.|) (hola 4 como estas tu ?) (4))
    ((buendia |,| mi nombre es * |.|) (buendia como estas tu 4 ?) (4))
    ((hola *) (hola como estas tu ?) nil)
    ((buendia *) (buendia como estas tu ?) nil)
    
    ;; Estado de ánimo
    ((estoy bien y tu |.|) (tambien estoy bien por que estas bien ?) nil)
    ((bien *) (que bien me alegro :)) nil)
    ((estoy mal y tu |.|) (tambien estoy mal por que estas mal ?) nil)
    ((mal *) (que mal te entiendo :\() nil)
    
    ;; Ayuda
    ((oye necesito ayuda |.|) (en que te puedo ayudar ?) nil)
    ((cual es el teorema de pitagoras |.|) 
     (la formula matematica que expresa esta relacion es a^{2}+b^{2}=c^{2} donde \(a\) y \(b\) son los catetos y \(c\) es la hipotenusa) nil)
    
    ;; Preguntas sobre Eliza
    ((te gustan las * *) (flag-like 3) (3))
    ((te gustan los * *) (flag-like 3) (3))
    ((te gusta hacer * *) (flag-like 3) (3))
    ((te gusta * *) (flag-like 2) (2))
    ((tu eres * *) (flag-do 2) (2))
    ((que eres tu *) (flag-is 3) (3))
    ((eres * ?) (flag-is 1) (1))
    ((como estas tu ?) (yo estoy bien |,| gracias por preguntar |.|) nil)
    
    ;; Búsqueda de música
    ((quiero escuchar * |.|) (flag-musica 2) (2))
    ((canciones de * |.|) (flag-musica 2) (2))
    ((dame canciones de * |.|) (flag-musica 3) (3))
    ((musica de * |.|) (flag-musica 2) (2))
    
    ;; Consultas médicas
    ((probabilidad de * para * |.|) (flag-prob 2 4) (2 4))
    ((riesgo de * para * |.|) (flag-risk 2 4) (2 4))
    ((reporte de * |.|) (flag-report 2) (2))
    ((reporte para * |.|) (flag-report 2) (2))
    
    ;; Síntomas
    ((tengo * |.|) (flag-sintoma 1) (1))
    ((siento * |.|) (flag-sintoma 1) (1))
    ((tengo * y * |.|) (flag-sintoma2 1 3) (1 3))
    ((siento * y * |.|) (flag-sintoma2 1 3) (1 3))
    
    ;; Preguntas sobre síntomas de enfermedades
    ((cuales son los sintomas de * |.|) (flag-sintomas-enf 5) (5))
    ((que sintomas tiene * |.|) (flag-sintomas-enf 3) (3))
    ((sintomas de * |.|) (flag-sintomas-enf 2) (2))
    
    ;; Preguntas sobre tratamientos
    ((cual es el tratamiento de * |.|) (flag-tratamiento 5) (5))
    ((cual es el tratamiento para * |.|) (flag-tratamiento 5) (5))
    ((tratamiento de * |.|) (flag-tratamiento 2) (2))
    ((tratamiento para * |.|) (flag-tratamiento 2) (2))
    ((como se trata * |.|) (flag-tratamiento 3) (3))
    ((que tratamiento tiene * |.|) (flag-tratamiento 3) (3))
    
    ;; Otros
    ((yo pienso que *) (bueno esa es tu opinion) nil)
    ((porque *) (esa no es una buena razon |.|) nil)
    
    ;; Default
    ((* *) (por favor explica un poco mas |.|) nil)))

;; Función de matching simple con wildcards
(defun match-pattern (patron entrada &optional (bindings nil))
  (cond
    ;; Ambos vacíos - match exitoso
    ((and (null patron) (null entrada)) 
     (list t bindings))
    
    ;; Uno vacío y el otro no - fallo
    ((or (null patron) (null entrada)) 
     (list nil nil))
    
    ;; Wildcard * - coincide con cualquier elemento
    ((eq (car patron) '*)
     (list t (append bindings (list (car entrada)))))
    
    ;; Los elementos coinciden
    ((equal (car patron) (car entrada))
     (match-pattern (cdr patron) (cdr entrada) bindings))
    
    ;; No coinciden
    (t (list nil nil))))

;; Buscar template que coincida con la entrada
(defun buscar-template (entrada)
  (dolist (template *templates*)
    (let* ((patron (car template))
           (respuesta (cadr template))
           (indices (caddr template))
           (match-result (match-pattern patron entrada)))
      (when (car match-result)
        (return-from buscar-template 
          (list respuesta indices (cadr match-result)))))))

;; Reemplazar indices en la respuesta
(defun reemplazar-indices (respuesta indices valores-entrada entrada-completa)
  (if (null respuesta)
      nil
      (let ((elem (car respuesta)))
        (cond
          ;; Es un índice a reemplazar
          ((and (numberp elem) indices)
           (let ((pos (position elem indices)))
             (if pos
                 (cons (nth elem entrada-completa)
                       (reemplazar-indices (cdr respuesta) indices valores-entrada entrada-completa))
                 (cons elem (reemplazar-indices (cdr respuesta) indices valores-entrada entrada-completa)))))
          
          ;; Es un flag especial
          ((and (symbolp elem) (string-prefix-p "FLAG-" (symbol-name elem)))
           (procesar-flag elem indices entrada-completa))
          
          ;; Elemento normal
          (t (cons elem (reemplazar-indices (cdr respuesta) indices valores-entrada entrada-completa)))))))

;; Verificar si una cadena empieza con un prefijo
(defun string-prefix-p (prefix string)
  (let ((prefix-len (length prefix))
        (string-len (length string)))
    (and (>= string-len prefix-len)
         (string= prefix string :end2 prefix-len))))

;; Procesar flags especiales
(defun procesar-flag (flag indices entrada)
  (let ((tipo (intern (string-upcase (symbol-name flag)))))
    (cond
      ;; Flag-like: ¿Le gusta algo a Eliza?
      ((eq tipo 'FLAG-LIKE)
       (let ((cosa (nth (car indices) entrada)))
         (if (member cosa *eliza-likes*)
             (list 'si 'me gusta cosa)
             (list 'no 'no me gusta cosa))))
      
      ;; Flag-do: ¿Hace algo Eliza?
      ((eq tipo 'FLAG-DO)
       (let ((accion (nth (car indices) entrada)))
         (if (member accion *eliza-does*)
             (list 'si 'yo accion 'y me encanta)
             (list 'no 'yo no accion '|.| 'es muy dificil para mi))))
      
      ;; Flag-is: ¿Es Eliza algo?
      ((eq tipo 'FLAG-IS)
       (let ((caracteristica (nth (car indices) entrada)))
         (if (member caracteristica *eliza-is*)
             (list 'si 'yo soy caracteristica)
             (list 'no 'yo no soy caracteristica))))
      
      ;; Flag-musica: Búsqueda de canciones
      ((eq tipo 'FLAG-MUSICA)
       (let* ((genero (nth (car indices) entrada))
              (canciones (buscar-canciones genero)))
         (append (list 'aqui hay 10 canciones de genero ':)
                 canciones
                 (list '|.| 'espero que disfrutes la musica '!))))
      
      ;; Flag-prob: Calcular probabilidad
      ((eq tipo 'FLAG-PROB)
       (let* ((enfermedad (nth (car indices) entrada))
              (paciente (nth (cadr indices) entrada))
              (prob (calcular-probabilidad paciente enfermedad)))
         (list 'probabilidad 'de enfermedad 'para paciente ': 
               (format nil "~,2f%" prob))))
      
      ;; Flag-risk: Calcular riesgo
      ((eq tipo 'FLAG-RISK)
       (let* ((enfermedad (nth (car indices) entrada))
              (paciente (nth (cadr indices) entrada))
              (riesgo (calcular-riesgo paciente enfermedad)))
         (if riesgo
             (list 'riesgo 'de enfermedad 'para paciente ': riesgo)
             (list 'no se pudo determinar el riesgo))))
      
      ;; Flag-report: Generar reporte
      ((eq tipo 'FLAG-REPORT)
       (let ((paciente (nth (car indices) entrada)))
         (generar-reporte paciente)
         (list 'reporte generado para paciente)))
      
      ;; Flag-sintoma: Consultar síntoma único
      ((eq tipo 'FLAG-SINTOMA)
       (let* ((sintoma (nth (car indices) entrada))
              (enfermedades 
                (remove nil
                  (mapcar #'(lambda (enf)
                              (if (tiene-sintoma-p enf sintoma) enf nil))
                          *enfermedades*))))
         (if enfermedades
             (if (= (length enfermedades) 1)
                 (list 'el 'sintoma sintoma 'puede 'indicar (car enfermedades) '|.|
                       'te 'recomiendo 'consultar 'un 'medico '|.|)
                 (append (list 'el 'sintoma sintoma 'aparece 'en 'varias 'enfermedades ':)
                         enfermedades
                         (list '|.| 'necesito 'mas 'informacion '|.|)))
             (list 'no 'conozco 'ese 'sintoma 'en 'mi 'base 'de 'datos '|.|))))
      
      ;; Flag-sintoma2: Consultar dos síntomas
      ((eq tipo 'FLAG-SINTOMA2)
       (let* ((sintoma1 (nth (car indices) entrada))
              (sintoma2 (nth (cadr indices) entrada))
              (enfermedades 
                (remove nil
                  (mapcar #'(lambda (enf)
                              (if (and (tiene-sintoma-p enf sintoma1)
                                       (tiene-sintoma-p enf sintoma2))
                                  enf nil))
                          *enfermedades*))))
         (if enfermedades
             (if (= (length enfermedades) 1)
                 (let* ((enf (car enfermedades))
                        (gravedad (obtener-gravedad enf)))
                   (list 'los 'sintomas sintoma1 'y sintoma2 'coinciden 'con enf
                         '\( 'gravedad ': gravedad '\) '|.|
                         'busca 'atencion 'medica '|.|))
                 (append (list 'esos 'sintomas 'pueden 'indicar ':)
                         enfermedades
                         (list '|.| 'debes 'ver 'a 'un 'medico 'pronto '|.|)))
             (list 'no 'encuentro 'enfermedades 'con 'ambos 'sintomas '|.|
                   'consulta 'a 'un 'profesional '|.|))))
      
      ;; Flag-sintomas-enf: Consultar síntomas de una enfermedad
      ((eq tipo 'FLAG-SINTOMAS-ENF)
       (let ((enfermedad (nth (car indices) entrada)))
         (if (member enfermedad *enfermedades*)
             (let ((sintomas (obtener-sintomas enfermedad))
                   (gravedad (obtener-gravedad enfermedad)))
               (if sintomas
                   (append (list 'los 'sintomas 'de enfermedad 
                                '\( 'gravedad ': gravedad '\) 'son ':)
                           sintomas
                           (list '|.|))
                   (list 'no 'hay 'sintomas 'registrados 'para enfermedad '|.|)))
             (list 'no 'conozco 'esa 'enfermedad '|.| 
                   'las 'enfermedades 'que 'conozco 'son ': 
                   'tetanos '|,| 'varicela '|,| 'zika '|,| 
                   'meningitis '|,| 'neumonia '|,| 'dengue_hemorragico '|.|))))
      
      ;; Flag-tratamiento: Consultar tratamiento de una enfermedad
      ((eq tipo 'FLAG-TRATAMIENTO)
       (let ((enfermedad (nth (car indices) entrada)))
         (if (member enfermedad *enfermedades*)
             (let ((tratamiento (obtener-tratamiento enfermedad))
                   (gravedad (obtener-gravedad enfermedad)))
               (list 'el 'tratamiento 'para enfermedad 
                     '\( 'gravedad ': gravedad '\) 'es ': 
                     tratamiento '|.|
                     'por 'favor '|,| 'consulta 'a 'un 'medico 'profesional '|.|))
             (list 'no 'conozco 'el 'tratamiento 'para enfermedad '|.|
                   'las 'enfermedades 'que 'conozco 'son ':
                   'tetanos '|,| 'varicela '|,| 'zika '|,|
                   'meningitis '|,| 'neumonia '|,| 'dengue_hemorragico '|.|))))
      
      ;; Flag desconocido
      (t (list 'flag 'desconocido)))))

;;; ====================================================================
;;; FUNCIÓN PRINCIPAL DE ELIZA
;;; ====================================================================

(defun eliza ()
  (format t "~%Hola, mi nombre es Eliza tu chatbot,~%")
  (format t "por favor ingresa tu consulta,~%")
  (format t "usar solo minusculas con punto . al final:~%~%")
  (eliza-loop))

(defun eliza-loop ()
  (format t "> ")
  (finish-output)
  (let ((entrada (leer-entrada)))
    (cond
      ;; Salida
      ((or (equal entrada '(adios |.|))
           (equal entrada '(adios .))
           (equal entrada '(Adios |.|))
           (equal entrada '(Adios .)))
       (format t "Adios. Espero haberte ayudado.~%"))
      
      ;; Procesar entrada
      (t
       (let ((match (buscar-template entrada)))
         (if match
             (let* ((respuesta (car match))
                    (indices (cadr match))
                    (valores (caddr match))
                    (respuesta-final (reemplazar-indices respuesta indices valores entrada)))
               (imprimir-lista respuesta-final))
             (format t "Por favor, explica un poco mas.~%")))
       (eliza-loop)))))

;;; ====================================================================
;;; FUNCIONES MÉDICAS ADICIONALES
;;; ====================================================================

;; Árbol de diagnóstico interactivo
(defun arbol-diagnostico (paciente)
  (format t "~%=== Diagnostico medico para paciente: ~a ===~%" paciente)
  (format t "Responda las siguientes preguntas con si o no:~%~%")
  (let ((enfermedad (pregunta-fiebre paciente)))
    (when enfermedad
      (format t "~%Diagnostico: ~a~%" enfermedad)
      (let ((tratamiento (obtener-tratamiento enfermedad)))
        (format t "Tratamiento recomendado: ~a~%" tratamiento)))))

(defun pregunta-fiebre (paciente)
  (format t "¿El paciente tiene fiebre o fiebre alta? (si/no): ")
  (finish-output)
  (let ((respuesta (read)))
    (if (eq respuesta 'si)
        (pregunta-piel paciente)
        (pregunta-rigidez paciente))))

(defun pregunta-piel (paciente)
  (format t "¿El paciente tiene ampollas, erupciones o picazon en la piel? (si/no): ")
  (finish-output)
  (let ((respuesta (read)))
    (if (eq respuesta 'si)
        (pregunta-tipo-piel paciente)
        'indeterminado)))

(defun pregunta-tipo-piel (paciente)
  (format t "¿Son ampollas con picazon intensa? (si=varicela, no=verificar otros): ")
  (finish-output)
  (let ((respuesta (read)))
    (if (eq respuesta 'si)
        'varicela
        (pregunta-articulaciones paciente))))

(defun pregunta-articulaciones (paciente)
  (format t "¿El paciente tiene dolor en las articulaciones? (si/no): ")
  (finish-output)
  (let ((respuesta (read)))
    (if (eq respuesta 'si)
        'zika
        'indeterminado)))

(defun pregunta-rigidez (paciente)
  (format t "¿El paciente tiene rigidez en la mandibula o espasmos musculares? (si/no): ")
  (finish-output)
  (let ((respuesta (read)))
    (if (eq respuesta 'si)
        (pregunta-espasmos paciente)
        'indeterminado)))

(defun pregunta-espasmos (paciente)
  (format t "¿Los espasmos musculares son severos o hay trismo (dificultad para abrir la boca)? (si/no): ")
  (finish-output)
  (let ((respuesta (read)))
    (if (eq respuesta 'si)
        'tetanos
        'indeterminado)))

;;; ====================================================================
;;; MENSAJE DE INICIO
;;; ====================================================================

(format t "~%====================================================================~%")
(format t "ELIZA CHATBOT EN COMMON LISP~%")
(format t "Sistema de conversacion con integracion medica~%")
(format t "====================================================================~%")
(format t "~%Para iniciar el chatbot, escribe: (eliza)~%")
(format t "Para diagnostico interactivo, escribe: (arbol-diagnostico 'paciente)~%")
(format t "Para generar reporte medico, escribe: (generar-reporte 'paciente)~%")
(format t "Para diagnosticar y tratar, escribe: (diagnosticar-y-tratar 'paciente)~%~%")
