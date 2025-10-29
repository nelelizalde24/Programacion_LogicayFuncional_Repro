

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



(defparameter *nodes* '(   (femenino ( (familia_mama ( ( tia( (gorda( (peloNegro( (tesBlanca( ("Luvia"))))))) ( delgada( (peloCastallo( (tesBlanca( ("Flor") )))))) )) ( prima( (delgada( (peloNegro( (tesBlanca( ("Yaneri"))))))))) ))
                                        (familia_papa ( (tia( (alta( (tesBlanca( (delgada( (""Lorena))) (gorda( (""))))) (tesMorena( (delgada( ("Chuy") ("Mima"))) (gorda( ("Gaby"))))))) (chaparra( (tesBlanca( (delgada( (""))) (gorda( (""))))) (tesMorena( (delgada( (""))) (gorda( (""))))))) )) (prima( () )) ))    ) 

                            )
                        
                            (masculino ( (familia_mama ())
                                         (familia_papa ())   )
                    
                             )
                    
                    
                    
                         )
                   


)