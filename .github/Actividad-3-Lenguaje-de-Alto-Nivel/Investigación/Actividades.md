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
### Actividad 7

Ahora te voy a proponer que reflexiones profundamente sobre el manejo de la memoria en un programa. Se trata de un experimento en el que tienes que analizar por qué está funcionando mal.

- ¿Qué sucede cuando presionas la tecla “c”?

R/ Cuando se presiona la tecla “c” en la primera versión del código, aparentemente se crea un objeto Sphere y se guarda en el vector, pero en realidad no funciona correctamente. El motivo es que ese objeto (localSphere) se está creando en la pila (stack) de memoria, lo que significa que solo existe mientras dura la ejecución de la función createObjectInStack(). En cuanto la función termina, la variable local desaparece, y lo único que queda guardado en el vector es un puntero colgante (dangling pointer) que apunta a una zona de memoria que ya no es válida. Por eso, al intentar acceder o dibujar esa esfera después, se obtienen comportamientos extraños o errores.

Realiza esta modificación a la función createObjectInStack donde claramente se está creando un objeto, pero se está creando en el heap y no en el stack, así que no te dejes confundir por el nombre de la función.
```
void ofApp::createObjectInStack() {
    // Sphere localSphere(ofRandomWidth(), ofRandomHeight(), 30);
    // globalVector.push_back(&localSphere);
    // ofLog() << "Object created in stack: Position (" << localSphere.x << ", " << localSphere.y << ")";
    // localSphere.draw();
    Sphere* heapSphere = new Sphere(ofRandomWidth(), ofRandomHeight(), 30);
    globalVector.push_back(heapSphere);
    ofLog() << "Object created in heap: Position (" << heapSphere->x << ", " << heapSphere->y << ")";
    heapSphere->draw();
}
```
- ¿Qué sucede cuando presionas la tecla “c”?
- ¿Por qué ocurre esto?

R/ Cuando se modifica la función para crear el objeto en el montón (heap) con new Sphere(...), la situación cambia. Ahora el objeto no se destruye al salir de la función, sino que permanece en memoria hasta que se libere manualmente con delete. De esta manera, el puntero guardado en el vector siempre apunta a un objeto válido y sí se puede acceder a él o dibujarlo correctamente.

### Reto

Vas a desarrollar una aplicación que genere una cuadrícula de esferas en un espacio tridimensional y que permita interactuar con ellas a través de la cámara y el ratón. Deberás implementar la lógica para seleccionar una esfera con el ratón y mostrar la información de la esfera seleccionada en la pantalla.

Por ejemplo, la aplicación podría verse así:

OfApp.h: 
```
#pragma once
#include "ofMain.h"

class ofApp : public ofBaseApp {
public:
    void setup() override;
    void update() override;
    void draw() override;

    void keyPressed(int key) override;
    void mousePressed(int x, int y, int button) override;

private:
    // --- escena ---
    ofEasyCam cam;
    std::vector<glm::vec3> spherePositions;   // posiciones de la cuadrícula
    int xStep = 40;            // separación en X
    int yStep = 40;            // separación en Y
    float distDiv = 50.0f;     // divisor para la función cos
    float amplitud = 120.0f;   // amplitud (altura) de la onda
    float sphereRadius = 5.0f; // radio de cada punto/esfera

    // selección
    bool sphereSelected = false;
    int selectedIndex = -1;            // índice dentro del vector
    glm::vec3 selectedSpherePos = {};  // cache para HUD

    // --- helpers ---
    void generateSpheres();
    void convertMouseToRay(int mouseX, int mouseY, glm::vec3& rayStart, glm::vec3& rayEnd);
    bool rayIntersectsSphere(const glm::vec3& rayStart, const glm::vec3& rayDir,
                             const glm::vec3& sphereCenter, float sphereRadius,
                             glm::vec3& intersectionPoint);

    ofColor colorFromHeight(float z) const; // gradiente verde→amarillo→rojo según z
};
```
ofApp.cpp:
```
#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup() {
    ofSetFrameRate(120);
    ofBackground(220);
    ofEnableDepthTest();     // necesario para 3D
    cam.setDistance(700);    // distancia inicial de la cámara
    cam.enableMouseInput();  // rotación/zoom con el mouse

    generateSpheres();
}

//--------------------------------------------------------------
void ofApp::update() {
    // (no animación por defecto; todo es interactivo)
}

//--------------------------------------------------------------
void ofApp::draw() {
    // HUD
    ofSetColor(0);
    ofDrawBitmapStringHighlight("FPS: " + ofToString(ofGetFrameRate(), 2), 15, 20);
    ofDrawBitmapStringHighlight("Step ( + / - ): " + ofToString(xStep) + ", " + ofToString(yStep), 15, 40);
    ofDrawBitmapStringHighlight("DistDiv ( D / S ): " + ofToString(distDiv, 1), 15, 60);
    ofDrawBitmapStringHighlight("Amplitud ( A / Z ): " + ofToString(amplitud, 1), 15, 80);
    ofDrawBitmapStringHighlight("Radio ( ] / [ ): " + ofToString(sphereRadius, 1), 15, 100);
    if (sphereSelected) {
        ofDrawBitmapStringHighlight("Seleccion: idx " + ofToString(selectedIndex) +
                                    "  pos: " + ofToString(selectedSpherePos), 15, 120);
    } else {
        ofDrawBitmapStringHighlight("Seleccion: (ninguna)  — click para seleccionar", 15, 120);
    }

    cam.begin();

    // dibujar la nube de puntos / esferas
    for (size_t i = 0; i < spherePositions.size(); ++i) {
        const auto& p = spherePositions[i];
        ofSetColor(colorFromHeight(p.z));
        ofDrawSphere(p, sphereRadius);
    }

    // resaltar la esfera seleccionada
    if (sphereSelected && selectedIndex >= 0 && selectedIndex < (int)spherePositions.size()) {
        ofNoFill();
        ofSetLineWidth(2.5f);
        ofSetColor(0);
        ofDrawSphere(spherePositions[selectedIndex], sphereRadius * 1.8f);
        ofFill();
    }

    cam.end();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key) {
    switch (key) {
        // densidad de la malla
        case '+': case '=':
            xStep += 2; yStep += 2;
            generateSpheres();
            break;
        case '-': case '_':
            xStep = std::max(4, xStep - 2);
            yStep = std::max(4, yStep - 2);
            generateSpheres();
            break;

        // amplitud Z
        case 'a': case 'A':
            amplitud += 5.0f; generateSpheres(); break;
        case 'z': case 'Z':
            amplitud = std::max(5.0f, amplitud - 5.0f); generateSpheres(); break;

        // divisor de distancia (frecuencia radial)
        case 'd': case 'D':
            distDiv += 5.0f; generateSpheres(); break;
        case 's': case 'S':
            distDiv = std::max(5.0f, distDiv - 5.0f); generateSpheres(); break;

        // radio de esfera
        case ']':
            sphereRadius = std::min(30.0f, sphereRadius + 1.0f); break;
        case '[':
            sphereRadius = std::max(1.0f, sphereRadius - 1.0f); break;

        // reset vista/params rápidos
        case 'r': case 'R':
            xStep = yStep = 40;
            distDiv = 50.0f;
            amplitud = 120.0f;
            sphereRadius = 5.0f;
            sphereSelected = false;
            selectedIndex = -1;
            generateSpheres();
            break;
    }
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button) {
    if (button != OF_MOUSE_BUTTON_LEFT) return;

    // convertir el click a un rayo en 3D
    glm::vec3 rayStart, rayEnd;
    convertMouseToRay(x, y, rayStart, rayEnd);
    glm::vec3 rayDir = glm::normalize(rayEnd - rayStart);

    // buscar la primera intersección
    sphereSelected = false;
    selectedIndex = -1;
    float closestT = std::numeric_limits<float>::max();

    for (int i = 0; i < (int)spherePositions.size(); ++i) {
        glm::vec3 hit;
        if (rayIntersectsSphere(rayStart, rayDir, spherePositions[i], sphereRadius, hit)) {
            // escoger la más cercana al origen del rayo
            float t = glm::length(hit - rayStart);
            if (t < closestT) {
                closestT = t;
                sphereSelected = true;
                selectedIndex = i;
                selectedSpherePos = spherePositions[i];
            }
        }
    }
}

//--------------------------------------------------------------
void ofApp::generateSpheres() {
    spherePositions.clear();
    spherePositions.reserve( (ofGetWidth() / xStep + 2) * (ofGetHeight() / yStep + 2) );

    // cuadrícula centrada en (0,0) en el plano X-Y; Z por función radial
    for (int x = -ofGetWidth() / 2; x < ofGetWidth() / 2; x += xStep) {
        for (int y = -ofGetHeight() / 2; y < ofGetHeight() / 2; y += yStep) {
            float z = cos(ofDist(x, y, 0, 0) / distDiv) * amplitud;
            spherePositions.emplace_back(x, y, z);
        }
    }
}

//--------------------------------------------------------------
void ofApp::convertMouseToRay(int mouseX, int mouseY, glm::vec3& rayStart, glm::vec3& rayEnd) {
    glm::mat4 modelview = cam.getModelViewMatrix();
    glm::mat4 projection = cam.getProjectionMatrix();
    ofRectangle viewport = ofGetCurrentViewport();

    // NDC
    float nx = 2.0f * (mouseX - viewport.x) / viewport.width - 1.0f;
    float ny = 1.0f - 2.0f * (mouseY - viewport.y) / viewport.height;

    glm::vec4 rayStartNDC(nx, ny, -1.0f, 1.0f); // near
    glm::vec4 rayEndNDC  (nx, ny,  1.0f, 1.0f); // far

    glm::mat4 inv = glm::inverse(projection * modelview);
    glm::vec4 rayStartWorld = inv * rayStartNDC;
    glm::vec4 rayEndWorld   = inv * rayEndNDC;

    rayStartWorld /= rayStartWorld.w;
    rayEndWorld   /= rayEndWorld.w;

    rayStart = glm::vec3(rayStartWorld);
    rayEnd   = glm::vec3(rayEndWorld);
}

//--------------------------------------------------------------
bool ofApp::rayIntersectsSphere(const glm::vec3& rayStart, const glm::vec3& rayDir,
                                const glm::vec3& sphereCenter, float radius,
                                glm::vec3& intersectionPoint) {
    // Ecuación cuadrática del rayo contra esfera
    glm::vec3 oc = rayStart - sphereCenter;
    float a = glm::dot(rayDir, rayDir);
    float b = 2.0f * glm::dot(oc, rayDir);
    float c = glm::dot(oc, oc) - radius * radius;

    float disc = b * b - 4.0f * a * c;
    if (disc < 0.0f) return false;

    float t = (-b - sqrtf(disc)) / (2.0f * a);
    if (t < 0.0f) return false; // detrás de la cámara

    intersectionPoint = rayStart + t * rayDir;
    return true;
}

//--------------------------------------------------------------
ofColor ofApp::colorFromHeight(float z) const {
    // mapear z ∈ [-amplitud, +amplitud] a t ∈ [0,1]
    float t = ofMap(z, -amplitud, amplitud, 0.0f, 1.0f, true);
    // gradiente verde->amarillo->rojo
    ofColor green(0, 255, 0), yellow(255, 255, 0), red(255, 0, 0);
    if (t < 0.5f) {
        float k = ofMap(t, 0.0f, 0.5f, 0.0f, 1.0f, true);
        return green.getLerped(yellow, k);
    } else {
        float k = ofMap(t, 0.5f, 1.0f, 0.0f, 1.0f, true);
        return yellow.getLerped(red, k);
    }
}
```
