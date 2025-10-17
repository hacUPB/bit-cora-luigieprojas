**Actividad 05**  
**1.**
```
@1978
D=A
```


https://github.com/user-attachments/assets/7fef3aed-acce-4e7d-b097-6f0e44f62ac2


**2.Guarda en la posición 100 de la RAM el número 69.**

```
@69
D=A
@100
M=D
``` 

https://github.com/user-attachments/assets/d0caf66c-0d4c-4eda-8e71-e37d434c771c


**3. Guarda en la posición 200 de la RAM el contenido de la posición 24 de la RAM**

```
@90
D=A 
@24
M=D
@200
``` 

**4. Lee lo que hay en la posición 100 de la RAM, resta 15 y guarda el resultado en la posición 100 de la RAM.**

```
M=D 
@15
D=A 
@100
M=M-D 
```
**5. Suma el contenido de la posición 0 de la RAM, el contenido de la posición 1 de la RAM y con la constante 69. Guarda el resultado en la posición 2 de la RAM.**

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

**6. Si el valor almacenado en D es igual a 0 salta a la posición 100 de la ROM.**  
```
@100
D;JEQ
```

https://github.com/user-attachments/assets/292663c7-3e0e-4d68-b10d-326858c37ab8


**7. Si el valor almacenado en la posición 100 de la RAM es menor a 100 salta a la posición 20 de la ROM.**  
```
@100
D=M
@100
D=D-A
@20
D;JLT
```

https://github.com/user-attachments/assets/f226ddde-5904-43c6-b037-d05e1b736afb

**8.**

**¿Qué hace este programa?**  

https://github.com/user-attachments/assets/f8f02ce3-c0e2-478b-ab5c-a0c49fe6fe8d

