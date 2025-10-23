**1. Escribe un programa en lenguaje ensamblador que sume los primeros 100 números naturales.**
```
int i = 1;
int sum = 0;
While (i <= 100){
   sum += i;
   i++;
}
```

https://github.com/user-attachments/assets/c9515722-f1a8-48e2-996b-85135796071a

**R/**
```
// Suma los primeros 100 números naturales
// i → @i, sum → @sum

@i
M=1         // i = 1
@sum
M=0         // sum = 0

(LOOP)
    @i
    D=M         // D = i
    @100
    D=D-A       // D = i - 100
    @END
    D;JGT       // Si i > 100, saltar a END

    @i
    D=M         // D = i
    @sum
    M=D+M       // sum = sum + i

    @i
    M=M+1       // i++

    @LOOP
    0;JMP       // Repetir ciclo

(END)
    @END
    0;JMP       // Fin
```

El programa fue cargado en el Assembler de Nand2Tetris y se tradujo correctamente sin errores de sintaxis.
Luego se abrió el archivo .hack resultante en el CPU Emulator, donde se ejecutó paso a paso para verificar el comportamiento de las variables.

- **¿Cómo están implementadas las variables i y sum?**
- **R/**  i y sum estan implementados al principio siendo declarados para realizar la suma, se inicializa i en 1 para tener una cuenta de los números que van a llegar a 100. Y sum esta puesto en el ciclo para sumarse con i y luego ir aumentando a medida que el ciclo continúe.
- **¿En qué direcciones de memoria están estas variables?**
- **R/** i esta en la dirección 16 y sum en la dirección 17 +, ya que estas son las primeras posiciones que se pueden usar.
- **¿Cómo está implementado el ciclo `while`?**
- **R/** Es un ciclo con condicion "While (i<= 100)" es decir que mientras i sea menor o igual a 100 se cumpla el ciclo que usa sum para que se sume con el valor de i, que en un principio es 1. Luego a i se le suma 1, por lo que empezamos de nuevo esta vez con i = 2 y sum = 1 para repetirlo hasta llegar al valor 100.
- **¿Cómo se implementa la variable `i`?**
- **R/** Se implementa como el contador para sumar los primeros 100 números naturales, empezando en 1 para tomar la cuenta. Luego en el ciclo sumandolo con sum en cada ciclo y luego sumandose 1 a si mismo para ir contando hasta el 100 y empezar el ciclo otra vez.
- **¿En qué parte de la memoria se almacena la variable `i`?**
- **R/** Se almacena en RAM[16] ya que es la primera variable que se declara, ya que de la RAM[1] A RAM[15] Son variables reservadas.
- **Después de todo lo que has hecho, ¿Qué es entonces una variable?**
- **R/** Una variable es un espacio en la memoria que se utiliza para guardar un valor que puede cambiar a lo largo de la ejecución del programa. En lenguaje ensamblador, una variable representa una dirección de memoria a la que podemos acceder para leer o escribir un dato. Por ejemplo, i y sum son variables que usamos para llevar la cuenta y sumar números, respectivamente.
- **¿Qué es la dirección de una variable?**
- **R/** La dirección de una variable es el número que identifica la ubicación exacta en la memoria RAM donde esa variable está guardada. Es como la "dirección de una casa" donde vive el dato.
Por ejemplo, si i está en RAM[16], entonces su dirección es 16, y así sabemos dónde buscar o guardar su valor.
- **¿Qué es el contenido de una variable?**
- **R/** El contenido de una variable es el valor que está almacenado en su dirección de memoria. Por ejemplo, si i está en RAM[16] y en ese momento tiene el valor 5, entonces el contenido de la variable i es 5. Ese valor puede cambiar durante el programa (como cuando se incrementa i++).

**2. Transforma el programa en alto nivel anterior para que utilice un ciclo for en vez de un ciclo while.**
**R/** 
```
int sum = 0;
for (int i = 1; i <= 100; i++) {
    sum += i;
}
```
**3. Escribe un programa en lenguaje ensamblador que implemente el programa anterior.**

https://github.com/user-attachments/assets/9da0e0d0-2c97-4b50-ab18-2459deb5e769

R/ 
```
// Suma los primeros 100 números usando ciclo for

@sum
M=0         // sum = 0
@i
M=1         // i = 1

(FOR_LOOP)
    @i
    D=M
    @100
    D=D-A
    @END
    D;JGT       // Si i > 100 → fin

    @i
    D=M
    @sum
    M=M+D       // sum += i

    @i
    M=M+1       // i++

    @FOR_LOOP
    0;JMP

(END)
    @END
    0;JMP

```
El programa fue ensayado en el Assembler y posteriormente simulado en el CPU Emulator.
Durante la ejecución, se confirmó que:

- Las variables sum e i fueron almacenadas en RAM[16] y RAM[17] respectivamente.
- La estructura del ciclo for se ejecutó correctamente, realizando las mismas operaciones de incremento y suma que el ciclo while, pero controladas por una sola sección de salto.
- En cada iteración, sum aumentaba en el valor de i, hasta llegar a 5050 al finalizar el ciclo.

El programa finalizó en el bucle infinito (END), indicando el término correcto de la rutina.
La prueba permitió verificar que la implementación en lenguaje ensamblador conserva la lógica del ciclo for y los resultados esperados.

**4.Ahora vamos a acercarnos al concepto de puntero. Un puntero es una variable que almacena la dirección de memoria de otra variable. Observa el siguiente programa escrito en C++:**
       
```
    int var = 10;
    int *punt;
    punt = &var;
    *punt = 20;
```

El programa anterior modifica el contenido de la variable var por medio de la variable punt. punt es un puntero porque almacena la dirección de memoria de la variable var . En este caso el valor de la variable var  será 20 luego de ejecutar *punt = 20;. Ahora analiza:

- **¿Cómo se declara un puntero en C++? int *punt;. punt es una variable que almacenará la dirección de un variable que almacena enteros.**
**R/** Se declara poniendo un asterisco (*) antes del nombre de la variable. Por ejemplo: int *punt;
Ahí estoy diciendo que punt es un puntero que va a guardar la dirección de una variable de tipo entero. No guarda el número directamente, sino dónde está ese número en la memoria.

- **¿Cómo se define un puntero en C++?**
**R/** Se define usando el operador &, que sirve para sacar la dirección de una variable.
Por ejemplo: punt = &var;
Con eso, punt ya está apuntando a la dirección de var. Es decir, no guarda el 10, sino la ubicación de var en la memoria.

- **¿Cómo se almacena en C++ la dirección de memoria de una variable?**
**R/** Usando el operador &, como cuando hacemos punt = &var;. Ahí el & es lo que hace que obtengamos la dirección de var, no su contenido. Entonces lo que se guarda en punt no es 10, sino algo como "RAM[100]" (por ejemplo), que es donde está var.

- **¿Cómo se escribe el contenido de la variable a la que apunta un puntero?**
**R/** Usando el operador *, que sirve para acceder al contenido que hay en la dirección guardada por el puntero.
Entonces si hago *punt = 20;, estoy diciendo: "Ve a la dirección que tiene punt guardada (que es donde está var) y cambia lo que hay ahí por 20".
Así que ahora var vale 20, aunque nunca le escribí directamente a var.

**5. Traduce este programa a lenguaje ensamblador:**
```
int var = 10;
int *punt;
punt = &var;
*punt = 20;
``` 

https://github.com/user-attachments/assets/809a302b-f3de-4bb2-adfc-311bdcdeb233 


**R/** 
```
// Simula puntero que modifica variable var

@var
M=10        // var = 10

@punt
M=var       // punt = &var (almacena dirección de var)

@punt
A=M         // A = contenido de punt → dirección de var
M=20        // *punt = 20 → var ahora vale 20

(END)
    @END
    0;JMP
```

El código se tradujo y cargó exitosamente en el Assembler sin errores.
Posteriormente, en el CPU Emulator, se identificaron las siguientes posiciones de memoria:

- var en RAM[16]
- punt en RAM[17]

Durante la simulación se observó el siguiente comportamiento:

- var fue inicializada con el valor 10.
- punt almacenó la dirección de memoria 16, correspondiente a var.
- La instrucción de desreferenciación *punt = 20 actualizó correctamente el contenido de var a 20, confirmando el funcionamiento del puntero.

El programa finalizó correctamente en el bucle (END), demostrando que el puntero en ensamblador logra modificar el contenido de una variable a través de su dirección de memoria. 

7. Traduce este programa a lenguaje ensamblador:
```
int var = 10;
int bis = 5;
int *p_var;
p_var = &var;
bis = *p_var;
```

https://github.com/user-attachments/assets/00bd536e-7e31-4ecb-aa8f-acd82dbdcacc


R/ 
```
// int var = 10;
@10
D=A
@var
M=D

// int bis = 5;
@5
D=A
@bis
M=D

// int *p_var;  (reservamos dirección)
@p_var
M=0

// p_var = &var;
@var
D=A
@p_var
M=D

// bis = *p_var;
@p_var
A=M
D=M
@bis
M=D

(END)
@END
0;JMP
```

Se cargó el código ensamblador en el Assembler y se tradujo sin errores.
Luego se ejecutó paso a paso en el CPU Emulator.
Se verificó que las posiciones RAM[16], RAM[17] y RAM[18] correspondieran a las variables var, bis y p_var.
Después de ejecutar, se comprobó que bis tomó el valor de var (ambas con 10), y que p_var contenía la dirección de var (16).
Finalmente, el programa entró en un bucle de parada en las posiciones ROM[19–20], indicando que terminó correctamente.

8. 
- ¿Qué hace esto `int *pvar;`?
R/ Declara un puntero a entero (guarda una dirección).
- ¿Qué hace esto `pvar = var;`?
R/ Aquí se intenta asignar el valor de var, no su dirección.
Si var = 10, esto sería como decir “pvar apunta a la dirección 10”, lo cual no tiene sentido en C.
Para que pvar apunte a la variable var, debes usar el operador & (dirección de)
- ¿Qué hace esto `var2 = *pvar`?
R/ Guarda la dirección de var en pvar.
- ¿Qué hace esto `pvar = &var3`? 
R/ Lee el contenido al que apunta pvar y lo asigna a var2.

9. Considera que el punto de entrada del siguiente programa es la función main, es decir, el programa inicia llamando la función main. Vas a proponer una posible traducción a lenguaje ensamblador de la función suma, cómo llamar a suma y cómo regresar a std::cout << "El valor de c es: " << c << std::endl; una vez suma termine.

```
#include <iostream>

int suma(int a, int b) {
   int var = a + b;
   return var;
}


int main() {
   int c = suma(6, 9);
   std::cout << "El valor de c es: " << c << std::endl;
   return 0;
}
```

https://github.com/user-attachments/assets/f49eaea5-5ce5-4016-b38e-18e2327846a5


R/ 
```
// Simulación de llamada a función suma(a, b)
// c = suma(6, 9)

@6
D=A
@a
M=D         // a = 6

@9
D=A
@b
M=D         // b = 9

@RETURN
D=A
@retAddr
M=D         // Guardar dir de retorno

@SUMA
0;JMP       // Llamar función

(RETURN)
    @c
    M=D     // c = valor devuelto

(END)
    @END
    0;JMP

// --- Función suma(a, b) ---
(SUMA)
    @a
    D=M
    @b
    D=D+M   // D = a + b
    @RETURN
    0;JMP   // return var (en D)
```


