### Actividad 1:

En esta actividad vas a experimentar con una aplicación interactiva y listas enlazadas El siguiente código código además incluye la gestión de memoria.

**1. Entender la aplicación**

ChatGPT me explicó:
El programa crea una serpiente usando una lista enlazada. Cada nodo de la lista guarda sus coordenadas (x, y) y un puntero al siguiente nodo (next). La clase LinkedList controla el head (primer nodo), el tail (último nodo) y el tamaño.

En setup(), se agregan 10 nodos en la misma posición inicial (el centro de la pantalla). En cada update(), el primer nodo recibe la posición actual del mouse. Luego, el algoritmo recorre la lista: cada nodo guarda temporalmente su posición y adopta la del nodo anterior. Así se genera un efecto de seguimiento: la cabeza sigue al mouse y el resto del cuerpo sigue el rastro.

En draw(), la lista se recorre desde el head y se dibuja cada nodo como un círculo rojo. Además, hay un método keyPressed() que escucha si presionamos la tecla c. Si se presiona, se llama a clear(), que destruye todos los nodos, liberando la memoria y dejando la serpiente vacía.

Y con eso lo que yo entendí es que el programa no es solo un dibujo de círculos como anteriores programas, sino un ejercicio de cómo se puede usar una lista enlazada para representar elementos en movimiento. Cada nodo depende del anterior, y eso es lo que crea la ilusión de que la serpiente tiene un cuerpo. También noté que todo está hecho de manera que la memoria se gestione bien, porque al final de la vida del programa no deberían quedar nodos sin liberar.

**2. Evaluaciones formativas**

ChatGPT me propuso preguntas:

1. ¿Qué ocurriría si la lista solo tuviera un nodo?

2. ¿Qué pasa si nunca se llama a clear() ni al destructor?

3. ¿Por qué es importante actualizar el puntero tail cuando agregamos un nodo nuevo?

4. ¿Cómo afecta el método update() a la posición de cada nodo en la lista?

Mis respuestas:

1. Si hay un solo nodo, la serpiente no tendría cuerpo: solo un círculo que sigue al mouse. Es el caso base de la lista.

2. Si nunca se llama a clear() ni al destructor, cada nodo que se creó con new seguiría ocupando memoria en el heap. Esto genera una fuga de memoria, porque el programa termina sin devolver esos espacios al sistema operativo.

3. Actualizar tail es crucial: si no lo hacemos, el último nodo no apunta al nuevo, y ese nodo se quedaría “desconectado” de la lista. Perderíamos acceso a él y sería prácticamente una fuga porque ya no tendríamos cómo liberarlo después.

4. El update() funciona como una cadena: la cabeza se mueve a la posición del mouse, y cada nodo siguiente adopta la posición que tenía el nodo anterior. Esto es lo que causa que la serpiente se vea como un cuerpo que sigue en orden.

**3. ¿Qué es una lista enlazada y en qué se diferencia de un arreglo en cuanto a la forma en que los elementos están almacenados en la memoria?**

Una lista enlazada es una estructura dinámica donde cada elemento (nodo) contiene los datos y un puntero al siguiente. Esto significa que los nodos pueden estar dispersos en la memoria, y lo que los mantiene unidos son los punteros.

En un arreglo, los elementos están en posiciones contiguas de memoria. Eso hace que sea muy rápido acceder a un elemento usando un índice, pero también significa que el tamaño del arreglo es fijo (o muy costoso de cambiar).

La diferencia clave está en:

Arreglo: acceso directo (O(1)) pero inserciones y eliminaciones costosas (O(n)) si no es al final.

Lista enlazada: inserciones y eliminaciones eficientes en cualquier parte (O(1) si ya tienes el puntero al nodo), pero el acceso es más lento porque hay que recorrer desde la cabeza (O(n)).

En este programa se nota la ventaja de la lista enlazada: se pueden agregar nodos al final sin necesidad de mover otros elementos.

**4. Al observar el código de una lista enlazada en C++, ¿Cómo crees que se vinculan los nodos entre sí? ¿Qué estructura se utiliza para lograr esta conexión?**

Los nodos se conectan gracias a la variable Node* next. Cada vez que se crea un nodo con addNode(), el tail actual apunta al nuevo nodo a través de tail->next = newNode. Después, tail se actualiza para que apunte al último nodo de la lista.

Si el nodo es el primero de todos (cuando la lista está vacía), tanto head como tail apuntan a él. Si no, simplemente se encadena al final.

Mi reflexión:
Me gustó ver cómo el código usa next. Es literalmente como si fueran eslabones de una cadena: cada nodo sabe quién sigue, y así se puede recorrer toda la lista.

**5. ¿Cómo se gestiona la memoria en una lista enlazada? Investiga cómo se crea y se destruye un nodo en memoria utilizando el operador new y delete en C++.**

En C++, cuando se hace new Node(x, y), se reserva espacio en el heap. Ese nodo queda ahí hasta que se libere con delete. A diferencia de las variables locales, que se eliminan automáticamente al salir del scope, aquí el programador tiene la responsabilidad de liberar manualmente la memoria.

Por eso, en este código, el destructor de LinkedList llama a clear(), que recorre todos los nodos y los elimina con delete. Esa es la manera correcta de evitar fugas.

