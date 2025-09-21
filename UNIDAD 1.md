# UNIDAD 1

## Indice

- [Mi Repositorio](README.md)
    - [Indice](#indice)
        - [Unidad 1](#unidad-1)
            - [Estilos de Programacion](#estilos-de-programacion)
         - [Unidad 2]()
         - [Unidad 3]()
         - [Unidad 4]()



---

### **Estilos de programacion**

-  ***camelCase:*** 

    El caso camello es una convención de nomenclatura en la que varias palabras se unen sin espacios, y cada palabra comienza con una letra mayúscula excepto la primera palabra. Este estilo se usa comúnmente en programación para nombrar variables, funciones y métodos.

    En el caso del camello, la primera palabra se escribe en minúsculas y cada palabra posterior comienza con una letra mayúscula. Esto hace que las "jorobas" de las letras mayúsculas se parezcan a las jorobas de un camello, de ahí el nombre. Por ejemplo:

    ```
    numberOfDonuts = 34
    favePhrase = "Hello World"
    ```

- ***snake_case:***

    El caso de serpiente es una convención de nomenclatura en la que cada espacio de una frase se reemplaza con un carácter de subrayado ( _ ) y todas las palabras se escriben en minúsculas. Este estilo se usa a menudo para nombres de variables y métodos en programación, así como para nombres de archivos.

    ```
    number_of_donuts = 34
    fave_phrase = "Hola mundo"
    ```

---

### **CLisp**

**Aritmetica Preorden**

3 * 3 + 2 - 3 + 10 / 2  5

Arbol Binario
![arbolbinario1](img/arbol1.png)


6 + 6 + 3 * 5 * 6 + 10 + 2 - 3


7 + 7 * 3 + 1 + 6 * 3 + 10 / 2


6 + 4 * 7 + 5 + 6 + 3 + 2 - 3



**Actividad 1**   03/09/25

a)  `6 + 4 * 7 + 5 + 6 + 3 + 2 - 3`

![arbolbinario2](img/arbol2.png)

b) `6 + 12 + 9 + 8 * 3 * 6 * 2 + 2`


c) `6 / 2 * 5 + 6 * 3 + 9 + 8 + 9`

Implementar una funcion que valide la siguiente cadena

a) `( ( ) ) ) ( ( )`

b) `( ( ) ) ( ) ( ) )`

c) `( ) ( ) ) ( ( ) )`

d) `( ( ( ) ) ) ( ) ( )`

Prueba de escritorio

```
int f(int x)
{
    if (x>100)
    {
    return (x-10);
    }
    else {
        retrun(f(f(x+1)));
    }
}
```

Implementar un algoritmo que imprima todas las posibles descomposiciones de un numero natal como suma de numeros menores que el.
ejemplo: 5
    1+1+1+1+1
    2+2+1
    3+2
    3+1+1
    2+1+1+1


**Funciones Clisp**

- Unless

- Let

- Cdr

- Seta

- Format

- Princ

- Read

- Case

- Car 

- Append 

- When 




