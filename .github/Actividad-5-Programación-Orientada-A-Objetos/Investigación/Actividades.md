# Sesión 1

# Introducción a los Objetos

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

# Experimento 1: Representación básica de objetos en memoria 

**🎯 Objetivo:**

Explorar cómo se almacenan los objetos en memoria en C++. Para ello, se crean dos instancias de la clase Particle, se imprime su dirección de memoria, el tamaño del objeto y las direcciones de sus atributos, con el fin de analizar la organización interna de los datos.

**📋 Descripción del experimento** 

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

**📖 Expectativa previa**

Dado que la clase Particle tiene dos atributos float, se espera que el tamaño del objeto (sizeof(Particle)) sea de 8 bytes (4 bytes por cada atributo). Asimismo, se anticipa que los atributos x e y se almacenen de manera contigua en memoria, separados por exactamente 4 bytes.
En cuanto a las direcciones de p1 y p2, se espera que cada instancia esté ubicada en una región distinta de la memoria de la pila. Sin embargo, debido al alineamiento de memoria que aplica el compilador, es posible que la separación entre ambos objetos no sea exactamente de 8 bytes, sino un valor mayor.
Finalmente, se prevé que los métodos no ocupen espacio en la instancia, ya que el código de las funciones reside en la sección de texto del programa, no dentro del objeto.

**Vídeo Evidencia Experimento**

https://github.com/user-attachments/assets/3b1a6100-6a78-4d58-80da-28e08266b89b 

**🔍 Análisis de resultados**

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

**¿Cómo se almacenan los objetos en memoria en C++?**

Los objetos en C++ se almacenan en memoria mediante asignación en la pila para variables locales (automáticas) con vida limitada, en el montón para datos dinámicos gestionados manualmente con new y delete o por punteros inteligentes, y en la zona de datos/bss para variables globales o estáticas. La asignación en el montón ofrece flexibilidad pero requiere gestión cuidadosa, mientras que la pila es más eficiente para objetos de tamaño fijo y ciclo de vida corto. 

**Si tengo dos instancias de Particle, ¿cómo se relacionan sus direcciones de memoria? ¿Los atributos están contiguos?**

Cada instancia (p1, p2) vive en una zona distinta de la memoria (por ejemplo, en el stack si se declararon como variables locales). Sus direcciones no son contiguas necesariamente; dependen de cómo el compilador organice las variables en el stack. Lo importante es que cada instancia tiene su propio bloque de memoria para x e y. 

Hice ahora la siguiente experimentación:

🔬 Experimento 2: Objetos en arreglos
🎯 Objetivo

Verificar si los objetos de una clase en C++ se almacenan de forma contigua cuando se crean dentro de un arreglo.

📋 Código usado

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
    Particle arr[3];  // Array de 3 objetos Particle

    cout << "Tamaño de Particle: " << sizeof(Particle) << " bytes" << endl;

    for (int i = 0; i < 3; i++) {
        cout << "Direccion de arr[" << i << "]: " << &arr[i] << endl;
        cout << "  Direccion de arr[" << i << "].x: " << &(arr[i].x) << endl;
        cout << "  Direccion de arr[" << i << "].y: " << &(arr[i].y) << endl;
    }

    return 0;
}

```

📖 Expectativa previa

Sabemos que sizeof(Particle) es de 8 bytes (dos float). Por tanto, esperamos que:

- Cada objeto dentro del arreglo esté separado por exactamente 8 bytes.
- Los atributos x e y de cada objeto se encuentren contiguos (4 bytes de diferencia).
- A diferencia de los objetos independientes (Exp. 1), en los arreglos no debería haber espacios extra de alineación entre elementos, ya que los arrays en C++ garantizan almacenamiento secuencial.

**Vídeo evidencia de experimento:**

https://github.com/user-attachments/assets/dc44f2c0-43d3-4be9-b0a1-bb50622c8608 

📊 Resultados obtenidos

```
Tamaño de Particle: 8 bytes
Direccion de arr[0]: 000000A2D83BFAC8
  Direccion de arr[0].x: 000000A2D83BFAC8
  Direccion de arr[0].y: 000000A2D83BFACC