Antes pensaba que C++ lo hacía solo, pero ahora entiendo que si no llamo a delete, la memoria queda “huérfana”. Eso es lo que significa una fuga de memoria.

**6. Considerando la estructura de una lista enlazada, ¿qué ventajas ofrece en comparación con un arreglo cuando se trata de insertar o eliminar elementos en posiciones intermedias?**

En una lista enlazada, si ya tengo la referencia del nodo donde quiero insertar o borrar, solo cambio los punteros → es muy rápido.
En un arreglo, tendría que mover todos los elementos que están después → eso cuesta mucho más tiempo (O(n)).

**7. En el código presentado, ¿Cómo se asegura que no haya fugas de memoria? ¿Qué papel juega el destructor en la clase LinkedList?**

La clase LinkedList tiene un destructor (~LinkedList) que llama a clear(). Esa función libera todos los nodos uno por uno.
Eso significa que cuando el objeto snake desaparece al final del programa, automáticamente borra su memoria.
El destructor es clave porque evita que se queden nodos en el heap ocupando espacio de forma inútil.

**8. ¿Qué sucede en la memoria cuando se invoca el método clear() en una lista enlazada? Explica paso a paso cómo se liberan los recursos.**

Node* current = head; (apuntador al primer nodo).

Mientras current != nullptr:

Node* nextNode = current->next; — guardamos el next para no perder la referencia.

delete current; — invocamos destructor Node::~Node() y liberamos la memoria heap del nodo.

current = nextNode; — avanzamos.

Tras terminar el bucle, head = nullptr; tail = nullptr; size = 0;.
Resultado: todas las celdas de memoria ocupadas por los Node quedan liberadas; cualquier puntero externo a esos nodos quedará colgado (dangling) y no debe usarse.

Cuando se llama a clear(), la lista va borrando nodo por nodo. Primero toma la cabeza (head), la guarda en un puntero temporal, y luego pasa al siguiente (next). En cada paso hace un delete al nodo actual, liberando esa memoria en el heap. Esto se repite hasta que no queda ninguno. Al final, tanto head como tail quedan en nullptr y el tamaño (size) en cero. En otras palabras, la lista queda “limpia” y la memoria usada ya no está ocupando espacio.

**9. Explica cómo cambia la estructura en memoria de una lista enlazada al agregar un nuevo nodo al final de la lista. ¿Cómo afecta esto al rendimiento de la lista enlazada?**

Cuando se mete un nuevo nodo, se crea en el heap con new. El puntero next del nodo que antes era la cola (tail) se conecta a este nuevo nodo, y luego ese nodo pasa a ser la nueva cola.
En memoria, la lista ahora tiene un nodo más enlazado al final. En cuanto a rendimiento, agregar al final es rápido porque tenemos un puntero tail: no necesitamos recorrer toda la lista, solo enlazar y actualizar la cola.

**10. Analiza una situación en la que utilizar una lista enlazada sería más ventajoso que utilizar un arreglo. Justifica tu respuesta considerando la gestión de memoria y las operaciones de inserción y eliminación.**

Si tengo una aplicación donde necesito insertar y borrar elementos en muchas posiciones intermedias, una lista enlazada es mejor. Por ejemplo, en un juego de snake como este donde pueda agregar mas puntos en el cuerpo, llegaria un momento en el cual hay tantos puntos que simplemente no es sostenible moverlos a todos al mismo tiempo. En ese caso usaría una lista y no tendría que mover un montón de datos como en un arreglo. Solo cambio punteros y ya. En cambio, si lo que quiero es acceder rápido a la posición exacta de un elemento (tipo índice 50), el arreglo es mejor. 

**11. Después de estudiar el manejo de memoria en listas enlazadas, ¿Cómo aplicarías este conocimiento para diseñar una estructura de datos personalizada para una aplicación creativa? ¿Qué aspectos considerarías para asegurar la eficiencia y evitar fugas de memoria?**

Si quisiera hacer mi propia estructura de datos para, un proyecto de arte generativo por ejemplo. Usaría nodos que tengan color, velocidad, distintas formas según muchas variables inpensadas, etc. Lo clave sería:

Usar new solo cuando necesito un nodo.

Asegurarme de que en el destructor o en una función clear() siempre libere los nodos.

No dejar punteros colgando (usar nullptr).
Así evitaría fugas de memoria y el programa sería más estable.

**12. Reflexiona sobre las diferencias en la gestión de memoria entre C++ y un lenguaje con recolección de basura automática como C#. ¿Qué ventajas y desafíos encuentras en la gestión explícita de memoria en C++ al trabajar con estructuras de datos?**

En C++ yo tengo que liberar todo manualmente con delete. En C# existe un recolector de basura (garbage collector) que lo hace solo cuando ya no hay referencias al objeto. La ventaja en C++ es que yo tengo control total sobre cuándo y cómo se libera la memoria, lo que puede hacer el programa más eficiente. El reto es que, si me olvido de borrar algo, genero fugas. En C#, eso es más fácil de manejar, pero también pierdo un poco de control.

**13. Imagina que estás optimizando una pieza de arte generativo que usa listas enlazadas para representar elementos en movimiento. ¿Qué consideraciones tomarías en cuenta para garantizar que la gestión de la memoria sea eficiente y que no ocurran fugas de memoria?**

Si usara listas enlazadas para objetos en movimiento (por ejemplo, partículas), tendría en cuenta:

Borrar siempre los nodos que ya no se usan (cuando una partícula muere).

Evitar crear demasiados nodos por segundo, porque el new y delete continuos pueden volver lento el programa.

Posiblemente reciclar nodos en vez de borrarlos (reusarlos con nuevos valores).
De esa forma la memoria se mantiene bajo control y no hay fugas.

**14. Pruebas: pregunta a ChatGPT cómo podrías probar las partes del programa y el programa completo. Luego realiza las pruebas y verifica si los resultados coinciden con tus expectativas.**

Para probar:

Prueba básica: correr el programa y mover el mouse → la serpiente debería seguir la posición.

Prueba de clear(): presionar la tecla c y verificar que la serpiente desaparece. Después mover el mouse, no debería dibujar nada.

Prueba de agregar nodos: modificar setup() para crear más o menos nodos y revisar que todos se dibujen.

Prueba de memoria: con el depurador, ver que al llamar clear() no quedan nodos en memoria.

Con esas pruebas confirmo que cada parte funciona como se espera y que no hay fugas.

### Actividad 2

En esta actividad vas a experimentar con pilas y colas en un contexto de arte generativo. El código incluye la gestión de memoria.

El código para la pila es este:

ofApp.h:

```
#pragma once

#include "ofMain.h"

class Node {
public:
    ofVec2f position;
    Node* next;

    Node(float x, float y) {
        position.set(x, y);
        next = nullptr;
    }
};

class Stack {
public:
    Node* top;

    Stack() {
        top = nullptr;
    }

    ~Stack() {
        clear();
    }

    void push(float x, float y) {
        Node* newNode = new Node(x, y);
        newNode->next = top;
        top = newNode;
    }

    void pop() {
        if (top != nullptr) {
            Node* temp = top;
            top = top->next;
            delete temp;  // Liberar memoria del nodo eliminado
        }
    }

    void clear() {
        while (top != nullptr) {
            pop();
        }
    }

    void display() {
        Node* current = top;
        while (current != nullptr) {
            ofDrawCircle(current->position.x, current->position.y, 20);
            current = current->next;
        }
    }
};

class ofApp : public ofBaseApp {

public:
    Stack circleStack;

    void setup();
    void update();
    void draw();
    void keyPressed(int key);
};
```
ofApp.cpp:
```
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofSetBackgroundColor(220);
}

//--------------------------------------------------------------
void ofApp::update() {

}

//--------------------------------------------------------------
void ofApp::draw() {
    // Dibujar todos los círculos en la pila
    circleStack.display();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    if (key == 'a') { // Apilar un nuevo círculo
        circleStack.push(ofGetMouseX(), ofGetMouseY());
    }
    else if (key == 'd') { // Desapilar el último círculo
        circleStack.pop();
    }
}
```
El código para la cola es este:

ofApp.h:
```
#pragma once

#include "ofMain.h"

class Node {
public:
    ofVec2f position;
    Node* next;

    Node(float x, float y) {
        position.set(x, y);
        next = nullptr;
    }
};

class Queue {
public:
    Node* front;
    Node* rear;

    Queue() {
        front = rear = nullptr;
    }

    ~Queue() {
        clear();
    }

    void enqueue(float x, float y) {
        Node* newNode = new Node(x, y);
        if (rear == nullptr) {
            front = rear = newNode;
        }
        else {
            rear->next = newNode;
            rear = newNode;
        }
    }

    void dequeue() {
        if (front != nullptr) {
            Node* temp = front;
            front = front->next;
            if (front == nullptr) {
                rear = nullptr;
            }
            delete temp;  // Liberar memoria del nodo eliminado
        }
    }

    void clear() {
        while (front != nullptr) {
            dequeue();
        }
    }

    void display() {
        Node* current = front;
        while (current != nullptr) {
            ofDrawCircle(current->position.x, current->position.y, 20);
            current = current->next;
        }
    }
};

class ofApp : public ofBaseApp {

public:
    Queue circleQueue;

    void setup();
    void update();
    void draw();
    void keyPressed(int key);
};
```
ofApp.cpp:
```
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofSetBackgroundColor(220);
}

//--------------------------------------------------------------
void ofApp::update() {

}

//--------------------------------------------------------------
void ofApp::draw() {
    // Dibujar todos los círculos en la cola
    circleQueue.display();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    if (key == 'a') { // Encolar un nuevo círculo
        circleQueue.enqueue(ofGetMouseX(), ofGetMouseY());
    }
    else if (key == 'd') { // Desencolar el primer círculo
        circleQueue.dequeue();
    }
}
```

1. **Entendiendo la aplicación**: comienza explorando detenidamente cómo funciona el programa. Usa un un modelo del lenguaje como ChatGPT y el depurador para que verifiques las explicaciones que te propone ChatGPT. Puedes escribir el prompt: quiere entender de manera muy detallada el siguiente programa escrito en C++ y el openframeworks. Luego le das el código. Ve preguntando lo que no entiendas. recuerda ir usando al mismo tiempo el depurador de visual studio.
2. **Realiza evaluaciones formativas**. Dile a ChatGPT que te genere preguntas para verificar si entiendes cómo funciona el programa. Trata de verificar tus hipótesis usando el depurador y luego con las conclusiones del experimento responde la pregunta de ChatGPT. Continúa con este proceso hasta que estés seguro de que entiendes cómo funciona el programa.

