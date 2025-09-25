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
