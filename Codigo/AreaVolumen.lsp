

(defun area ()
    (princ "De que figura quieres saber el area: ")
    (setq x (read))

    (case x 
        (triangulo (progn
            (princ "Dame la base: ")
            (setq b (read))
            (princ "Dame la altura: ")
            (setq a (read))
             (format t "El area del ~x es: ~a~%" x (/ (* b a) 2))
               
        ))
        (rectangulo (progn 
            (princ "Dame un Lado: ")
            (setq b (read))
            (princ "Dame el otro lado: ")
            (setq a (read))
            (format t "El area del ~x es: ~a~%" x (* a b))
        ))
        (cuadrado (progn
            (princ "Dame un Lado: ")
            (setq b (read))
            (princ "Dame el otro lado: ")
            (setq a (read))
            (format t "El area del ~x es: ~a~%" x (* a b))
        ))
        (paralelogramo (progn
            (princ "Dame la base: ")
            (setq b (read))
            (princ "Dame la altura: ")
            (setq a (read))
            (format t "El area del ~x es: ~a~%" x (* a b))
        ))
        (trapesio (progn
            (princ "Dame la base mayor: ")
            (setq m (read))
            (princ "Dame la base menor: ")
            (setq b (read))
            (princ "Dame la altura: ")
            (setq a (read))
            (format t "El area del ~x es: ~a~%" x (* (/ (+ m b) 2) a))

        ))
        (circulo (progn 
            (princ "Dame el radio: ")
            (setq r (read))
            (format t "El area del ~x es: ~a~%" x (* 3.1416 (* r r)))
        ))
        (rombo (progn
            (princ "Dame la diagonal mayor: ")
            (setq d (read))
            (princ "Dame la diagonal menor: ")
            (setq m (read))
            (format t "El area del ~x es: ~a~%" x (/ (* d m) 2))
        ))

    )

)



(defun volumen ()
    (princ "De que figura quieres saber el volumen: ")
    (setq x (read))

    (case x
        (triangulo (progn
            (princ "Dame lo que mide su lado: ")
            (setq a (read))
            (format t "El volumen del ~x es: ~a~%" x (* a a a))
        ))
        (prisma (progn 
            (princ "Dame el Area de sus base: ")
            (setq b (read))
            (princ "Dame su altura: ")
            (setq a (read))
            (format t "El volumen del ~x es: ~a~%" x (* b a))
        ))
        (piramede (progn 
            (princ "Dame el Area de sus base: ")
            (setq b (read))
            (princ "Dame su altura: ")
            (setq a (read))
            (format t "El volumen del ~x es: ~a~%" x (* (/ 1 3) b a))
        ))
        (cilindro (progn 
            (princ "Dame el radio: ")
            (setq r (read))
            (princ "Dame su altura: ")
            (setq a (read))
            (format t "El volumen del ~x es: ~a~%" x (* 3.1416 (* r r) a))
        ))
        (cono (progn 
            (princ "Dame el radio: ")
            (setq r (read))
            (princ "Dame su altura: ")
            (setq a (read))
            (format t "El volumen del ~x es: ~a~%" x (* (/ 1 3) 3.1416 (* r r) a))
        ))
        (esfera (progn 
            (princ "Dame el radio: ")
            (setq r (read))
            (format t "El volumen del ~x es: ~a~%" x (* (/ 4 3) 3.1416 (* r r r)))
        ))

    )
)