R/ Para asegurarte de que entiendes el programa, podrías responder preguntas como estas:

- ¿Qué pasa si llamo a pop() o dequeue() cuando la pila o la cola está vacía?
- ¿Cómo cambia el valor de top en la pila después de varias operaciones seguidas de push y pop?
- ¿Qué diferencia visual ves en pantalla al usar pila versus cola?
- Si metes 5 elementos y luego haces 3 eliminaciones, ¿cuáles deberían quedar y en qué orden?
- La idea es que corras el programa, hagas esas operaciones y confirmes tus hipótesis usando el depurador (ver cómo cambian los punteros y la memoria).

3. **Pruebas:** pregunta a ChatGPT cómo podrías probar las partes del programa y el programa completo. Luego realiza las pruebas y verifica si los resultados coinciden con tus expectativas.

R/ Esto me respondió ChatGPT: Unas pruebas útiles para este programa serían:

- Agregar y quitar elementos en diferentes órdenes: verificar que la pila se comporte como LIFO y la cola como FIFO.
- Prueba de vaciado: llenar con varios elementos y luego vaciar completamente. Revisar en el depurador que todos los nodos se borren y que top, front y rear queden en nullptr.
- Prueba de límites: encolar/apilar muchísimos elementos (20, 50, más) para comprobar que el programa no se crashea y que el dibujo se actualiza correctamente.
- Prueba de vacíos repetidos: llamar varias veces a pop() o dequeue() cuando ya está vacío, y confirmar que el programa no intenta acceder a memoria inválida.
- Prueba de destructor: cerrar el programa con nodos todavía en la pila o cola, y revisar que el destructor (con clear()) libere todos los nodos pendientes.

Preguntas de reflexión para el stack:

1. ¿Cómo se gestiona la memoria en una implementación manual de un stack en C++? Reflexiona sobre cómo el uso de new y delete en la creación y destrucción de nodos afecta el rendimiento y la seguridad de tu programa.

R/ En este caso la memoria se gestiona con new y delete. Cada vez que hago un push, creo un nodo en memoria dinámica (new Node) y lo enlazo al tope de la pila. Cuando hago pop, libero ese nodo con delete. O sea, yo mismo soy el responsable de pedir y devolver memoria. Esto da bastante control, pero también significa que si se me olvida liberar algo, se me puede quedar “pegada” la memoria. En programas grandes o que corren mucho tiempo, eso puede afectar rendimiento y hasta tumbar la aplicación.

2. ¿Por qué es importante liberar la memoria cuando se desapila un nodo en un stack? Considera las consecuencias de no liberar memoria en términos de fugas de memoria y cómo esto puede impactar aplicaciones de largo tiempo de ejecución.

R/ Porque si no libero, se produce una fuga de memoria. Eso quiere decir que el nodo se elimina de la pila (ya no tengo cómo acceder a él), pero sigue ocupando memoria. Si el programa crea y borra nodos muchas veces, esas fugas se acumulan y el consumo de memoria crece sin parar. En un programa que dure poco puede no notarse, pero en aplicaciones de largo plazo (como un videojuego, un servidor, o algo interactivo de arte generativo) se vuelve un problema serio.

3. ¿Qué diferencias existen entre usar un stack de la STL (std::stack) y crear un stack manualmente? Explora cómo la abstracción que proporciona la STL puede simplificar la implementación, pero también cómo una implementación manual ofrece mayor control sobre la gestión de recursos.

R/ Con std::stack no tengo que preocuparme de la gestión de memoria ni de implementar nodos, porque la STL ya lo maneja. Eso simplifica mucho el código y evita errores. Pero al hacerlo manualmente, como en este ejemplo, tengo más control: yo decido cómo se conectan los nodos, cómo se liberan, e incluso puedo personalizar el comportamiento (ej. dibujar en pantalla cada nodo). En resumen, STL = práctico y seguro, manual = control total pero más trabajo y riesgo. 

4. ¿Cómo afecta la estructura de un stack al orden de acceso y eliminación de elementos? Analiza cómo la naturaleza LIFO (Last In, First Out) del stack influye en los tipos de problemas que esta estructura de datos puede resolver eficientemente.

R/ Un stack funciona con LIFO (Last In, First Out). Eso significa que el último elemento que meto (push) es el primero que saco (pop). Entonces no puedo acceder a cualquier elemento libremente, solo al de arriba. Eso lo hace útil para problemas como deshacer acciones (undo), análisis de expresiones matemáticas, o manejo de llamados de funciones en un programa (call stack). El orden LIFO es justo lo que resuelve esas situaciones de manera natural.

5. ¿Cómo podrías modificar el stack para almacenar tipos de datos más complejos (e.g., objetos con múltiples atributos) sin causar problemas de memoria? Reflexiona sobre cómo gestionar adecuadamente la memoria para objetos más complejos y cómo esto afectaría tu implementación actual.

R/ Podría cambiar la clase Node para que guarde un objeto más complejo, por ejemplo una clase con varios atributos (color, velocidad, tamaño, etc.). Para evitar problemas de memoria tendría que pensar en si ese objeto necesita memoria dinámica propia. Si fuera así, en el destructor de Node tendría que liberar también esa memoria. Otra opción más segura es usar smart pointers (std::unique_ptr o std::shared_ptr) para que el propio C++ maneje la liberación. En este ejercicio no hace falta tanto, pero en un proyecto real sí sería recomendable.

