**1. Escribe un programa en lenguaje ensamblador que sume los primeros 100 números naturales.**
```
int i = 1;
int sum = 0;
While (i <= 100){
   sum += i;
   i++;
}
```
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
- **R/**
- **¿Qué es la dirección de una variable?**
- **¿Qué es el contenido de una variable?**