Direccion de arr[1]: 000000A2D83BFAD0
  Direccion de arr[1].x: 000000A2D83BFAD0
  Direccion de arr[1].y: 000000A2D83BFAD4
Direccion de arr[2]: 000000A2D83BFAD8
  Direccion de arr[2].x: 000000A2D83BFAD8
  Direccion de arr[2].y: 000000A2D83BFADC
```
🔍 Análisis de resultados

1. El tamaño del objeto Particle sigue siendo 8 bytes, igual que en el Experimento 1.
2. La dirección de arr[0], arr[1] y arr[2] aumenta de 8 en 8 bytes, confirmando que los objetos se guardan contiguos en memoria dentro del arreglo.
3. Dentro de cada objeto, los atributos x e y siguen estando separados por 4 bytes (contiguos).
4. Se cumple la expectativa de que, en un arreglo, no hay padding extra entre elementos.

🧠 Reflexión

- En un arreglo de objetos, cada elemento se ubica uno al lado del otro en memoria.
- Esto confirma que los arrays en C++ son estructuras de datos contiguas, lo que permite recorrerlos de manera muy eficiente.
- Los atributos siguen contiguos dentro de cada objeto, reforzando que un objeto es un bloque compacto de memoria con sus datos.

**Conclusión:** Los arreglos en C++ almacenan sus objetos de manera secuencial y sin espacios extra, cumpliendo con la expectativa. Esto hace que los accesos sean predecibles y rápidos, un aspecto crucial para el diseño de estructuras de datos y simulaciones de gran escala. 

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

**Experimento 3: Inclusión de un método en la clase**

**🔹 En qué consiste**

En este experimento se modifica la clase Particle para incluir un método que realice una operación sencilla, como imprimir sus atributos o calcular algo básico. El objetivo es observar si al agregar métodos cambia el tamaño del objeto o la disposición de sus atributos en memoria.

**🎯 Objetivo**

Verificar si los métodos forman parte de la instancia de un objeto en C++ o si, por el contrario, solo existen en la sección de código del programa.

**📖 Expectativa previa**

Se espera que, al añadir un método dentro de la clase, el tamaño del objeto (sizeof) se mantenga igual (8 bytes en este caso) y que las direcciones de los atributos no cambien. Esto se debe a que el código de los métodos se almacena en la memoria de texto del programa y no se guarda dentro de cada instancia.

**Vídeo evidencia**

https://github.com/user-attachments/assets/7a0fc70a-9bf7-4564-b64f-a422b48f3e72

**Análisis de resultados:** 

El programa mostró que el tamaño de Particle sigue siendo de 8 bytes, el mismo que en experimentos anteriores. Las direcciones de memoria de x e y permanecen contiguas dentro de la instancia p1. La invocación del método imprime la posición, pero no altera la estructura del objeto en memoria.

**Conclusión**

Esto demuestra que en C++ los objetos contienen solo sus datos (atributos), mientras que los métodos se almacenan de manera separada en el código ejecutable. Así se refuerza la idea de que la clase es una plantilla que define tanto datos como comportamientos, pero solo los datos ocupan espacio en cada objeto creado.

# Reflexión 

**¿Qué es un objeto desde la perspectiva de la memoria?** 

Un objeto en C++ es una región de memoria que almacena únicamente los atributos definidos en su clase. Cada instancia tiene su propio espacio reservado para estos datos, mientras que los métodos no residen dentro del objeto, sino en la sección de código del programa. Desde la memoria, entonces, un objeto es un bloque de bytes que representa el estado de esa instancia.

**¿Cómo influyen los atributos y métodos en el tamaño y estructura del objeto?**

Los atributos determinan directamente el tamaño y la disposición interna del objeto. Como se vio en los experimentos, los atributos x e y de tipo float ocupan 8 bytes en total y se almacenan de forma contigua. Al crear un arreglo de objetos, estos se ubican uno tras otro en memoria, respetando ese mismo tamaño fijo. En cambio, los métodos no aumentan el tamaño del objeto: al agregar una función como printPosition, el tamaño de la clase no cambió, lo que demuestra que los métodos solo aportan comportamiento, no almacenamiento adicional en cada instancia.

**Conclusión: resumir los hallazgos y cómo esto impacta el diseño de clases.** 

Los experimentos demuestran que:

- Los objetos son bloques de memoria que almacenan únicamente los datos (atributos).
- Los métodos no alteran el tamaño del objeto, ya que se almacenan por separado en el programa.
- La organización contigua de los atributos en arreglos permite comprender cómo los compiladores optimizan el uso de memoria.

Este entendimiento impacta el diseño de clases porque obliga a ser consciente de la cantidad y el tipo de atributos que se definen: cada atributo implica memoria en cada objeto. Los métodos, en cambio, pueden ser diseñados libremente sin preocupación de aumentar el tamaño de las instancias.

# Sesión 2

**Parte 1: Análisis de la estructura de una clase**

**¿Dónde se almacenan los datos y métodos de una clase en C++ en la memoria?**

- Los atributos (datos) de una clase se almacenan dentro de cada objeto creado.

  - Si el objeto se crea como variable local, vive en la pila (stack).
  - Si se crea con new, vive en el heap.

- Los métodos no se copian dentro de cada objeto. En realidad, el código de los métodos está en la sección de código (text segment) del programa. Todos los objetos comparten esas instrucciones.

**Explica el concepto de vtable y cómo se relaciona con los métodos virtuales.**

- La vtable (virtual table) es una tabla de punteros generada por el compilador cuando una clase declara al menos un método virtual.

  - Cada clase con métodos virtuales tiene una única vtable.
  - Cada objeto de esa clase guarda un puntero oculto a su vtable.
  - Al invocar un método virtual, el programa consulta la vtable del objeto en tiempo de ejecución para determinar qué versión del     método debe llamar (base o derivada).

**🧪 Experimento 4 — Análisis de la estructura de una clase**

**Objetivo:**

Observar cómo los atributos y métodos de una clase se organizan en la memoria, y comprobar que los métodos no afectan al tamaño del objeto (porque residen en la sección de código del programa).

**Código a ejecutar:**

```
#include <iostream>
using namespace std;

