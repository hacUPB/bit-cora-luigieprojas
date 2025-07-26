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

**9. ¿Qué hace este programa?**
R/ 




