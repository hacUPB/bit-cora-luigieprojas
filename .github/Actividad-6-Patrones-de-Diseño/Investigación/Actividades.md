 Ahora te pediré que te tomes un tiempo para analizar el código y entender su funcionamiento.

https://youtu.be/tmblwVIDs-8

- ¿Qué hace el patrón observer en este caso? 

R/ El patrón Observer permite que el ofApp (el Subject) notifique eventos a muchas Particle (los Observers) sin acoplarlos fuertemente.

Subject::addObserver / removeObserver mantiene la lista de observadores.

Subject::notify(event) recorre los observadores y les llama onNotify(event).

Cada Particle implementa onNotify y cambia su State según el evento (por ejemplo "attract", "repel", …).
Resultado: una sola acción (pulsar una tecla que llama notify) cambia el comportamiento simultáneo de todas las partículas. 

- ¿Qué hace el patrón factory en este caso? 

R/ La ParticleFactory::createParticle(type) encapsula la creación y configuración inicial de distintas variantes de partículas (star, shooting_star, planet, etc.).

Evita que el ofApp::setup() conozca detalles de inicialización.

Facilita añadir nuevos tipos de partículas (solo añades una nueva rama en la fábrica). 

- ¿Qué hace el patrón state en este caso? 

R/ Particle mantiene un puntero State* state. Cada State implementa update(Particle*) y opcionales onEnter/onExit.

Cambiando el state (por setState), cambias el comportamiento de la partícula sin condicionales dispersos.

Cada estado es responsable de su lógica (normal, atraer, repeler, stop).
Esto facilita añadir comportamientos nuevos (p. ej. el estado Z de colisiones).

Experimenta con el código y realiza algunas modificaciones para entender mejor su funcionamiento. Por ejemplo:

- Adiciona un nuevo tipo de partícula.
- Adiciona un nuevo estado.
- Modifica el comportamiento de las partículas.
- Crea otros eventos para notificar a las partículas. 

Cambios realizados

Se realizaron modificaciones funcionales y estéticas para extender el proyecto, con el fin de:

Incluir un nuevo tipo de partícula (azul claro, más grande y lenta).

Incorporar un nuevo estado (Z) que simula colisiones entre partículas.

Añadir nuevos eventos que alteran la dinámica del sistema (“explode” y “calm”).

Mejorar la legibilidad, modularidad y estabilidad del código 

Nuevo tipo de partícula: Big Blue Particle

Ubicación: Clase ParticleFactory, método createParticle()

Objetivo:
Agregar una nueva categoría de partícula más grande, de color azul claro, para diversificar el entorno visual y demostrar la facilidad de extensión del patrón Factory Method.

Implementación: 

```
else if (type == "big_blue") {
    particle->size = ofRandom(10, 18);        // Tamaño más grande
    particle->color = ofColor(173, 216, 230); // Azul claro (Light Blue)
    particle->velocity *= 0.6f;               // Movimiento más suave
}
```
Este cambio ejemplifica la extensibilidad del patrón Factory, ya que no fue necesario modificar la lógica de ofApp.

Solo se añadió un nuevo caso en la fábrica, manteniendo la cohesión (creación concentrada en un único lugar) y reduciendo el acoplamiento con el resto del sistema.

La partícula Big Blue aporta contraste visual y una sensación de profundidad por su desplazamiento más lento. 

Impacto visual:
Las partículas azules de gran tamaño se mueven lentamente entre las demás, generando un efecto visual calmado y elegante, que contrasta con el dinamismo de las estrellas fugaces y los planetas. 

Nuevo estado: CollisionState (Estado Z)

Ubicación: Nueva clase CollisionState, derivada de State.

Objetivo:
Implementar un estado adicional que simule colisiones físicas entre partículas, aplicando principios del patrón State, donde cada estado define un comportamiento independiente.