class Simple {
public:
    int a;
};

class Complex {
public:
    int a, b, c;
    void method1() {}
    void method2() {}
};

int main() {
    cout << "Tamaño de Simple: " << sizeof(Simple) << " bytes" << endl;
    cout << "Tamaño de Complex: " << sizeof(Complex) << " bytes" << endl;
    return 0;
}
```
**Qué esperamos:**

- Simple solo tiene un int, así que su tamaño debería ser igual al tamaño de un entero (usualmente 4 bytes).
- Complex tiene tres ints, por lo que su tamaño debería rondar 12 bytes (o quizás 16 si hay padding/alineación de memoria).
- Los métodos no cambian el tamaño de los objetos, porque el código está almacenado en la sección de texto del programa, no dentro de cada objeto. 

**Evidencia Experimento**

https://github.com/user-attachments/assets/4c88b317-51d9-43c9-9737-4d2db2dc82ef

**Análisis y reflexión:**

- Simple contiene un único atributo de tipo int, por lo que su tamaño corresponde al de un entero en este entorno (4 bytes).
- Complex contiene tres enteros, lo que da un total de 12 bytes.
- Los métodos method1 y method2 no aumentaron el tamaño del objeto, ya que el código de los métodos se almacena en la sección de texto (código) del programa y se comparte entre todas las instancias.
- Esto confirma que el tamaño de un objeto depende únicamente de sus atributos, no de la cantidad de métodos que tenga. 

**Conclusión:**

En C++, los atributos de una clase determinan el tamaño en memoria de sus instancias, mientras que los métodos no influyen en el tamaño porque su código se almacena fuera de los objetos. Este hallazgo es clave para el diseño de clases eficientes: agregar más funciones no penaliza en memoria, pero agregar más atributos sí lo hace. 

**Parte 2: Exploración de métodos virtuales** 

**¿Cómo afecta la presencia de métodos virtuales al tamaño del objeto?** 

La presencia de métodos virtuales añade al objeto un puntero oculto a la vtable, lo que incrementa el tamaño de cada instancia (típicamente 4 bytes en sistemas de 32 bits, 8 bytes en sistemas de 64 bits). 

**¿Qué papel juegan las vtables en el polimorfismo?** 

Las vtables permiten que, incluso si una variable es declarada como tipo Base pero apunta a un Derived, se invoque correctamente la implementación de Derived. Esto es lo que hace posible el polimorfismo dinámico.

**¿Cómo se implementan los métodos virtuales en C++? Explica el concepto de vtable y cómo se utiliza para resolver llamadas a métodos virtuales.**

**R/** En C++, los métodos virtuales se implementan usando una estructura oculta llamada vtable (virtual table o tabla de funciones virtuales).

**¿Qué es la vtable?** 

- La vtable es una tabla creada por el compilador para cada clase que tenga al menos un método virtual.
- Contiene un conjunto de punteros a funciones que representan las implementaciones de los métodos virtuales de esa clase.
- Cada clase con métodos virtuales tiene su propia vtable. 

**¿Cómo acceden los objetos a la vtable?** 

- Cada objeto de una clase con métodos virtuales guarda un puntero oculto a la vtable (generalmente el primer campo del objeto).
- Este puntero es insertado automáticamente por el compilador y apunta a la vtable correspondiente al tipo real del objeto.
- Por eso, aunque una variable esté declarada como tipo Base, si realmente guarda un Derived, su puntero oculto a la vtable apunta a la tabla de Derived.

3. Resolviendo llamadas virtuales (despacho dinámico)

Cuando se llama a un método virtual:

1. El compilador no inserta una llamada directa.
2. En su lugar, sigue el puntero oculto a la vtable del objeto.
3. Busca en la posición correspondiente de la tabla el puntero a la función.
4. Ejecuta la función encontrada (que puede ser la de la clase base o una redefinida en la derivada).

De esta manera, el método invocado depende del tipo dinámico del objeto, no de su tipo estático (el declarado).

**Ejemplo Ilustrativo**

```
#include <iostream>
using namespace std;