**R/** El programa suma el valor almacenado en `var1` con el valor de `var2` y guarda el resultado en `var3`.

**¿En qué posición de la memoria está `var1`, `var2` y `var3`? ¿Por qué en esas posiciones?**  
**R/** `var1` está en la posición 16, `var2` en la 17 y `var3` en la 18. Esto pasa porque el ensamblador asigna automáticamente las variables a partir de la dirección 16 de la RAM cuando no se definen previamente.

**9.¿Qué hace este programa?**  

**R/** Inicializa i en 1 y sum en 0, luego le suma i a sum y aumenta i en 1.

**¿En qué parte de la memoria RAM está la variable i y sum? ¿Por qué en esas posiciones?**  
**R/** i está en la posición 16 y sum en la 17. Esto ocurre porque el ensamblador asigna automáticamente las variables simbólicas no predefinidas a partir de la RAM[16].

**Optimiza esta parte del código para que use solo dos instrucciones:
R/**  
```
@i
M=M+1
```
**10. Escribe un programa en lenguaje ensamblador que guarde en R1 la operación 2 * R0.**
**R/**
```
@R0
D=M
D=D+D
@R1
M=D
```
**11. ¿Qué hace este programa?**  


https://github.com/user-attachments/assets/c73c4bad-3e22-46d9-a144-3a90a0599a15


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

**12. Implemente en ensamblador: R4 = R1 + R2 + 69**
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

https://github.com/user-attachments/assets/51037dfa-50b5-4cc1-b4a2-ac75ba0b808c

**13. Implementa en ensamblador: 
if R0 >= 0 then R1 = 1 else R1 = -1
(LOOP)
goto LOOP**   

https://github.com/user-attachments/assets/6a74b761-e587-4df7-afb1-5829a9258936 

Acá sí R[0] = 5 R[1] = 1 

https://github.com/user-attachments/assets/32286c3f-e647-4b31-93fe-bd98c35e0fc0

Acá sí R[0] = -3 R[1] = -1 

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
**14. Implementa en ensamblador: R4 = RAM[R1]**
```
@R1
A=M
D=M
@R4
M=D
```
**15. Implementa en ensamblador el siguiente problema. En la posición R0 está almacenada la dirección inicial de una región de memoria. En la posición R1 está almacenado el tamaño de la región de memoria. Almacena un -1 en esa región de memoria.**
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

https://github.com/user-attachments/assets/adc91a28-b413-475c-8f9f-442f52832691


**16. Implementa en lenguaje ensamblador el siguiente programa:**
```
int[] arr = new int[10];
int sum = 0;
for (int j = 0; j < 10; j++) {
    sum = sum + arr[j];
}
```

**R/**

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
**18. Utiliza esta herramienta para dibujar un bitmap en la pantalla.**  
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



https://github.com/user-attachments/assets/02e3bc3c-fd89-4970-b8dd-800362934940



R/ 
```
(KEYBOARD)
@KBD
D=M
@100
D=D-A
@draw
D;JEQ
@KEYBOARD
0;JMP
(draw)
	// put bitmap location value in R12
	// put code return address in R13
	@SCREEN
	D=A
	@R12
	AD=D+M
	// row 1
	@4400 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@2304 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@32 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 2
	D=A // D holds previous addr
	@30
	AD=D+A
	@3696 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@2432 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@248 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 3
	D=A // D holds previous addr
	@30
	AD=D+A
	@1128 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@2240 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@388 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 4
	D=A // D holds previous addr
	@30
	AD=D+A
	@1996 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@2528 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 5
	D=A // D holds previous addr
	@31
	AD=D+A
	@4 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@3840 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 6
	D=A // D holds previous addr
	@31
	AD=D+A
	@4 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@56 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 7
	D=A // D holds previous addr
	@31
	AD=D+A
	@30 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@463 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 8
	D=A // D holds previous addr
	@31
	AD=D+A
	@32765 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@769 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 9
	D=A // D holds previous addr
	@31
	AD=D+A
	@16351 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@512 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 10
	D=A // D holds previous addr
	@31
	AD=D+A
	@45 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@1564 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 11
	D=A // D holds previous addr
	@31
	AD=D+A
	@3145 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@1143 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@384 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 12
	D=A // D holds previous addr
	@30
	AD=D+A
	@31665 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@65 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@192 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 13
	D=A // D holds previous addr
	@30
	AD=D+A
	@14754 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@193 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@124 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 14
	D=A // D holds previous addr
	@30
	AD=D+A
	@25108 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@129 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@448 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 15
	D=A // D holds previous addr
	@30
	AD=D+A
	@8724 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@129 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@256 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 16
	D=A // D holds previous addr
	@30
	AD=D+A
	@18892 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@129 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 17
	D=A // D holds previous addr
	@31
	AD=D+A
	@4252 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@193 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 18
	D=A // D holds previous addr
	@31
	AD=D+A
	@7684 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@97 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	M=1
	// row 19
	D=A // D holds previous addr
	@30
	AD=D+A
	@16276 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@32736 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	// row 20
	D=A // D holds previous addr
	@31
	AD=D+A
	@16380 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@16432 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 21
	D=A // D holds previous addr
	@31
	AD=D+A
	@7188 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@24703 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 22
	D=A // D holds previous addr
	@31
	AD=D+A
	@120 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@14400 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 23
	D=A // D holds previous addr
	@31
	AD=D+A
	@12336 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@448 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	// row 24
	D=A // D holds previous addr
	@31
	AD=D+A
	@3136 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@31776 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	@3 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 25
	D=A // D holds previous addr
	@30
	AD=D+A
	@448 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@30 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	AD=A+1 // D holds addr
	@12 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 26
	D=A // D holds previous addr
	@30
	AD=D+A
	@512 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=A-D // RAM[addr]=-val
	AD=A+1 // D holds addr
	M=1
	AD=A+1 // D holds addr
	@112 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 27
	D=A // D holds previous addr
	@32
	AD=D+A
	@192 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 28
	D=A // D holds previous addr
	@32
	AD=D+A
	@384 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// row 29
	D=A // D holds previous addr
	@32
	AD=D+A
	@256 // A holds val
	D=D+A // D = addr + val
	A=D-A // A=addr + val - val = addr
	M=D-A // RAM[addr] = val
	// return
	A=M
	D;JMP
    (END)
    @END
    0;JMP
```
