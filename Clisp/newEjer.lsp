
(defun numpositivo (lista)

            
          (if (> (car lista) 0) 
                (format t "Es positivo el primer numero de la lista ~a ~%" (car lista))
                (format t "Es negativo el primer numero de la lista ~a ~%" (car lista))
          )

        )


(defparameter *nodes* '(5 3 2))