class Base {
public:
    virtual void display() {
        cout << "Base display" << endl;
    }
};

class Derived : public Base {
public:
    void display() override {
        cout << "Derived display" << endl;
    }
};

int main() {
    Base* b1 = new Base();
    Base* b2 = new Derived();

    b1->display(); // Usa la vtable de Base → imprime "Base display"
    b2->display(); // Usa la vtable de Derived → imprime "Derived display"

    delete b1;
    delete b2;
}
```
**Explicación interna:**

- b1 apunta a un objeto Base, cuyo puntero oculto a vtable referencia la vtable de Base.
- b2 apunta a un objeto Derived, cuyo puntero oculto a vtable referencia la vtable de Derived.
- En cada llamada a display(), el compilador busca la función en la posición correspondiente de la vtable activa. 

5. Impacto en memoria y rendimiento

- Memoria: cada objeto con métodos virtuales ocupa más espacio, porque necesita guardar un puntero adicional a la vtable.
- Rendimiento: las llamadas virtuales son ligeramente más lentas que las normales, porque requieren una indirección extra (buscar en la tabla antes de llamar).
- Flexibilidad: esta pequeña penalización se compensa con la capacidad de soportar polimorfismo dinámico, fundamental en OOP. 

Los métodos virtuales en C++ se implementan con vtables. Cada objeto guarda un puntero oculto a la vtable de su clase. Cuando se invoca un método virtual, el programa consulta la vtable para determinar qué función ejecutar, permitiendo que objetos derivados redefinan el comportamiento de los métodos heredados.


**🧪 Experimento 5: Métodos virtuales y vtables**

**Objetivo:** 

Analizar cómo la introducción de métodos virtuales en las clases afecta el tamaño de los objetos y observar la generación de tablas virtuales (vtables).

**Código Utilizado:**

```
#include <iostream>
using namespace std;

class Base {
public:
    virtual void display() {
        cout << "Base display" << endl;
    }
};

class Derived : public Base {
public:
    void display() override {
        cout << "Derived display" << endl;
    }
};

