# Sesión 1

**¿Qué representa la clase Particle?** 

La clase Particle es una plantilla (o plano) que describe cómo debe ser una partícula en este programa. Define que toda partícula tendrá dos atributos (x y y, que representan su posición en un plano 2D) y un comportamiento (move, que permite cambiar esa posición). En sí misma, la clase no ocupa memoria; solo describe la estructura y funciones que tendrán los objetos creados a partir de ella.

**¿Cómo interactúan sus atributos y métodos?**

Los atributos x y y guardan el estado interno de cada objeto Particle. El método move actúa sobre ese estado: recibe valores dx y dy, y los suma a x e y, actualizando la posición. Cada objeto tiene su propia copia de x e y, y cuando se llama a move sobre un objeto en particular, solo se modifican sus atributos, no los de otros objetos.

**¿Los atributos están almacenados de forma contigua?** 

Sí. Normalmente, los atributos de una clase se almacenan en la memoria de forma contigua en cada objeto. En Particle, x y y suelen estar uno al lado del otro (primero x, luego y). Puede existir padding (espacio de relleno) por alineación, pero con dos float seguidos casi siempre estarán contiguos. 

**¿Qué indica el tamaño del objeto sobre su estructura interna?** 

sizeof(Particle) indica cuántos bytes ocupa cada objeto en memoria. En este caso debería ser 8 bytes (dos float de 4 bytes cada uno). Si hubiera padding, herencia o punteros internos (por ejemplo, al usar funciones virtual), el tamaño podría ser mayor. 

**Si tengo dos instancias de Particle, ¿cómo se relacionan sus direcciones de memoria?**

Cada instancia (p1, p2) vive en una zona distinta de la memoria (por ejemplo, en el stack si se declararon como variables locales). Sus direcciones no son contiguas necesariamente; dependen de cómo el compilador organice las variables en el stack. Lo importante es que cada instancia tiene su propio bloque de memoria para x e y. 

**¿Cómo afectan los datos estáticos al tamaño de la instancia?** 

Los atributos estáticos no ocupan espacio dentro de cada objeto, porque no pertenecen a la instancia sino a la clase. Se almacenan una sola vez en la memoria (en la sección data o bss del programa).
👉 Eso significa que sizeof(StaticData) refleja únicamente los miembros de instancia (a), no el static int s.

**¿Qué diferencias hay entre datos estáticos y dinámicos en términos de memoria?**

**Estáticos (static):**

- Se comparten entre todas las instancias.
- Tienen una única dirección en memoria.
- No cambian el tamaño de los objetos.

**Dinámicos (new, delete):**

- Cada objeto puede reservar memoria adicional en el heap.
- El tamaño del objeto solo incluye el puntero (ptr), no los datos que apunta.
- La memoria dinámica se administra manualmente en el constructor y destructor.

**¿Las variables estáticas ocupan espacio en cada objeto?** 

No. Solo existen una vez en memoria, independiente de cuántas instancias haya. 

**Reflexión** 

**¿Qué es un objeto desde la perspectiva de la memoria?** 

Un objeto es un bloque de memoria que contiene los atributos definidos en su clase. Cada instancia tiene su propia copia de esos atributos, organizada de manera contigua en la memoria. Los métodos no ocupan espacio en el objeto; el código de los métodos está almacenado de manera global en la sección de texto del programa. 

**¿Cómo influyen los atributos y métodos en el tamaño y estructura del objeto?**

- Los atributos no estáticos determinan directamente el tamaño del objeto (sizeof).
- Los atributos estáticos no aumentan el tamaño del objeto, porque existen de manera independiente en memoria.
- Los atributos dinámicos solo añaden el espacio del puntero dentro del objeto. La memoria extra reservada con new se encuentra en el heap, no dentro de la instancia.
- Los métodos no influyen en el tamaño de la instancia (salvo si son virtual, en cuyo caso se añade un puntero oculto a la vtable).

**Conclusión** 

El tamaño y estructura de un objeto en memoria dependen exclusivamente de sus miembros de instancia. Esto significa que, al diseñar clases, es importante distinguir entre:

- Lo que pertenece a cada objeto (atributos normales → ocupan memoria en cada instancia).
- Lo que pertenece a la clase completa (atributos estáticos → una sola copia compartida).
- Lo que se gestiona dinámicamente (punteros → tamaño fijo en el objeto, pero memoria extra en el heap).
Este entendimiento es clave para optimizar el uso de memoria y evitar errores de gestión, especialmente en programas que manejan muchos objetos o estructuras complejas.
