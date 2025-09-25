# Sesión 1

**¿Qué representa la clase Particle?** 

La clase Particle es una plantilla (o plano) que describe cómo debe ser una partícula en este programa. Define que toda partícula tendrá dos atributos (x y y, que representan su posición en un plano 2D) y un comportamiento (move, que permite cambiar esa posición). En sí misma, la clase no ocupa memoria; solo describe la estructura y funciones que tendrán los objetos creados a partir de ella.

**¿Cómo interactúan sus atributos y métodos?**

Los atributos x y y guardan el estado interno de cada objeto Particle. El método move actúa sobre ese estado: recibe valores dx y dy, y los suma a x e y, actualizando la posición. Cada objeto tiene su propia copia de x e y, y cuando se llama a move sobre un objeto en particular, solo se modifican sus atributos, no los de otros objetos. 

**Prompt para ChatGPT: explícame en detalle qué es un objeto en C++ y cómo se relaciona con una clase. Usa el ejemplo de una clase Particle con atributos x y y y un método move.** 

**R/**

**¿Qué es un objeto y cómo se relaciona con una clase?**

- **Clase =** plano/blueprint: define el tipo (qué datos hay y qué operaciones se pueden hacer).
- **Objeto =** instancia concreta de una clase en tiempo de ejecución: tiene memoria reservada para sus atributos y un tiempo de vida (construcción → uso → destrucción).
- **Ejemplo:** class Particle { float x,y; void move(float dx,float dy); };

- La clase Particle describe que un Particle tiene dos float (x,y) y un comportamiento move.
- Cuando escribes Particle p; creas un objeto p con su propio x e y. 

**¿Qué pasa en memoria? (conceptos clave)**

**Datos (miembros):** para cada objeto existen los bytes necesarios para sus atributos. En Particle típicamente tendrás x seguido de y contiguos (dos float de 4 bytes cada uno), salvo padding/alineación.

**Código (métodos):** el código del método no se duplica por objeto. Las funciones miembro se compilan a código (en la sección de texto) y se llaman pasando un puntero oculto this.

**Conceptualmente:** 

```
// azúcar sintáctica
p.move(1,2);

// lo que compila (conceptualmente)
Particle_move(&p, 1.0f, 2.0f);
```
Es decir, move es una función que recibe Particle* this como primer argumento. 

- **Tamaño del objeto:** sizeof(Particle) = suma de tamaños de sus miembros más padding. Si añades una función virtual, el objeto suele ganar un vptr (puntero a la tabla virtual) y sizeof aumenta.
- **vtable / polimorfismo:** si la clase tiene funciones virtual, el compilador suele añadir un puntero (vptr) por objeto que apunta a la vtable compartida. La resolución de llamadas virtuales se hace en tiempo de ejecución mediante esa tabla.

- **Stack vs Heap:**

  - Particle p; → objeto en stack (almacenamiento automático), destrucción al salir del scope.
  - Particle* q = new Particle(); → objeto en heap, vives hasta delete q;.

- **Arrays / contigüidad:** Particle arr[10]; almacena 10 objetos contiguos (útil para rendimiento por locality).

**'this' y cómo 'move' modifica el objeto**

Dentro de Particle::move, el compilador pasa implícitamente this (puntero al objeto sobre el que se llamó). Así x += dx; es en realidad this->x = this->x + dx;. Por eso p.move(...) modifica p. 

Luego de esto ChatGPT me propuso un experimento:

Experimento 1: Representación básica de objetos en memoria 

🎯 Objetivo:

Explorar cómo se almacenan los objetos en memoria en C++. Para ello, se crean dos instancias de la clase Particle, se imprime su dirección de memoria, el tamaño del objeto y las direcciones de sus atributos, con el fin de analizar la organización interna de los datos.

📋 Descripción del experimento
Código completo en main.cpp en un archivo de Visual Studio:

```
#include <iostream>
using namespace std;

class Particle {
public:
    float x, y;
    void move(float dx, float dy) {
        x += dx;
        y += dy;
    }
};

int main() {
    Particle p1;
    Particle p2;

    cout << "Direccion de p1: " << &p1 << endl;
    cout << "Direccion de p2: " << &p2 << endl;

    cout << "Tamaño de Particle: " << sizeof(Particle) << " bytes" << endl;

    cout << "Direccion de p1.x: " << &(p1.x) << endl;
    cout << "Direccion de p1.y: " << &(p1.y) << endl;

    return 0;
}
```
Se definió la clase: 

```
class Particle {
public:
    float x, y;
    void move(float dx, float dy) {
        x += dx;
        y += dy;
    }
};
```
Se declararon dos instancias (p1 y p2) y se imprimieron:

- Dirección de cada objeto.
- Tamaño del objeto (sizeof).
- Dirección de los atributos x y y.

**Vídeo Evidencia Experimento**

https://github.com/user-attachments/assets/3b1a6100-6a78-4d58-80da-28e08266b89b 

🔍 Análisis de resultados

Ejecución en Visual Studio mostró:

```
Direccion de p1: 00000026405BF9B8
Direccion de p2: 00000026405BF9D8
Tamaño de Particle: 8 bytes
Direccion de p1.x: 00000026405BF9B8
Direccion de p1.y: 00000026405BF9BC
```
- El tamaño de Particle es 8 bytes, correspondiente a dos float de 4 bytes cada uno.
- Los atributos x e y están almacenados de manera contigua en memoria (direcciones separadas por 4 bytes).
- La diferencia entre p1 y p2 es de 32 bytes, lo que evidencia que el compilador reserva bloques alineados en la pila, no necesariamente el mínimo tamaño.
- Los métodos (move) no ocupan espacio en cada instancia, pues residen en la sección de código del programa.

**🧠 Reflexión**

- Un objeto en memoria está compuesto únicamente por sus atributos (datos miembros).
- Los atributos se almacenan de forma contigua, lo que permite acceder a ellos eficientemente.
- El tamaño de un objeto depende de sus atributos, no de sus métodos.
- El compilador puede aplicar padding o alineación, lo cual explica por qué la separación entre objetos puede ser mayor que el sizeof.

**Conclusión:** Comprender cómo se almacenan los objetos permite diseñar clases más eficientes, optimizando el uso de memoria y anticipando comportamientos relacionados con la alineación y el acceso a datos. 

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