int main() {
    cout << "Tamaño de Base: " << sizeof(Base) << " bytes" << endl;
    cout << "Tamaño de Derived: " << sizeof(Derived) << " bytes" << endl;

    Base b;
    Derived d;

    // Direcciones de las vtables
    cout << "Vtable de Base: " << *(void**)&b << endl;
    cout << "Vtable de Derived: " << *(void**)&d << endl;

    // Prueba de polimorfismo
    Base* ptr = &d;
    ptr->display();

    return 0;
}
```

**Evidencia Experimento:**

https://github.com/user-attachments/assets/b9ad029f-c5f3-4791-860c-854806f9a43a

**Resultados obtenidos:**

```
Tamaño de Base: 8 bytes
Tamaño de Derived: 8 bytes
Vtable de Base: 00007FF68F7EBCF8
Vtable de Derived: 00007FF68F7EBD20
Base display
Derived display
```

**Análisis y reflexión:**

- Tanto Base como Derived tienen un tamaño de 8 bytes, lo cual corresponde al puntero oculto a la vtable (en arquitecturas de 64 bits, un puntero = 8 bytes).
- Las direcciones de las vtables son distintas (Base y Derived), lo que confirma que cada clase con métodos virtuales tiene su propia tabla virtual.
- La llamada a ptr->display(); demuestra el polimorfismo dinámico: aunque el puntero es de tipo Base*, la ejecución corresponde al método redefinido en Derived.
- La presencia de métodos virtuales no aumenta el tamaño de los objetos con respecto a otros que también tengan vtables: basta un puntero a la tabla para acceder a las funciones virtuales.

**Conclusión:** 

El uso de métodos virtuales en C++ introduce un puntero oculto a la vtable, lo que explica que el tamaño mínimo de un objeto con virtual functions sea el de un puntero (8 bytes en sistemas de 64 bits). Las vtables permiten la implementación de polimorfismo dinámico, ya que cada clase mantiene su propia tabla con las direcciones de sus métodos virtuales.

**Parte 3: Uso de punteros y referencias**

- **¿Cuál es la relación entre los punteros a métodos y la vtable?**

**

R/** Los punteros a funciones no dependen de la vtable. Solo almacenan una dirección de función estática o global dentro del objeto.
En cambio, los métodos virtuales sí se resuelven mediante la vtable, que almacena direcciones de funciones virtuales para permitir polimorfismo dinámico.

- **¿Cómo afectan estos mecanismos al rendimiento del programa?**

**R/** - Punteros a funciones: la llamada es casi tan rápida como una llamada directa porque solo implica saltar a la dirección guardada en el puntero.
- Métodos virtuales (vtable): añaden una indirección extra (buscar en la tabla la función correspondiente), lo que introduce un pequeño costo adicional en tiempo de ejecución, aunque permite flexibilidad y polimorfismo.

- **¿Qué diferencia hay entre punteros a funciones y punteros a métodos miembro en C++? ¿Cómo afectan al tamaño de los objetos y al rendimiento?**

**R/** - Punteros a funciones: almacenan solo la dirección de una función global o estática. Su tamaño suele ser igual al de un puntero (4 u 8 bytes, según la arquitectura). El impacto en el tamaño del objeto es mínimo.

- Punteros a métodos miembro: son más complejos porque deben incluir información extra (como cómo acceder al this) para invocar funciones ligadas a una instancia. Por esto, suelen ser más grandes que los punteros a funciones y ligeramente más lentos. 

🧪 Experimento 6: Uso de punteros a funciones en clases

Objetivo:
Explorar cómo los punteros a funciones se integran en una clase, analizar su impacto en el tamaño de la instancia y compararlos con los métodos virtuales en cuanto a memoria y rendimiento.

Código utilizado:

```
#include <iostream>
using namespace std;

class FunctionPointerExample {
public:
    void (*funcPtr)();  // Puntero a función estática o libre

    static void staticFunction() {
        cout << "Static function called" << endl;
    }

    void assignFunction() {
        funcPtr = staticFunction;
    }

    void callFunction() {
        if (funcPtr) {
            funcPtr();
        }
    }
};

