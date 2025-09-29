

(defun area ()
    (princ "De que figura quieres saber el area: ")
    (setq x (read))

    (case x 
        (triangulo (progn
            (princ "Dame la base: ")
            (setq b (read))
            (princ "Dame la altura: ")
            (setq b (read))
            (format t "~a~%" (\ (* b a) 2))
            
            
        ))
    
    )


)