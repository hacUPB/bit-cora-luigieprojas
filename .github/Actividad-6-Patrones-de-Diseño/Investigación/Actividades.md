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

Evidencia Sesión 2 Modificada:

https://youtu.be/LRwS-hc8g-A 

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

Código Completo:

ofApp.h (modificado):

```
#pragma once

#include "ofMain.h"
#include <vector>
#include <string>
#include <algorithm>

// Observers / Subject
class Observer {
public:
    virtual void onNotify(const std::string& event) = 0;
};

class Subject {
public:
    void addObserver(Observer* observer);
    void removeObserver(Observer* observer);
protected:
    void notify(const std::string& event);
private:
    std::vector<Observer*> observers;
};

// Forward
class Particle;

// State base
class State {
public:
    virtual void update(Particle* particle) = 0;
    virtual void onEnter(Particle* particle) {}
    virtual void onExit(Particle* particle) {}
    virtual ~State() = default;
};

// Particle
class Particle : public Observer {
public:
    Particle();
    ~Particle();

    void update();
    void draw();
    void onNotify(const std::string& event) override;
    void setState(State* newState);

    ofVec2f position;
    ofVec2f velocity;
    float size;
    ofColor color;

private:
    State* state;
};

// Estados existentes
class NormalState : public State {
public:
    void update(Particle* particle) override;
    void onEnter(Particle* particle) override;
};

class AttractState : public State {
public:
    void update(Particle* particle) override;
};

class RepelState : public State {
public:
    void update(Particle* particle) override;
};

class StopState : public State {
public:
    void update(Particle* particle) override;
};

// Nuevo estado: colisión (Z)
class CollisionState : public State {
public:
    void update(Particle* particle) override;
};

// Fábrica
class ParticleFactory {
public:
    static Particle* createParticle(const std::string& type);
};

// ofApp
class ofApp : public ofBaseApp, public Subject {
public:
    void setup();
    void update();
    void draw();
    void keyPressed(int key);

    // NOTA: hecho público para que CollisionState pueda acceder a todas las partículas
    std::vector<Particle*> particles;
};
```
ofApp.cpp (modificado): 