int main() {
    FunctionPointerExample obj;

    cout << "Tamaño de FunctionPointerExample: "
         << sizeof(FunctionPointerExample) << " bytes" << endl;

    obj.assignFunction();
    obj.callFunction();

    return 0;
}
```
**Expectativa del experimento:** 

En este experimento se esperaba comprobar que al incluir un puntero a función dentro de una clase, el tamaño de la instancia estaría determinado únicamente por el espacio necesario para almacenar dicho puntero (generalmente 4 bytes en sistemas de 32 bits o 8 bytes en sistemas de 64 bits). Además, se anticipaba que la función estática no incrementaría el tamaño de cada objeto, ya que reside en la sección de código del programa. Con esto se buscaba entender la diferencia entre almacenar datos dentro de un objeto y simplemente guardar referencias (punteros) hacia funciones ya definidas, lo que permite analizar cómo los punteros influyen en la eficiencia y en la forma en que se llaman los métodos.

**Evidencia Experimento**

https://github.com/user-attachments/assets/239e325a-d6eb-41b1-ad53-65056be9af1c

**Resultado obtenido:**

```
Tamaño de FunctionPointerExample: 8 bytes
Static function called
```

**Analisis**

- El tamaño de la clase corresponde únicamente al espacio necesario para almacenar el puntero a función (8 bytes en un sistema de 64 bits).
- La función estática no ocupa espacio en cada objeto, ya que reside en la sección de código del programa. Lo único que se guarda en la instancia es el puntero que referencia a esa función.
- La llamada a través de un puntero de función es directa (salto a la dirección contenida en el puntero), sin pasar por una vtable, lo que la hace eficiente.

**Reflexión Individual**

**¿Dónde residen los datos y métodos de una clase en la memoria?**

los datos (funcPtr) están en el heap o stack dependiendo de dónde se instancie el objeto; los métodos (staticFunction) están en la sección de código del programa.

**¿Cómo interactúan las diferentes partes en tiempo de ejecución?**

el objeto mantiene el puntero y, al llamar callFunction, salta a la dirección almacenada en funcPtr. No hay necesidad de buscar en la vtable.

**Conclusión: cómo esta comprensión afecta el diseño de sistemas.**

Comprender cómo funcionan los punteros a funciones frente a métodos virtuales permite decidir cuándo usar cada uno. Los punteros a funciones son útiles para callbacks simples y reducen overhead, mientras que los métodos virtuales son preferibles cuando se necesita polimorfismo y extensibilidad.

## Sesión 3 Unidad 5 Sistemas Computacionales

**¿Cómo implementa el compilador el encapsulamiento en C++? Si los miembros privados aún ocupan espacio en el objeto, ¿Qué impide que se acceda a ellos desde fuera de la clase?**

El compilador en C++ implementa el encapsulamiento a través de las reglas de acceso (public, protected, private). Cuando declaramos miembros privados, estos siguen ocupando espacio dentro del objeto, es decir, físicamente están en la memoria del objeto igual que los miembros públicos. Lo que cambia es que el compilador restringe el acceso directo: si intentamos acceder desde fuera de la clase a una variable privada, el compilador lanza un error de acceso antes de siquiera generar el binario. 

En otras palabras, el impedimento no es físico, sino lógico: el compilador coloca una “barrera” en tiempo de compilación que evita que el programador use directamente esos datos desde el exterior. Sin embargo, al inspeccionar la memoria (como lo hice en la captura que añadí a la bitácora), puede verse que los miembros privados están almacenados dentro del mismo bloque de memoria que forma parte del objeto. 

Esto demuestra que el encapsulamiento es una abstracción que protege la integridad del diseño y evita que se rompan las reglas de uso establecidas por la clase, aunque en el nivel más bajo la memoria esté igualmente reservada. 

1. ¿Qué es el encapsulamiento y cuál es su propósito en la programación orientada a objetos? 

 El encapsulamiento es el principio de ocultar los detalles internos de una clase y exponer solo lo necesario a través de una interfaz pública. Su propósito es proteger los datos, garantizar la modularidad y evitar que el estado interno de un objeto sea manipulado de forma incorrecta desde fuera de la clase. 
 
2. ¿Por qué es importante proteger los datos de una clase y restringir el acceso desde fuera de la misma? 

 Porque ayuda a mantener la integridad del objeto: previene cambios indebidos, evita errores difíciles de depurar y asegura que las reglas de negocio se cumplan únicamente a través de los métodos definidos. 
 
3. ¿Qué significa reinterpret_cast y cómo afecta la seguridad del programa? 

 reinterpret_cast es un tipo de conversión en C++ que permite tratar una dirección de memoria como si fuese de otro tipo arbitrario. Aunque puede ser útil en casos de bajo nivel, rompe las garantías de seguridad del lenguaje, ya que el compilador no puede verificar si el acceso es válido o seguro. 
 
4. ¿Por qué crees que se pudo acceder a los miembros privados de MyClass en este experimento, a pesar de que el compilador normalmente lo impediría? 

 Porque las restricciones de acceso (private, protected, public) son solo reglas aplicadas en tiempo de compilación. Una vez generado el programa, todos los miembros ocupan posiciones de memoria contiguas dentro del objeto. Al manipular directamente las direcciones de memoria con punteros, se ignoran esas reglas. 
 
5. ¿Cuáles podrían ser las consecuencias de utilizar técnicas como las mostradas en este experimento en un programa real? 

 Podrían corromper datos internos, causar comportamientos indefinidos, vulnerabilidades de seguridad (por ejemplo, exploits), y romper la mantenibilidad del código al depender de supuestos específicos sobre la disposición en memoria de los objetos. 
 
6. ¿Qué implicaciones tiene este experimento sobre la confianza en las barreras de encapsulamiento que proporciona C++? 

 Muestra que el encapsulamiento en C++ no es una barrera absoluta en tiempo de ejecución, sino una convención reforzada por el compilador. En términos prácticos, es suficiente para desarrollo seguro, pero un programador malicioso o con acceso bajo nivel puede romperlo. Por eso, la seguridad real depende de buenas prácticas y no únicamente del compilador. 

Una vez comprendido cómo el encapsulamiento opera a nivel de compilador, procedemos a investigar otro pilar de la POO: la herencia. Mientras el encapsulamiento se enfoca en ocultar datos, la herencia establece relaciones entre clases que impactan directamente en la organización de la memoria. 

# Herencia y la Relación en Memoria 

**Pregunta: ¿Cómo se organiza en memoria un objeto de una clase derivada en C++? ¿Cómo se almacenan los atributos de la clase base y de la derivada?** 

**Respuesta:** 

 En C++, los atributos de la clase base se almacenan primero en la memoria del objeto derivado, seguidos de los atributos propios de la clase derivada. Esto significa que el layout de memoria es contiguo: los datos de la base ocupan el primer bloque de memoria y los datos de la derivada se ubican después. 

   - Si se añaden más niveles de herencia, cada clase base aporta su bloque de atributos en orden jerárquico, de arriba hacia abajo en la cadena de herencia.


  - Este orden facilita que un puntero o referencia a la clase base pueda “apuntar” al inicio del objeto derivado sin necesidad de reacomodar la memoria.

**Pregunta: ¿Cómo funciona el polimorfismo en C++ a nivel interno? Explica cómo se utilizan las vtables para resolver métodos virtuales en una jerarquía de herencia.** 

**Respuesta:**
 Cuando una clase declara al menos un método virtual, el compilador genera una tabla de métodos virtuales (vtable). Esta tabla contiene punteros a las implementaciones de los métodos virtuales disponibles para esa clase. 

  - Cada objeto de esa clase (o derivada) incluye un puntero oculto llamado vptr que apunta a la vtable correspondiente.

  - En tiempo de ejecución, cuando se invoca un método virtual a través de un puntero o referencia a la clase base, el programa consulta el vptr del objeto real, busca la dirección del método en la vtable y salta a la implementación correcta (por ejemplo, Dog::makeSound o Cat::makeSound). 

Impacto en rendimiento: 

  - La llamada a un método virtual cuesta un paso adicional de indirección (consulta en la tabla) en comparación con una llamada estática.

- Sin embargo, el impacto en la práctica suele ser mínimo y se considera un costo aceptable para habilitar el polimorfismo dinámico. 

**Reflexión Individual** 

**1. ¿Cómo se implementan internamente el encapsulamiento, la herencia y el polimorfismo?**

- El encapsulamiento se implementa mediante reglas del compilador que restringen el acceso, aunque los miembros privados siguen existiendo físicamente en la memoria del objeto.

- La herencia se implementa extendiendo el layout de memoria: primero los datos de la base, luego los de la derivada, manteniendo compatibilidad con punteros a la base. 

- El polimorfismo se implementa con vtables y punteros vptr ocultos en los objetos, lo que permite resolver llamadas dinámicas en tiempo de ejecución. 

2. Ventajas: 

- Encapsulamiento: protege la integridad de los objetos y mejora la mantenibilidad.
- Herencia: permite la reutilización de código y la extensión de clases sin duplicación.
- Polimorfismo: habilita interfaces genéricas y código flexible que funciona con múltiples tipos derivados. 

3. Desventajas: 

  - Encapsulamiento puede romperse con técnicas de bajo nivel (no es seguridad absoluta).
  - Herencia puede aumentar el acoplamiento entre clases y volver más complejo el diseño.
  - Polimorfismo introduce un pequeño costo en tiempo de ejecución y mayor complejidad en la disposición interna (vptr, vtables).
  
Para validar empíricamente los conceptos teóricos analizados, realizaremos tres experimentos que demuestran la implementación interna del encapsulamiento, herencia y polimorfismo en C++. 

## Experimentos Sesión 3

**Experimento 1: Violación del Encapsulamiento**

**¿Cómo implementa el compilador el encapsulamiento en C++? Si los miembros privados aún ocupan espacio en el objeto, ¿Qué impide que se acceda a ellos desde fuera de la clase?**

Este experimento consiste en demostrar que el encapsulamiento en C++ es una barrera a nivel de compilador, no una restricción física en memoria. Utilizando reinterpret_cast y aritmética de punteros, accederé directamente a los miembros privados de una clase desde fuera de ella, evitando las restricciones del compilador. Espero demostrar que aunque el compilador normalmente genera errores al intentar acceder a miembros privados, a nivel de memoria estos datos están igualmente accesibles y pueden ser leídos y modificados mediante operaciones de bajo nivel, revelando que la protección del encapsulamiento es lógica más que física. 

**Código Utilizado:** 

```
#include <iostream>
using namespace std;

