c### Actividad 1

- **¿Qué es la entrada-salida mapeada a memoria?**
**R/** La entrada-salida mapeada a memoria (o memory-mapped I/O) es una técnica donde ciertos rangos de la memoria RAM están reservados para representar dispositivos de entrada y salida, como la pantalla o el teclado. Es decir, en vez de usar instrucciones especiales para controlar estos dispositivos, simplemente se leen o escriben valores en direcciones específicas de memoria y eso automáticamente interactúa con el hardware.
- ¿Cómo se implementa en la plataforma Hack?
**R/** En la arquitectura Hack esto se hace asignando rangos fijos en la memoria para representar tanto la pantalla (SCREEN) como el teclado (KBD). Por ejemplo:

La dirección 16384 (0x4000) en adelante representa la pantalla (cada palabra representa 16 pixeles en horizontal).

La dirección 24576 (0x6000) representa el estado actual del teclado (el código ASCII de la tecla presionada, o 0 si no hay ninguna).
Así, para dibujar en pantalla, se escribe directamente en la RAM empezando desde la dirección SCREEN, y para leer del teclado, se accede al valor almacenado en KBD
- Inventa un programa que haga uso de la entrada-salida mapeada a memoria.
- Investiga el funcionamiento del programa con el simulador.

### Actividad 3

Vas a implementar y simular una modificación al reto 20 de la unidad anterior. Si se presiona la letra “d” muestras la imagen que diseñaste en el reto 18. Si no se presiona ninguna tecla, borrarás la imagen.

**R/**  
```

```
### Actividad 4

Ahora realizarás una nueva variación al programa de la actividad anterior. Si se presiona la letra “d” muestras la imagen que diseñaste en el reto 18. Solo si se presiona la letra “e” borrarás la imagen que se muestra en pantalla.

```
@KBD
D=M
@100
D=D-A
@DRAW
D;JEQ
@KBD
D=M
@101
D=D-A
@ERASE
D;JEQ
@START
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
@END
0;JMP

(ERASE)
@0
D=A
@i
M=D
@800
(LOOP)
@i
D=M
@16384
D=D+A
@addr
M=D
@0
D=A
@addr
A=M
M=D
@i
M=M+1
@800
D=A
@i
D=D-A
@LOOP
D;JLT

@END
0;JMP

(END)
@END
0;JMP
```