Implementación principal: 
```
class CollisionState : public State {
public:
    void update(Particle* particle) override {
        ofApp* app = (ofApp*)ofGetAppPtr();
        if (!app) return;

        // Movimiento básico
        particle->position += particle->velocity;

        // Comportamiento de colisión simple
        for (Particle* other : app->particles) {
            if (other == particle) continue;
            ofVec2f diff = particle->position - other->position;
            float dist = diff.length();
            float minDist = particle->size + other->size;

            if (dist > 0 && dist < minDist) {
                ofVec2f push = diff.normalized();
                float overlap = minDist - dist;

                // Separar las partículas proporcionalmente
                particle->position += push * (overlap * 0.5f);
                other->position -= push * (overlap * 0.5f);

                // Rebote simple
                ofVec2f relative = particle->velocity - other->velocity;
                float impulse = relative.dot(push);
                if (impulse < 0) {
                    float restitution = 0.8f;
                    ofVec2f change = push * (-impulse * (1 + restitution) * 0.5f);
                    particle->velocity += change;
                    other->velocity -= change;
                }
            }
        }
    }
};
```
El estado CollisionState se activa al recibir el evento "z".

Recorre el vector global de partículas (app->particles) para detectar colisiones simples basadas en distancia mínima.

Aplica una respuesta de rebote elástico simplificado, ajustando posiciones y velocidades para evitar superposición.

Utiliza ofClamp y rebotes en bordes de pantalla para mantener estabilidad.

Propósito del cambio:
Este estado demuestra cómo el patrón State permite extender comportamientos sin alterar la lógica interna de la clase Particle.
Cada nuevo comportamiento (como colisión, atracción o detención) puede añadirse como una nueva subclase, promoviendo abierto a extensión, cerrado a modificación (Principio OCP).

Impacto visual:
Al activar el estado Z (presionando la tecla Z), las partículas comienzan a chocar entre sí, separándose al contacto y generando una dinámica caótica y viva, simulando rebotes suaves.

Nuevos eventos del sistema

Ubicación: Método ofApp::keyPressed() y Particle::onNotify()

Objetivo:
Añadir nuevas formas de interacción entre el usuario y el sistema a través del teclado, manteniendo la lógica de comunicación basada en el patrón Observer.

Eventos añadidos:
```
else if (key == 'z') notify("z");        // Activa el estado de colisiones
else if (key == 'e') notify("explode");  // Aumenta la velocidad de todas
else if (key == 'c') notify("calm");     // Disminuye la velocidad de todas
```
Reacción en las partículas:

```
else if (event == "explode") {
    velocity *= 3.0f;    // Acelera el movimiento
}
else if (event == "calm") {
    velocity *= 0.3f;    // Reduce la velocidad
}
```
Los nuevos eventos se propagan a todas las partículas mediante Subject::notify().

Cada partícula interpreta el evento de forma local a través de su método onNotify().

El patrón Observer permite añadir nuevas interacciones sin alterar las relaciones entre los objetos, cumpliendo con el principio de bajo acoplamiento. 

Impacto visual y funcional:

Z: activa el estado de colisión (rebotes entre partículas).

E: genera un “efecto explosión” al aumentar drásticamente la velocidad.

C: calma el sistema, reduciendo el movimiento casi a un reposo.

Estos eventos hacen la simulación más interactiva y refuerzan la comprensión del patrón Observer aplicado en un entorno visual. 

Tras los cambios:

El sistema cuenta con cuatro tipos de partículas (star, shooting_star, planet y big_blue).

Existen cinco estados de comportamiento (Normal, Attract, Repel, Stop y Collision).

Se implementaron siete eventos (s, a, r, n, z, e, c) que alteran colectivamente el comportamiento global.

Visualmente, la simulación muestra:

Partículas azules grandes que se mueven lentamente.

Comportamientos dinámicos controlados por teclas (atracción, repulsión, choque, calma, explosión).

Interacción fluida y modular, demostrando la integración de los tres patrones de diseño.

## **Reto**

Desarrolla un proyecto de arte generativo interactivo en tiempo real. Diferente, lo más que puedas al caso de estudio.

### Requisitos

- Utilizando **C++** y **openFrameworks**.
- Aplica el patrón de diseño **Observer**.
- Aplica el patrón de diseño **Factory**.
- Aplica el patrón de diseño **State**.
- Realiza pruebas desde el inicio del desarrollo para garantizar el correcto funcionamiento de la aplicación.
