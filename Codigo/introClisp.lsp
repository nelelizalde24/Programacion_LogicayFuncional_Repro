(defun suma(a b)
  (+ a b)
)

(defun areacuadro(a b)
  (* a b)
)

(defun factorial (x)
  (if (= x 0)
    1
    (* x (factorial(- x 1)))
  )
)

(defun finbonacci (x)
  (if (< x 2)
    1
    (+ (finbonacci (- x 1)) (finbonacci (- x 2)))

  )
)

;potencia con sumas
(defun potencia (x y)
  (if (= y 0)
      1
      (* x (potencia x (- y 1)))))


;Divicion con resta
(defun divicion (a b)
    (if (= a 0)
      0
      (- divicion(a) b)
    )

)

(defun holamundo ()
 ;(princ "Hola mundo")
 (format nil "Hola mundo")
)



(defun recorre (lista)
  (setq elemento (car lista))
  (format t "El valor de la lista es ~D~% " elemento)
  (if lista
    (recorre (cdr lista))
  )
)

(defun evalua (a b)
  (if (< a b)
    (progn
    (format t "Evaluacion del if ~%") ; el format t imprime las dos lineas
    (format t "A < B")
    )
    (format nil "A > B") ;solo imprime esta linea con el format nil
  )
)

(defun saluda (nombre)
  (when (string = nombre "")
    (format t "Hola, -a!-%" nombre)
  )
)

(defun saludar(nombre)
  (cond ((eq nombre 'juan) '(hola juan)) ;con el cond me permite hacer validaciones
        ((eq nombre 'maria) '(hola maria))
        ((eq nombre 'nombre) '(hola lupe))
        (t '(no se quien seas))
  )
)

(defun saludarse(nombre)
  (case nombre
        ((juan) '(hola juan))
        ((maria) '(hola maria))
        ((lupe) '(hola lupe))
        (otherwise '(no se quien seas))
  )
)
