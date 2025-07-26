**Actividad 05**
1.
```
@1978
D=A
```
2.Guarda en la posición 100 de la RAM el número 69.

```
@69 
D=A 
@100 
M=D 
```

3. Guarda en la posición 200 de la RAM el contenido de la posición 24 de la RAM

```
@90
D=A 
@24
M=D
@200
```
4. Lee lo que hay en la posición 100 de la RAM, resta 15 y guarda el resultado en la posición 100 de la RAM.

```
M=D 
@15
D=A 
@100
M=M-D 
```
5. Suma el contenido de la posición 0 de la RAM, el contenido de la posición 1 de la RAM y con la constante 69. Guarda el resultado en la posición 2 de la RAM.

```
@1
D=M
@0
D=D+M
@69
D=D+A
@2
M=D
```

6. Si el valor almacenado en D es igual a 0 salta a la posición 100 de la ROM.
```
@100
D;JEQ
```
7. Si el valor almacenado en la posición 100 de la RAM es menor a 100 salta a la posición 20 de la ROM.
```
@100
D=A
@R13
M=D
@100
D=M
@R13
D=D-M
@20
D;JLT
```
**8.**

**¿Qué hace este programa?**  
R/ El programa suma el valor almacenado en `var1` con el valor de `var2` y guarda el resultado en `var3`.

**¿En qué posición de la memoria está `var1`, `var2` y `var3`? ¿Por qué en esas posiciones?**  
R/ `var1` está en la posición 16, `var2` en la 17 y `var3` en la 18. Esto pasa porque el ensamblador asigna automáticamente las variables a partir de la dirección 16 de la RAM cuando no se definen previamente.

**9.¿Qué hace este programa?**  
R/ Inicializa i en 1 y sum en 0, luego le suma i a sum y aumenta i en 1.