```
#include "ofApp.h"

// ---------------- Subject
void Subject::addObserver(Observer* observer) {
    // evitar duplicados simples
    if (std::find(observers.begin(), observers.end(), observer) == observers.end())
        observers.push_back(observer);
}

void Subject::removeObserver(Observer* observer) {
    observers.erase(std::remove(observers.begin(), observers.end(), observer), observers.end());
}

void Subject::notify(const std::string& event) {
    for (Observer* observer : observers) {
        observer->onNotify(event);
    }
}

// ---------------- Particle
Particle::Particle() {
    position = ofVec2f(ofRandomWidth(), ofRandomHeight());
    velocity = ofVec2f(ofRandom(-0.5f, 0.5f), ofRandom(-0.5f, 0.5f));
    size = ofRandom(2, 5);
    color = ofColor(255);
    state = new NormalState();
}

Particle::~Particle() {
    if (state) delete state;
}

void Particle::setState(State* newState) {
    if (state != nullptr) {
        state->onExit(this);
        delete state;
    }
    state = newState;
    if (state != nullptr) {
        state->onEnter(this);
    }
}

void Particle::update() {
    if (state != nullptr) {
        state->update(this);
    }
    // mantener dentro de ventana: invertir velocidad si sale
    if (position.x < 0 || position.x > ofGetWidth()) velocity.x *= -1;
    if (position.y < 0 || position.y > ofGetHeight()) velocity.y *= -1;
}

void Particle::draw() {
    ofSetColor(color);
    ofDrawCircle(position, size);
}

void Particle::onNotify(const std::string& event) {
    if (event == "attract") {
        setState(new AttractState());
    }
    else if (event == "repel") {
        setState(new RepelState());
    }
    else if (event == "stop") {
        setState(new StopState());
    }
    else if (event == "normal") {
        setState(new NormalState());
    }
    else if (event == "z") {
        setState(new CollisionState());
    }
    else if (event == "explode") {
        // Aumentar velocidad actual (simple)
        velocity *= 3.0f;
    }
    else if (event == "calm") {
        // Reducir velocidad
        velocity *= 0.3f;
    }
}

// ---------------- NormalState
void NormalState::update(Particle* particle) {
    particle->position += particle->velocity;
}

void NormalState::onEnter(Particle* particle) {
    particle->velocity = ofVec2f(ofRandom(-0.5f, 0.5f), ofRandom(-0.5f, 0.5f));
}

// ---------------- AttractState
void AttractState::update(Particle* particle) {
    ofVec2f mousePosition(((ofApp*)ofGetAppPtr())->mouseX, ((ofApp*)ofGetAppPtr())->mouseY);
    ofVec2f direction = mousePosition - particle->position;
    if (direction.length() > 0.0001f) direction.normalize();
    particle->velocity += direction * 0.05f;
    // aplicar clamp correctamente
    particle->velocity.x = ofClamp(particle->velocity.x, -3, 3);
    particle->velocity.y = ofClamp(particle->velocity.y, -3, 3);
    particle->position += particle->velocity * 0.2f;
}

// ---------------- RepelState
void RepelState::update(Particle* particle) {
    ofVec2f mousePosition(((ofApp*)ofGetAppPtr())->mouseX, ((ofApp*)ofGetAppPtr())->mouseY);
    ofVec2f direction = particle->position - mousePosition;
    if (direction.length() > 0.0001f) direction.normalize();
    particle->velocity += direction * 0.05f;
    particle->velocity.x = ofClamp(particle->velocity.x, -3, 3);
    particle->velocity.y = ofClamp(particle->velocity.y, -3, 3);
    particle->position += particle->velocity * 0.2f;
}

// ---------------- StopState
void StopState::update(Particle* particle) {
    particle->velocity.set(0,0);
    // opcional: no mover la posición
}

// ---------------- CollisionState (estado Z)
// comportamiento simple: si dos partículas se superponen, se separan aplicando fuerza repulsiva.
// accede al vector particles de ofApp (por eso lo hicimos público).
void CollisionState::update(Particle* particle) {
    ofApp* app = (ofApp*)ofGetAppPtr();
    if (!app) return;

    // Primero aplicar movimiento normal
    particle->position += particle->velocity;

    // Chequear colisiones con otras partículas
    for (Particle* other : app->particles) {
        if (other == particle) continue;
        ofVec2f diff = particle->position - other->position;
        float dist = diff.length();
        float minDist = particle->size + other->size;
        if (dist > 0 && dist < minDist) {
            // simple respuesta: empujar cada partícula fuera una de otra proporcionalmente
            ofVec2f pushDir = diff.normalized();
            float overlap = (minDist - dist);

            // ajustar posiciones (dividir la corrección para no dar ventaja a una)
            particle->position += pushDir * (overlap * 0.5f);
            other->position -= pushDir * (overlap * 0.5f);

            // ajustar velocidades para simular rebote elástico simple (swap con fricción)
            ofVec2f relative = particle->velocity - other->velocity;
            float impulse = relative.dot(pushDir);
            if (impulse < 0) { // si se acercan
                float restitution = 0.8f; // cuánto "rebota"
                ofVec2f change = pushDir * ( -impulse * (1.0f + restitution) * 0.5f );
                particle->velocity += change;
                other->velocity -= change;
            }

            // limitar velocidad para estabilidad
            particle->velocity.x = ofClamp(particle->velocity.x, -6, 6);
            particle->velocity.y = ofClamp(particle->velocity.y, -6, 6);
        }
    }

    // además, mantener partículas dentro de la ventana con rebote ligero
    if (particle->position.x < 0) { particle->position.x = 0; particle->velocity.x *= -0.5f; }
    if (particle->position.x > ofGetWidth()) { particle->position.x = ofGetWidth(); particle->velocity.x *= -0.5f; }
    if (particle->position.y < 0) { particle->position.y = 0; particle->velocity.y *= -0.5f; }
    if (particle->position.y > ofGetHeight()) { particle->position.y = ofGetHeight(); particle->velocity.y *= -0.5f; }
}

// ---------------- ParticleFactory
Particle* ParticleFactory::createParticle(const std::string& type) {
    Particle* particle = new Particle();

    if (type == "star") {
        particle->size = ofRandom(2, 4);
        particle->color = ofColor(255, 200, 100);
    }
    else if (type == "shooting_star") {
        particle->size = ofRandom(3, 6);
        particle->color = ofColor(0, 255, 0);
        particle->velocity *= 3.0f;
    }
    else if (type == "planet") {
        particle->size = ofRandom(5, 8);
        particle->color = ofColor(0, 0, 255);
    }
    else if (type == "big_blue") {
        // NUEVO TIPO: azul claro y más grande
        particle->size = ofRandom(10, 18); // más grande
        particle->color = ofColor(173, 216, 230); // light blue
        // darle una velocidad más calmada
        particle->velocity *= 0.6f;
    }
    return particle;
}

// ---------------- ofApp
void ofApp::setup() {
    ofBackground(0);

    // Partículas star
    for (int i = 0; i < 100; ++i) {
        Particle* p = ParticleFactory::createParticle("star");
        particles.push_back(p);
        addObserver(p);
    }

    // shooting stars
    for (int i = 0; i < 5; ++i) {
        Particle* p = ParticleFactory::createParticle("shooting_star");
        particles.push_back(p);
        addObserver(p);
    }

    // planets
    for (int i = 0; i < 10; ++i) {
        Particle* p = ParticleFactory::createParticle("planet");
        particles.push_back(p);
        addObserver(p);
    }

    // NUEVOS: big_blue
    for (int i = 0; i < 8; ++i) {
        Particle* p = ParticleFactory::createParticle("big_blue");
        particles.push_back(p);
        addObserver(p);
    }
}

void ofApp::update() {
    for (Particle* p : particles) {
        p->update();
    }
}

void ofApp::draw() {
    for (Particle* p : particles) {
        p->draw();
    }
}

void ofApp::keyPressed(int key) {
    if (key == 's') {
        notify("stop");
    }
    else if (key == 'a') {
        notify("attract");
    }
    else if (key == 'r') {
        notify("repel");
    }
    else if (key == 'n') {
        notify("normal");
    }
    else if (key == 'z') {
        // activar estado Z (colisiones)
        notify("z");
    }
    else if (key == 'e') {
        // explode: acelera
        notify("explode");
    }
    else if (key == 'c') {
        // calm: reduce velocidad
        notify("calm");
    }
}
```

## **Reto**

Desarrolla un proyecto de arte generativo interactivo en tiempo real. Diferente, lo más que puedas al caso de estudio.

### Requisitos

- Utilizando **C++** y **openFrameworks**.
- Aplica el patrón de diseño **Observer**.
- Aplica el patrón de diseño **Factory**.
- Aplica el patrón de diseño **State**.
- Realiza pruebas desde el inicio del desarrollo para garantizar el correcto funcionamiento de la aplicación.