Preguntas de autoevaluación:

1. ¿Puedo explicar detalladamente cómo funciona el proceso de apilar y desapilar nodos en un stack, incluyendo la gestión de memoria?

R/ Sí. Cuando hago un push, lo que pasa es que creo un nodo nuevo en memoria dinámica con new. Ese nodo guarda la posición del mouse y apunta al nodo que estaba en el tope antes. Después, el tope de la pila cambia a ese nuevo nodo. En cambio, al hacer pop, tomo el nodo que está arriba, lo guardo en un temporal, muevo el tope al siguiente nodo y libero la memoria del temporal con delete. Esa es la clave: crear con new y soltar con delete cada vez que entra o sale un nodo.
 
2. ¿Soy capaz de identificar y corregir una fuga de memoria en una implementación de stack manual?

R/ Creo que sí. Una fuga se da si elimino la referencia a un nodo sin liberar su memoria. Por ejemplo, si en pop quitara el nodo del tope pero no le hiciera delete, ese espacio quedaría perdido. Para corregirlo, basta con liberar justo después de mover el puntero. Otra forma de comprobarlo es correr el programa con varias operaciones y mirar en el depurador si los nodos realmente se destruyen.

3. ¿Puedo modificar el stack para que incluya una función que busque un elemento específico, sin alterar el orden de los elementos apilados?

R/ Sí, se podría. La idea sería recorrer los nodos con un puntero auxiliar, igual que en display(), pero en lugar de dibujar, ir comparando hasta encontrar el valor buscado. Importante: no tocar el puntero top, porque eso sí cambiaría el stack. Solo usar un nodo temporal para avanzar. 

4. ¿Entiendo cómo la estructura LIFO del stack afecta el flujo de datos y puedo dar ejemplos de problemas que se resuelvan mejor con un stack?

R/ Claro. Como todo funciona con “último en entrar, primero en salir”, el stack sirve cuando necesito deshacer cosas en orden inverso, como en un editor de texto (el undo). Otro ejemplo es la evaluación de expresiones matemáticas: las operaciones que entran al final son las que se resuelven primero. También los llamados de funciones en un programa se manejan con un stack (el call stack).

5. ¿Puedo implementar y depurar un stack para tipos de datos más complejos, asegurándome de que no haya fugas de memoria ni errores de puntero?

R/ Podría hacerlo, pero tendría que tener más cuidado. Si el Node guarda un objeto que usa memoria dinámica (ej. un array dentro), tendría que liberar esa memoria en el destructor del nodo. Para no enredarme, usar smart pointers sería más seguro porque ellos liberan automáticamente. Con eso, evito fugas de memoria y me concentro en la lógica del stack.

Preguntas de reflexión para la queue:

1. ¿Cómo se maneja la memoria en una implementación manual de una queue en C++? Reflexiona sobre cómo se gestionan los nodos al encolar y desencolar elementos y las implicaciones en términos de eficiencia y seguridad.

R/ Cuando se trabaja con una queue manual en C++, la memoria se administra dinámicamente cada vez que se encola un nuevo nodo (con new) y se libera al desencolar (con delete). Esto implica estar muy pendiente de no dejar “huérfanos” los nodos, porque si no libero lo que ya no se usa, se generan fugas de memoria. A nivel de eficiencia, el manejo es bastante directo, pero la seguridad depende totalmente de mi cuidado al gestionar los punteros.

2. ¿Qué desafíos específicos presenta la implementación de una queue en comparación con un stack en términos de gestión de memoria? Considera las diferencias en el manejo de punteros front y rear, y cómo estos afectan el proceso de encolado y desencolado.

R/ Una diferencia clave con respecto al stack es que la queue necesita manejar dos punteros: front y rear. Eso lo hace más propenso a errores, porque no solo debo preocuparme por la cabeza, sino también por la cola. En el stack, siempre opero sobre el tope, mientras que en la queue tengo que actualizar dos extremos al mismo tiempo. Este doble control puede generar problemas si no lo hago con cuidado, como perder acceso a elementos o dejar referencias colgando.

3. ¿Cómo afecta la estructura FIFO (First In, First Out) de una queue a su uso en diferentes tipos de problemas? Analiza cómo la estructura FIFO influye en la resolución de problemas donde el orden de procesamiento es crucial, como en sistemas de colas de espera.

R/ La estructura FIFO influye directamente en cómo se usan las colas. Por ejemplo, en sistemas de espera, en simulaciones de procesos o incluso en buffers de comunicación, es crucial que el primero en llegar sea el primero en salir. Justamente esa propiedad garantiza que el orden de procesamiento sea justo y predecible. En comparación con un stack, aquí no puedo “priorizar” al último en entrar, sino que debo respetar la secuencia.

4. ¿Cómo podrías implementar una queue circular y cuál sería su ventaja respecto a una queue lineal en términos de uso de memoria? Reflexiona sobre cómo una queue circular puede mejorar la eficiencia en ciertos contextos y qué cambios serían necesarios en la implementación.