**¿En qué parte de la memoria RAM está la variable i y sum? ¿Por qué en esas posiciones?**  
**R/** i está en la posición 16 y sum en la 17. Esto ocurre porque el ensamblador asigna automáticamente las variables simbólicas no predefinidas a partir de la RAM[16].

**Optimiza esta parte del código para que use solo dos instrucciones:
R/**  
```
@i
M=M+1
```
**10. Escribe un programa en lenguaje ensamblador que guarde en R1 la operación 2 * R0.**
R/
```
@R0
D=M
D=D+D
@R1
M=D
```
**11. ¿Qué hace este programa?**  

**R/** Inicializa la variable i con 1000 y la va restando de uno en uno hasta llegar a 0. Cuando i vale 0, termina el ciclo y continúa la ejecución en CONT.

**¿En qué memoria está almacenada la variable i? ¿En qué dirección de esa memoria?**  
**R/** La variable i está almacenada en la RAM, en la dirección 16. Esto porque el ensamblador asigna las variables no predefinidas a partir de la RAM[16].

**¿En qué memoria y en qué dirección de memoria está almacenado el comentario // i = 1000?**  
**R/** Los comentarios no se almacenan en memoria. Solo sirven como anotaciones para el programador y son ignorados por el ensamblador.

**¿Cuál es la primera instrucción del programa anterior? ¿En qué memoria y en qué dirección de memoria está almacenada esa instrucción?**  
**R/** La primera instrucción es @1000, que se guarda en la ROM, en la dirección 0. La ROM almacena todas las instrucciones del programa.

**¿Qué son CONT y LOOP?**  
**R/** Son etiquetas simbólicas que marcan posiciones del código a las que se puede saltar con instrucciones de control como @LOOP o @CONT.

**¿Cuál es la diferencia entre los símbolos i y CONT?**  
**R/** i es una variable que se almacena en la RAM, mientras que CONT es una etiqueta que representa una posición en la ROM usada para controlar el flujo del programa.

12. Implemente en ensamblador: R4 = R1 + R2 + 69
```
@R2
D=M
@R1
D=D+M
@69
D=D+A
@R4
M=D
```
13. Implementa en ensamblador: if R0 >= 0 then R1 = 1 else R1 = -1
(LOOP)
goto LOOP
```
@R0
D=M
@SET_NEG
D;JLT
@R1
M=1
@SKIP
0;JMP
(SET_NEG)
@R1
M=-1
(SKIP)
(LOOP)
@LOOP
0;JMP
```
14. Implementa en ensamblador: R4 = RAM[R1]
```
@R1
A=M
D=M
@R4
M=D
```
15. Implementa en ensamblador el siguiente problema. En la posición R0 está almacenada la dirección inicial de una región de memoria. En la posición R1 está almacenado el tamaño de la región de memoria. Almacena un -1 en esa región de memoria.
```
@R0
D=M
@PTR
M=D
@R1
D=M
@COUNT
M=D
(LOOP)
@COUNT
D=M
@END
D;JEQ
@PTR
A=M
M=-1
@PTR
M=M+1
@COUNT
M=M-1
@LOOP
0;JMP
(END)
```
**16. Implementa en lenguaje ensamblador el siguiente programa:**
```
int[] arr = new int[10];
int sum = 0;
for (int j = 0; j < 10; j++) {
    sum = sum + arr[j];
}
```
R/
```
@0
D=A
@arr
M=D        // arr base en RAM[0]

@0
D=A
@sum
M=D        // sum en RAM[1]

@0
D=A
@j
M=D        // j en RAM[2]

(LOOP)
@j
D=M
@10
D=D-A
@END
D;JGE

@arr
D=M
@j
A=D+M
D=M
@sum
M=D+M

@j
M=M+1
@LOOP
0;JMP
(END)
```
18. **Utiliza esta herramienta para dibujar un bitmap en la pantalla.**  
**R/** <img width="971" height="523" alt="image" src="https://github.com/user-attachments/assets/ef80adb9-5ebc-4677-8ed1-d9fb9aa38ea1" />

**19. Analiza el siguiente programa en lenguaje de máquina:**
```
0100000000000000
1110110000010000
0000000000010000
1110001100001000
0110000000000000
1111110000010000
0000000000010011
1110001100000101
0000000000010000
1111110000010000
0100000000000000
1110010011010000
0000000000000100
1110001100000110
0000000000010000
1111110010101000
1110101010001000
0000000000000100
1110101010000111
0000000000010000
1111110000010000
0110000000000000
1110010011010000
0000000000000100
1110001100000011
0000000000010000
1111110000100000
1110111010001000
0000000000010000
1111110111001000
0000000000000100
1110101010000111
```
**R/** El programa realiza una multiplicación usando sumas sucesivas. Toma el valor almacenado en la posición 16 de la RAM (por ejemplo, el multiplicando) y lo va sumando tantas veces como indique el valor en la posición 17 . Para eso, utiliza un ciclo que va acumulando el resultado en la posición 24 de la RAM. En cada aspecto, el valor de RAM 16 se suma al acumulador, y luego se reduce en uno el contador ubicado en RAM 17. Cuando el contador llega a cero, el ciclo se detiene y el resultado final de la multiplicación queda almacenado en RAM 24. Este tipo de programa es útil para implementar multiplicación en una arquitectura que no tiene instrucciones directas para ello.

**20. Implementa un programa en lenguaje ensamblador que dibuje el bitmap que diseñaste en la pantalla solo si se presiona la tecla “d”.**

R/ 
```
@KBD
D=M
@100
D=D-A
@DRAW
D;JEQ
@KBD
0;JMP
(DRAW)
@0
D=A
@location
M=D
@location
D=M
@16384
D=D+A
@addr
M=D
@4400
D=A
@addr
A=M
M=D
@3696
D=A
A=A+1
M=D
@1128
D=A
A=A+1
M=D
@1996
D=A
A=A+1
M=D
@4
D=A
A=A+1
M=D
@4
D=A
A=A+1
M=D
@30
D=A
A=A+1
M=D
@32771
D=A
A=A+1
M=D
@49185
D=A
A=A+1
M=D
@45
D=A
A=A+1
M=D
@3145
D=A
A=A+1
M=D
@33871
D=A
A=A+1
M=D
@50782
D=A
A=A+1
M=D
@25108
D=A
A=A+1
M=D
@8724
D=A
A=A+1
M=D
@46644
D=A
A=A+1
M=D
@61284
D=A
A=A+1
M=D
@57852
D=A
A=A+1
M=D
@49260
D=A
A=A+1
M=D
@16380
D=A
A=A+1
M=D
@58348
D=A
A=A+1
M=D
@120
D=A
A=A+1
M=D
@12336
D=A
A=A+1
M=D
@3136
D=A
A=A+1
M=D
@448
D=A
A=A+1
M=D
@65024
D=A
A=A+1
M=D
(END)
@END
0;JMP
```
