
(defun ejercicio1 (nombre a)
  (when(>= a 10)
    (format t "Hola, ~a~%" nombre)
    (format t "Tu aumento anual ~a Por tener ~a anos en la empresa ~%" (* 40000 0.1) a )
  )
)