R/ Una queue circular se implementa cuando quiero reutilizar los espacios ya liberados, en lugar de que la cola crezca de manera lineal sin control. Su ventaja principal es el aprovechamiento de memoria, ya que al llegar al final del arreglo puedo volver a usar las posiciones iniciales. Para implementarla, necesito usar operaciones de módulo (%) al mover los índices de front y rear, de forma que cuando lleguen al final, se reinicien automáticamente.

5. ¿Qué problemas podrían surgir si no se gestionan correctamente los punteros front y rear en una queue, y cómo podrías evitarlos? Considera posibles errores como la pérdida de referencias a nodos y cómo una gestión cuidadosa de los punteros puede prevenir estos problemas.

R/ Si no manejo bien los punteros front y rear, puedo tener varios problemas: desde perder la referencia a nodos (lo que crea fugas de memoria), hasta acceder a memoria inválida o incluso romper la lógica de la cola (por ejemplo, que front apunte a nada aunque la cola tenga elementos). La forma de evitar esto es ser riguroso: actualizar siempre ambos punteros en las operaciones de encolar/desencolar y validar constantemente los casos límite, como cuando la cola está vacía o llena. 

Preguntas de autoevaluación:

1. ¿Puedo explicar claramente el proceso de encolar y desencolar nodos en una queue, incluyendo la gestión de memoria?

R/ Sí, tengo claro que al encolar creo un nodo dinámico con new, lo enlazo al final y actualizo el puntero rear. Al desencolar, libero la memoria del nodo que está en el front con delete y muevo ese puntero al siguiente nodo. La clave es nunca perder la referencia antes de liberar, porque ahí es cuando aparecen fugas de memoria.

2. ¿Soy capaz de identificar y corregir problemas relacionados con la gestión de los punteros front y rear en una queue?

R/ Me siento capaz de detectar problemas con front y rear, porque son los puntos más delicados en la implementación. Por ejemplo, si rear no se actualiza bien al encolar, podría quedar apuntando a un nodo viejo. Y si front se pierde, no hay forma de acceder a la cola. Lo importante es revisar bien los casos extremos (cola vacía y cola con un solo elemento), porque ahí suelen aparecer los errores.

3. ¿Puedo modificar la queue para implementar una queue circular, entendiendo cómo esto afectaría la gestión de memoria?

R/ Podría transformar la queue en circular modificando la forma en que se actualizan los punteros: en lugar de crecer indefinidamente, uso módulo (%) para que vuelvan al inicio del arreglo. Esto mejora el uso de memoria porque no necesito estar reservando más espacio o dejando posiciones vacías que ya se podrían reutilizar.

4. ¿Entiendo cómo la estructura FIFO de una queue afecta el flujo de datos y puedo dar ejemplos de problemas que se resuelvan mejor con una queue?

R/ La estructura FIFO define que el primero en llegar es el primero en salir, y eso cambia el tipo de problemas que resuelve. Por ejemplo, en un sistema de turnos o en un buffer de impresión, es crucial mantener el orden de llegada. Si usara un stack en esos casos, el sistema sería injusto o desordenado, porque el último siempre tendría prioridad.

5. ¿Puedo implementar y depurar una queue para tipos de datos más complejos, asegurándome de que no haya fugas de memoria ni errores de puntero?

R/ Sí puedo implementar y depurar una queue para datos más complejos, siempre que tenga cuidado con la memoria. En esos casos no solo debo liberar el nodo, sino también lo que guarde dentro (si es dinámico). La depuración con casos pequeños (cola vacía, un solo nodo, muchos nodos) es fundamental para comprobar que no haya fugas ni errores de punteros. 

## Reto 

**Código Completo:**

**main.cpp:**

```
#include "ofMain.h"
#include "ofApp.h"

//========================================================================
int main() {
    ofSetupOpenGL(800, 600, OF_WINDOW);
    ofRunApp(new ofApp());
}
```

**ofApp.cpp:** 

```
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofSetWindowTitle("Snake de Letras");
    snake.setup('A'); // letra inicial
}

//--------------------------------------------------------------
void ofApp::update() {
    snake.update(ofGetMouseX(), ofGetMouseY());
}

//--------------------------------------------------------------
void ofApp::draw() {
    // ?? el fondo ahora se pinta aquí, no en snake.draw()
    ofBackground(snake.bgColor);

    snake.draw();

    // Menú visible siempre
    ofSetColor(255);
    ofDrawBitmapStringHighlight(
        "+ Agregar letra (luego escribe una)\n"
        "- Borrar cabeza o letra seleccionada\n"
        "1-9 Seleccionar posición\n"
        "0 Cambiar color de la snake\n"
        "Shift Cambiar fondo\n"
        "Esc Atrás",
        20, 20
    );
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    if (waitingForAdd) {
        if (key == OF_KEY_ESC) {
            waitingForAdd = false;
        }
        else if (isalpha(key)) {
            snake.addLetter((char)toupper(key));
            waitingForAdd = false;
        }
        else {
            ofSystemAlertDialog("Tecla inválida. Usa solo letras.");
        }
        return;
    }

    if (key == '+') {
        waitingForAdd = true;
    }
    else if (key == '-') {
        if (selectedIndex >= 0) {
            snake.removeAt(selectedIndex);
            selectedIndex = -1;
        }
        else {
            snake.removeHead();
        }
    }
    else if (key >= '1' && key <= '9') {
        selectedIndex = key - '1';
        if (selectedIndex >= snake.bodyChars.size()) {
            selectedIndex = -1;
        }
    }
    else if (key == '0') {
        snake.changeColor();
    }
    else if (key == OF_KEY_SHIFT) {
        snake.changeBackground();
    }
    else if (selectedIndex >= 0 && isalpha(key)) {
        snake.replaceLetter(selectedIndex, (char)toupper(key));
        selectedIndex = -1;
    }
}
```

