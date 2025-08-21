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
