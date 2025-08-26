### Actividad 1

Esta actividad será grupal y demostrativa. Te mostraré los pasos a seguir para instalar y probar la herramienta que usarás desde ahora en el curso. Se trata de **[openframeworks](https://openframeworks.cc/)**. El objetivo en este curso no es que aprendas a programar en **openframeworks**, sino que entiendas cómo se implementan algunos conceptos de programación en alto nivel, pero usando un **framework** de programación creativa en C++ que te permitan explorar y experimentar de manera más visual y creativa.

- ¿Cuál es el resultado que se obtiene al ejecutar este programa?

**Respuesta/** Este programa muestra una pantalla en negro y con el puntero con un circulo blanco alrededor. A medida que se mueve el click el circulo blanco se va moviendo igualmente

### Actividad 2

De nuevo una actividad grupal en la cual escribiremos juntos nuestra primera aplicación y analizaremos las diferentes partes que la componen.

Modifica el archivo ofApp.h así:
```
#pragma once

#include "ofMain.h"

class ofApp : public ofBaseApp{

    public:
        void setup();
        void update();
        void draw();

        void mouseMoved(int x, int y );
        void mousePressed(int x, int y, int button);

    private:

        vector<ofVec2f> particles;
        ofColor particleColor;

};
```
Modifica el Archivo ofApp.cpp así:
```
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);
    particleColor = ofColor::white;
}

//--------------------------------------------------------------
void ofApp::update(){

}

//--------------------------------------------------------------
void ofApp::draw(){
    for(auto &pos: particles){
        ofSetColor(particleColor);
        ofDrawCircle(pos.x, pos.y, 50);
    }
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){
    particles.push_back(ofVec2f(x, y));
    if (particles.size() > 100) {
        particles.erase(particles.begin());
    }
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}
```
Analicemos juntos este código:

- ¿Qué fue lo que incluimos en el archivo .h?
- R/ En ese archivo lo que hicimos fue declarar la estructura básica de la aplicación, o sea como el “esqueleto”. Allí definimos qué funciones va a tener nuestro programa (setup, update, draw, y las que reaccionan al mouse). También dejamos listas dos variables: una lista de partículas (que son puntos con posición en X y Y) y una variable que guarda el color con el que se van a dibujar esas partículas.
- ¿Cómo funciona la aplicación?
- R/ La aplicación abre una ventana negra y, a medida que movemos el mouse, va dibujando círculos en el recorrido. Eso genera como una estela de hasta 100 círculos que siguen el movimiento. Además, cuando hacemos clic, todos esos círculos cambian de color a uno nuevo y aleatorio. Es una especie de rastro colorido que responde a cómo movemos y usamos el mouse.
- ¿Qué hace la función mouseMoved?
- R/ Cada vez que movemos el mouse, esta función guarda la posición actual en la lista de partículas. Si ya hay más de 100 posiciones guardadas, borra la más vieja para no tener infinitos círculos acumulados. En otras palabras, controla que el rastro se vea pero que no se quede todo saturado con círculos de movimientos pasados.
- ¿Qué hace la función mousePressed?
- R/ Cuando presionamos un clic del mouse, se cambia el color de todas las partículas a un color nuevo generado al azar. Esto le da vida al ejercicio porque no es siempre el mismo color, sino que puede ir cambiando mientras jugamos con el mouse.
- ¿Qué hace la función setup?
- R/ Al inicio del programa, setup pone el fondo en negro y establece que el color de las partículas sea blanco. Es como la preparación antes de empezar, para dejar la ventana lista.
- ¿Qué hace la función update?
- R/ En este caso no hace nada todavía. Supongo que es el espacio donde normalmente irían cálculos o actualizaciones de movimiento más complejos, pero aquí lo dejamos vacío.
- ¿Qué hace la función draw?
- R/ Aquí es donde se dibuja todo lo que vemos en pantalla. Recorre la lista de partículas y, para cada una, dibuja un círculo en la posición guardada, con el color que tengamos activo. Es la parte que convierte la lógica en algo visual.

### Actividad 3

Analiza la aplicación anterior. 
1. ¿Qué hace cada función?
2. ¿Qué hace cada línea de código?
3. Realiza un experimento con la aplicación anterior. Modifica alguna parte importante de su código.

R/ setup(): se ejecuta al inicio, pone el fondo negro y define el color inicial de las partículas en blanco.

update(): está vacío en este caso, pero es donde normalmente se harían cálculos o se actualizarían variables que cambian con el tiempo.

draw(): se encarga de recorrer la lista de partículas y dibujar los círculos en las posiciones que se han guardado. Es la parte visual de la aplicación.

mouseMoved(): cada vez que movemos el mouse guarda la nueva posición en la lista de partículas, y si ya hay más de 100, borra la primera para que el rastro no sea infinito.

mousePressed(): cuando hacemos clic cambia el color de todas las partículas por uno nuevo, generado de manera aleatoria.

R/ ofBackground(0); → pinta el fondo de negro al inicio.

particleColor = ofColor::white; → establece el color inicial en blanco.

for(auto &pos: particles){ ... } → recorre todas las posiciones guardadas en la lista de partículas.

ofSetColor(particleColor); → define el color con el que se dibujará el círculo.

ofDrawCircle(pos.x, pos.y, 50); → dibuja un círculo en la posición del mouse con radio 50.

particles.push_back(ofVec2f(x, y)); → agrega la posición actual del mouse a la lista.

if (particles.size() > 100) { particles.erase(particles.begin()); } → borra la partícula más vieja cuando ya hay más de 100 guardadas.

particleColor = ofColor(ofRandom(255), ofRandom(255), ofRandom(255)); → genera un color nuevo y lo aplica a todas las partículas al hacer clic.

R/ Yo modifique mi codigo haciendo que el circulo que esta con el puntero en lugar de ser estatico, vaya cambiando de tamaño.

Originalmente estaba esta línea:

```
ofDrawCircle(pos.x, pos.y, 50);
```

Y la dejamos así:

```
ofDrawCircle(pos.x, pos.y, ofRandom(10, 60));

```
En lugar de dibujar siempre círculos del mismo tamaño (radio 50), ahora cada vez que se dibuja un círculo se elige un tamaño aleatorio entre 10 y 60. Eso hace que la estela tenga círculos grandes, medianos o pequeños, y que cambien constantemente sin necesidad de código extra complicado.

### Actividad 5

En la unidad anterior introdujimos el concepto de puntero. Ahora vamos a profundizar en este concepto de manera práctica.

El siguiente ejemplo se supone (en la actividad que sigue vas a corregir un error) que te permite seleccionar una espera y moverla con el mouse.

Responde:

- ¿Cuál es la definición de un puntero?
- R/ Un puntero es una variable especial que no guarda directamente un valor normal como un número o un texto, sino que guarda la dirección en memoria de otro objeto o variable. Es decir, apunta hacia dónde está guardado algo para poder acceder a él o manipularlo de manera indirecta.
- ¿Dónde está el puntero
- R/ En este código el puntero está en la clase ofApp, con esta línea:
```
Sphere* selectedSphere;
```
Aquí selectedSphere es un puntero, porque en vez de ser una esfera directamente, apunta a una esfera que está en el vector spheres.
- ¿Cómo se inicializa el puntero?
- R/ El puntero se inicializa en el setup():
  ```
  selectedSphere = nullptr;
  ```
  Esto significa que al inicio no está apuntando a ninguna esfera en particular (está vacío). Más adelante, cuando damos clic, cambia para apuntar a una esfera específica.
- ¿Para qué se está usando el puntero?
- R/ El puntero se usa para recordar cuál esfera hemos seleccionado con el mouse. Así, en el update() el programa sabe cuál esfera debe moverse siguiendo el puntero del mouse. Sin puntero, sería más complicado saber cuál esfera mover de todas las que están en la pantalla.
- ¿Qué es exactamente lo que está almacenado en el puntero?
- R/ En el puntero no está guardada la esfera como tal, sino la dirección de memoria donde está la esfera que seleccionamos. O sea, es como si tuviéramos la dirección de una casa: no tenemos la casa dentro del bolsillo, pero sí la dirección que nos dice dónde ir a buscarla. 

### Actividad 6

El código anterior tiene un problema. ¿Puedes identificar cuál es? ¿Cómo lo solucionarías? Recuerda que deberías poder seleccionar una esfera y moverla con el mouse.

**Respuesta/:**

El problema del código está en que, aunque sí permite seleccionar una esfera con el clic, nunca se libera esa selección. En otras palabras, cuando se hace clic sobre una esfera esta queda “pegada” permanentemente al cursor, ya que en update() se actualiza siempre con la posición del mouse, pero no existe ningún evento que indique cuándo soltarla. Esto hace que después de seleccionarla no se pueda dejar fija en un punto.

La solución es implementar la función mouseReleased. De esta manera, cuando el usuario suelte el botón del mouse, se puede poner nuevamente el puntero selectedSphere en nullptr, logrando que la esfera deje de seguir el cursor y quede en su nueva posición. Con este cambio ya se puede seleccionar una esfera con un clic, arrastrarla y luego soltarla correctamente al dejar de presionar el mouse.

Código:

ofApp.h:
```
#pragma once

#include "ofMain.h"

class Sphere {
public:
    Sphere(float x, float y, float radius);
    void draw();
    void update(float x, float y);
    float getX();
    float getY();
    float getRadius();

private:
    float x, y;
    float radius;
    ofColor color;
};

class ofApp : public ofBaseApp{

    public:
        void setup();
        void update();
        void draw();

        void mouseMoved(int x, int y );
        void mousePressed(int x, int y, int button);
        void mouseReleased(int x, int y, int button);   // <-- añadido

    private:
        vector<Sphere*> spheres;
        Sphere* selectedSphere;
};
```
ofApp.cpp:
```
#include "ofApp.h"

Sphere::Sphere(float x, float y, float radius) : x(x), y(y), radius(radius) {
    color = ofColor(ofRandom(255), ofRandom(255), ofRandom(255));
}

void Sphere::draw() {
    ofSetColor(color);
    ofDrawCircle(x, y, radius);
}

void Sphere::update(float x, float y) {
    this->x = x;
    this->y = y;
}

float Sphere::getRadius() { return radius; }
float Sphere::getX() { return x; }
float Sphere::getY() { return y; }

//--------------------------------------------------------------
void ofApp::setup(){
    ofBackground(0);

    for (int i = 0; i < 5; i++) {
        float x = ofRandomWidth();
        float y = ofRandomHeight();
        float radius = ofRandom(20, 50);
        spheres.push_back(new Sphere(x, y, radius));
    }
    selectedSphere = nullptr;
}

//--------------------------------------------------------------
void ofApp::update(){
    if (selectedSphere != nullptr) {
        selectedSphere->update(ofGetMouseX(), ofGetMouseY());
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    for (auto sphere : spheres) {
        sphere->draw();
    }
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
    if(button == OF_MOUSE_BUTTON_LEFT){
        for (auto sphere : spheres) {
            float distance = ofDist(x, y, sphere->getX(), sphere->getY());
            if (distance < sphere->getRadius()) {
                selectedSphere = sphere;
                break;
            }
        }
    }
}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){
    if(button == OF_MOUSE_BUTTON_LEFT){
        selectedSphere = nullptr;   // <-- soltar la esfera
    }
}
```