**ofApp.h:** 

```
#pragma once
#include "ofMain.h"
#include "snake.h"

class ofApp : public ofBaseApp {
public:
    void setup();
    void update();
    void draw();

    void keyPressed(int key);

    Snake snake;
    bool waitingForAdd = false;
    int selectedIndex = -1;
};
``` 

**snake.cpp:** 

```
#include "snake.h"
#include <cmath>

Snake::Snake() {
}

Snake::~Snake() {
    clear();
}

void Snake::setup(char initialChar) {
    bodyChars.clear();
    bodyPos.clear();

    char c = (char)toupper(initialChar);
    // crear 5 letras iniciales centradas
    for (int i = 0; i < 5; i++) {
        bodyChars.push_back(c);
        bodyPos.push_back(ofVec2f(ofGetWidth() / 2 - i * 30, ofGetHeight() / 2));
    }

    bodyColor = ofColor::fromHsb(ofRandom(255), 200, 255);
    bgColor = ofColor::fromHsb(ofRandom(255), 120, 255);

    // carga fuente (coloca verdana.ttf en bin/data/)
    font.load("verdana.ttf", 36, true, true, true);
}

void Snake::update(float targetX, float targetY) {
    if (bodyPos.empty()) return;

    // cabeza va al target
    float prevX = bodyPos[0].x;
    float prevY = bodyPos[0].y;
    bodyPos[0].x = targetX;
    bodyPos[0].y = targetY;

    // separación mínima entre letras
    const float minDist = 25.0f;

    for (size_t i = 1; i < bodyPos.size(); ++i) {
        float dx = prevX - bodyPos[i].x;
        float dy = prevY - bodyPos[i].y;
        float dist = sqrtf(dx * dx + dy * dy);
        if (dist > minDist) {
            float ratio = minDist / dist;
            bodyPos[i].x = prevX - dx * ratio;
            bodyPos[i].y = prevY - dy * ratio;
        }
        prevX = bodyPos[i].x;
        prevY = bodyPos[i].y;
    }
}

void Snake::draw() {
    // dibuja fondo y letras con delineado negro
    ofBackground(bgColor);

    for (size_t i = 0; i < bodyChars.size(); ++i) {
        std::string s(1, bodyChars[i]);
        float x = bodyPos[i].x;
        float y = bodyPos[i].y;

        // delineado negro (4 offsets)
        ofSetColor(0);
        font.drawString(s, x - 2, y - 2);
        font.drawString(s, x + 2, y - 2);
        font.drawString(s, x - 2, y + 2);
        font.drawString(s, x + 2, y + 2);

        // letra principal
        ofSetColor(bodyColor);
        font.drawString(s, x, y);
    }
}

void Snake::addLetter(char c) {
    if (!isalpha((unsigned char)c)) return;
    if ((int)bodyChars.size() >= maxLength) return;

    char uc = (char)toupper((unsigned char)c);
    // insertar en cabeza
    if (!bodyChars.empty()) {
        bodyChars.insert(bodyChars.begin(), uc);
        bodyPos.insert(bodyPos.begin(), bodyPos.front());
    }
    else {
        bodyChars.push_back(uc);
        bodyPos.push_back(ofVec2f(ofGetMouseX(), ofGetMouseY()));
    }
}

void Snake::removeHead() {
    if ((int)bodyChars.size() <= minLength) return;
    if (!bodyChars.empty()) {
        bodyChars.erase(bodyChars.begin());
        bodyPos.erase(bodyPos.begin());
    }
}

void Snake::replaceLetter(int index, char c) {
    if (index < 0 || index >= (int)bodyChars.size()) return;
    if (!isalpha((unsigned char)c)) return;
    bodyChars[index] = (char)toupper((unsigned char)c);
}

void Snake::removeAt(int index) {
    if (index < 0 || index >= (int)bodyChars.size()) return;
    if ((int)bodyChars.size() <= minLength) return;
    bodyChars.erase(bodyChars.begin() + index);
    bodyPos.erase(bodyPos.begin() + index);
}

void Snake::changeColor() {
    bodyColor = ofColor::fromHsb(ofRandom(255), 200, 255);
}

void Snake::changeBackground() {
    bgColor = ofColor::fromHsb(ofRandom(255), 120, 255);
}

void Snake::clear() {
    bodyChars.clear();
    bodyPos.clear();
}
```

**snake.h:** 

