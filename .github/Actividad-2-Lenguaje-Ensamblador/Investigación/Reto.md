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
- **R/** Una variable es un espacio en la memoria que se utiliza para guardar un valor que puede cambiar a lo largo de la ejecución del programa. En lenguaje ensamblador, una variable representa una dirección de memoria a la que podemos acceder para leer o escribir un dato. Por ejemplo, i y sum son variables que usamos para llevar la cuenta y sumar números, respectivamente.
- **¿Qué es la dirección de una variable?**
- **R/** La dirección de una variable es el número que identifica la ubicación exacta en la memoria RAM donde esa variable está guardada. Es como la "dirección de una casa" donde vive el dato.
Por ejemplo, si i está en RAM[16], entonces su dirección es 16, y así sabemos dónde buscar o guardar su valor.
- **¿Qué es el contenido de una variable?**
- **R/** El contenido de una variable es el valor que está almacenado en su dirección de memoria. Por ejemplo, si i está en RAM[16] y en ese momento tiene el valor 5, entonces el contenido de la variable i es 5. Ese valor puede cambiar durante el programa (como cuando se incrementa i++).
