**### Actividad 1:**

En esta actividad vas a experimentar con una aplicación interactiva y listas enlazadas El siguiente código código además incluye la gestión de memoria.

**1. Entender la aplicación**

ChatGPT me explicó:
El programa crea una serpiente usando una lista enlazada. Cada nodo de la lista guarda sus coordenadas (x, y) y un puntero al siguiente nodo (next). La clase LinkedList controla el head (primer nodo), el tail (último nodo) y el tamaño.

En setup(), se agregan 10 nodos en la misma posición inicial (el centro de la pantalla). En cada update(), el primer nodo recibe la posición actual del mouse. Luego, el algoritmo recorre la lista: cada nodo guarda temporalmente su posición y adopta la del nodo anterior. Así se genera un efecto de seguimiento: la cabeza sigue al mouse y el resto del cuerpo sigue el rastro.

En draw(), la lista se recorre desde el head y se dibuja cada nodo como un círculo rojo. Además, hay un método keyPressed() que escucha si presionamos la tecla c. Si se presiona, se llama a clear(), que destruye todos los nodos, liberando la memoria y dejando la serpiente vacía.

Y con eso lo que yo entendí es que el programa no es solo un dibujo de círculos como anteriores programas, sino un ejercicio de cómo se puede usar una lista enlazada para representar elementos en movimiento. Cada nodo depende del anterior, y eso es lo que crea la ilusión de que la serpiente tiene un cuerpo. También noté que todo está hecho de manera que la memoria se gestione bien, porque al final de la vida del programa no deberían quedar nodos sin liberar.

**2. Evaluaciones formativas**

ChatGPT me propuso preguntas:

¿Qué ocurriría si la lista solo tuviera un nodo?

¿Qué pasa si nunca se llama a clear() ni al destructor?

¿Por qué es importante actualizar el puntero tail cuando agregamos un nodo nuevo?

¿Cómo afecta el método update() a la posición de cada nodo en la lista?

Mis respuestas:

Si hay un solo nodo, la serpiente no tendría cuerpo: solo un círculo que sigue al mouse. Es el caso base de la lista.

Si nunca se llama a clear() ni al destructor, cada nodo que se creó con new seguiría ocupando memoria en el heap. Esto genera una fuga de memoria, porque el programa termina sin devolver esos espacios al sistema operativo.

Actualizar tail es crucial: si no lo hacemos, el último nodo no apunta al nuevo, y ese nodo se quedaría “desconectado” de la lista. Perderíamos acceso a él y sería prácticamente una fuga porque ya no tendríamos cómo liberarlo después.

El update() funciona como una cadena: la cabeza se mueve a la posición del mouse, y cada nodo siguiente adopta la posición que tenía el nodo anterior. Esto es lo que causa que la serpiente se vea como un cuerpo que sigue en orden.

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