class Cajasecreta {
private:
    int secreto1;
    float secreto2;
    char secreto3;

public:
    MyClass(int s1, float s2, char s3) : secret1(s1), secret2(s2), secret3(s3) {}

    void printMembers() const {
        cout << "=== Acceso LEGÍTIMO ===" << endl;
        cout << "secret1: " << secret1 << endl;
        cout << "secret2: " << secret2 << endl;
        cout << "secret3: " << secret3 << endl;
        cout << "======================" << endl;
    }
};

int main() {
    MyClass obj(42, 3.14f, 'A');
    
    // 1. Mostrar acceso legítimo
    obj.printMembers();
    
    // 2. Intentar acceso directo (debe fallar en compilación)
    // cout << obj.secret1 << endl; // DESCOMENTAR PARA VER ERROR
    
    // 3. "Hackear" el encapsulamiento
    cout << "=== Acceso ILEGÍTIMO (hackeando) ===" << endl;
    
    // Usando reinterpret_cast para acceder a memoria
    int* ptrInt = reinterpret_cast<int*>(&obj);
    cout << "secret1 robado: " << *ptrInt << endl;
    
    // Para float, necesitamos avanzar el puntero
    // En la mayoría de sistemas: int = 4 bytes, float = 4 bytes
    float* ptrFloat = reinterpret_cast<float*>(ptrInt + 1);
    cout << "secret2 robado: " << *ptrFloat << endl;
    
    // Para char, avanzamos más
    char* ptrChar = reinterpret_cast<char*>(ptrFloat + 1);
    cout << "secret3 robado: " << *ptrChar << endl;
    
    // 4. Modificar valores privados
    cout << "\n=== Modificando valores privados ===" << endl;
    *ptrInt = 100;
    *ptrFloat = 99.99f;
    *ptrChar = 'Z';
    
    // Verificar cambios
    obj.printMembers();
    
    return 0;
} 

```
**Resultado obtenido de la consola: 

=== ACCESO LEGITIMO ===
secreto1: 42
secreto2: 3.14
secreto3: X
======================**

Ahora agregamos reemplazamos esto a int main()

```
int main() {
    CajaSecreta caja(42, 3.14f, 'X');
    
    // 1. Acceso normal (legal)
    caja.mostrarSecretos();
    
    // 2. Intentar acceso directo (debe fallar) - NUEVAS LÍNEAS
    cout << "Intentando acceso directo a secreto1..." << endl;
    cout << caja.secreto1 << endl; // ESTA LÍNEA DEBE DAR ERROR
    
    return 0;
}
```

















