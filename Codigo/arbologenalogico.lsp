

(defun recorre (lista)
       (when lista
              (let ((elemento (car lista)))
                     (format t "Tu familia es ~a?~%" (car elemento))
                     (setq a (read)) 
                     (if (string-equal a "si")
                         (progn
                            (setq b (cadr (assoc (car elemento) lista)))
                            (recorre b)
                         )
                         (recorre (cdr lista))
                     
                     )
              )
       )

)



(defparameter *nodes* '(   (femenino ( (familia_mama ( ( tia( (gorda( (peloNegro( (tesBlanca( (Luvia))))))) ( delgada( (peloCastallo( (tesBlanca( (Flor) )))))) )) ( prima( (delgada( (peloNegro( (tesBlanca( ("Yaneri"))))))))) ))
                                        (familia_papa ())    ) 

                            )
                        
                            (masculino ( (familia_mama ())
                                         (familia_papa ())   )
                    
                             )
                    
                    
                    
                         )
                   


)