```
#pragma once
#include "ofMain.h"
#include <vector>

class Snake {
public:
    Snake();
    ~Snake();

    // inicializa con una letra (usa en setup de ofApp)
    void setup(char initialChar);

    // movimiento: cabeza sigue a (targetX,targetY)
    void update(float targetX, float targetY);

    // dibuja (usa font y colores)
    void draw();

    // operaciones requeridas por ofApp.cpp
    void addLetter(char c);            // agrega letra en la cabeza
    void removeHead();
    void replaceLetter(int index, char c);
    void removeAt(int index);

    void changeColor();
    void changeBackground();

    void clear();

    // datos públicos que ofApp.cpp puede leer (bodyChars se usaba en tu código)
    std::vector<char> bodyChars;
    std::vector<ofVec2f> bodyPos;
    ofColor bodyColor;
    ofColor bgColor;
    ofTrueTypeFont font;

    const int maxLength = 9;
    const int minLength = 3;

    int size() const { return (int)bodyChars.size(); }

    // alias para evitar errores por nombres distorsionados
    void addChar(char c) { addLetter(c); }
    void replaceAt(int i, char c) { replaceLetter(i, c); }
    void changeBgColor() { changeBackground(); }
};
```

Pregunta: ¿Qué tipo de efecto visual quieres lograr? ¿Cómo pueden ayudarte las diferentes estructuras de datos a lograr ese efecto? 

R/ El efecto visual que elegí es un snake de letras que sigue el mouse, con interacción para agregar, eliminar o cambiar letras y colores.
- Arreglo/Vector: std::vector<char> y std::vector<ofVec2f> almacenan las letras y posiciones de cada elemento de la snake, permitiendo acceso rápido a cualquier índice y control del tamaño dinámico.
- Pila/Cola implícita: se puede considerar la inserción de letras en la cabeza como una pila (LIFO) y la eliminación de la cabeza como desapilar, para manejar dinámicamente el crecimiento y acortamiento de la snake.
Esto permite controlar el flujo de datos y reproducir efectos dinámicos de manera ordenada. 

Pregunta: ¿Qué consideraciones debes tener en cuenta al gestionar dinámicamente la memoria de los objetos? ¿Cómo asegurar que no haya fugas de memoria? 

R/ - En este proyecto utilicé objetos automáticos (stack) en la mayoría de los casos, pero si hubiera usado new para crear letras u objetos, tendría que haber liberado la memoria con delete.
- La clase Snake tiene un método clear() que borra los vectores y libera los datos asociados, previniendo fugas.
- Hay que considerar limpiar siempre cualquier estructura dinámica al finalizar el programa o al reiniciar elementos (bodyChars.clear(), bodyPos.clear()).

Pregunta: ¿Cómo puedes hacer que la interacción del usuario influya en múltiples estructuras de datos simultáneamente para crear un efecto visual coherente y dinámico? 

R/ Al presionar +, se agrega una letra en la cabeza (bodyChars.insert) y se copia su posición inicial (bodyPos.insert). Esto actualiza dos vectores simultáneamente, manteniendo la coherencia visual.
- Al eliminar o reemplazar letras (- o teclas 1-9), también se modifica ambos vectores, logrando que posición y contenido estén sincronizados.
- Cambios de color (0 para snake y Shift para fondo) afectan los colores de la snake y del entorno, impactando simultáneamente la estética de todos los elementos.

Pregunta: ¿Qué técnicas puedes implementar para optimizar la gestión de memoria y el rendimiento de tu aplicación mientras mantienes una experiencia visual rica y fluida? 

R/ - Evitar recalcular operaciones costosas (como sqrt o conversiones innecesarias) en cada frame.
- Limitar el número máximo de letras (maxLength) para no sobrecargar la memoria.
- Actualizar solo las posiciones necesarias, no todo el vector cada vez.
- Mantener objetos en stack cuando sea posible y usar métodos de limpieza (clear()) para liberar memoria de manera controlada.

EVIDENCIAS RAE 1 Y 2:

Funcionalidades del programa:

Con 'Shift' se cambia el color del fondo, y con '0' se cambia el color del snake.

https://github.com/user-attachments/assets/fbb05d52-dde8-4127-88ba-3d95cfb8e40d

Con '+' y luego cualquier letra (solo letra, si no saldrá un mensaje de tecla inválida.) se agrega una cabeza al snake de la letra presionada.

Con '-' se elimina la primera cabeza que esta en el snake.

Con '1, 2, 3, 4, 5, 6, 7, 8 y 9' seleccionas una cabeza del snake (1 es la cabeza y 9 es la cola) y luego puedes presionar o '-' para eliminar esa cabeza en específico o puedes presionar cualquier letra para reemplazar esa cabeza en específico.


https://github.com/user-attachments/assets/990bc644-b5d6-4818-ac68-aa5c5b214c0e

Estas funciones evidencian que el proyecto cumple con los requisitos del reto de manera clara y concreta. La capacidad de cambiar el color del fondo con `Shift` y el color del snake con `0` demuestra interactividad y control dinámico sobre los elementos visuales, cumpliendo con el requisito de interacción con el usuario. El agregado de letras en la cabeza mediante `+` y la validación de que solo se ingresen caracteres alfabéticos refleja la gestión de datos en estructuras dinámicas (vectores) y asegura la coherencia de la obra generativa. La eliminación de la cabeza con `-` y la posibilidad de seleccionar posiciones específicas con `1–9` para eliminar o reemplazar letras muestran un manejo controlado de la memoria y de las estructuras de datos, además de mantener la sincronización entre posiciones y caracteres. En conjunto, estas funcionalidades permiten que la obra sea dinámica, interactiva y correctamente gestionada en memoria, cumpliendo con los objetivos de combinación de estructuras, interactividad y gestión de memoria establecidos en el reto.

Evidencia Reto: https://youtu.be/7di-fqk6FOs  
