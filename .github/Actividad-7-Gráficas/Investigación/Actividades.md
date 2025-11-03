  ## Actividad 01

- ¿Qué son los vértices? 

R/ Los vértices son los puntos que definen la forma de los objetos en 3D.
Cada vértice contiene información como su posición en el espacio (x, y, z), color, coordenadas de textura y normales.
A partir de los vértices, la GPU forma triángulos u otras figuras para construir modelos tridimensionales.
 s
- ¿Con qué figura geométrica se dibuja en 3D? 

R/ En gráficos 3D, todo se dibuja con triángulos.
Los triángulos son la unidad geométrica más simple que puede representar cualquier superficie compleja cuando se combinan en grandes cantidades (mallas o meshes).

- ¿Qué es un shader?

R/ Un shader es un programa pequeño que se ejecuta en la GPU para controlar cómo se dibujan los gráficos.
Existen distintos tipos de shaders, como los vertex shaders y los fragment shaders, y permiten manipular la apariencia visual de los objetos (colores, luces, texturas, efectos, etc.). 

- ¿Cómo se le llaman a los grupos de píxeles de un mismo triángulo?

R/ Se les llama fragmentos (fragments).
Cada fragmento representa un píxel potencial del triángulo en pantalla, y contiene información como color, profundidad, y coordenadas de textura antes de convertirse en un píxel final.

- ¿Qué es un fragment shader?

R/ El fragment shader es el programa que determina el color final de cada fragmento (píxel).
Aquí se calculan los efectos visuales, la iluminación, las sombras, la textura o la transparencia antes de enviar el resultado al framebuffer. 

- ¿Qué es un vertex shader? 

R/ El vertex shader procesa cada vértice individualmente.
Se encarga de transformar las coordenadas 3D del modelo en coordenadas 2D de la pantalla, aplicando rotaciones, traslaciones y proyecciones.
También puede enviar información adicional a los fragment shaders, como colores o normales. 

- ¿Al proceso de determinar qué pixels del display va a cubrir cada triángulo de una mesh se le llama? 

R/  Ese proceso se llama rasterización (rasterization).
Convierte los triángulos definidos por vértices en fragmentos (grupos de píxeles) que luego serán procesados por el fragment shader.

- ¿Qué es el render pipeline?

R/ El render pipeline (o graphics pipeline) es el conjunto de etapas que sigue la GPU para transformar los datos 3D en una imagen final 2D.
Incluye pasos como:

Procesamiento de vértices.
Ensamblado de primitivas (triángulos).
Rasterización.
Procesamiento de fragmentos.
Escritura en el framebuffer.

- ¿Hay alguna diferencia entre aplicar un color a una superficie de una mesh o aplicar una textura?

R/ Sí.

Aplicar un color: se asigna un solo tono o un gradiente simple al objeto.
Aplicar una textura: se usa una imagen (mapa) que se “envuelve” sobre la superficie, dando más detalle (por ejemplo, piel, metal, madera, etc.).

- ¿Cuál es la diferencia entre una textura y un material?

R/ Una textura es una imagen o patrón que se aplica sobre un objeto 3D.
Un material define cómo interactúa la superficie con la luz. Puede incluir varias texturas (difusa, especular, normal map, etc.) y propiedades físicas (brillo, rugosidad, transparencia).

- ¿Qué transformaciones se requieren para mover un vértice del 3D world al View Screen?

R/ Las transformaciones son:

Model Transform: mueve el objeto dentro del mundo 3D.
View Transform: coloca la cámara en una posición y orientación.
Projection Transform: convierte las coordenadas 3D a 2D, aplicando perspectiva.
Viewport Transform: ajusta las coordenadas finales al tamaño real de la pantalla.

- ¿Al proceso de convertir los triángulos en fragmentos se le llama?

R/ Ese proceso se llama nuevamente rasterización, ya que es el paso donde los triángulos se transforman en fragmentos que representan píxeles.

- ¿Qué es el framebuffer? 

R/ El framebuffer es una región de memoria donde la GPU almacena la imagen final que se mostrará en pantalla.
Contiene la información de color, profundidad (Z-buffer) y otros datos por cada píxel.

- ¿Para qué se usa el Z-buffer o depth buffer en el render pipeline? 

R/ El Z-buffer o depth buffer guarda la profundidad (distancia a la cámara) de cada píxel renderizado.
Sirve para decidir qué objeto está delante o detrás cuando varios se superponen, evitando que se dibujen incorrectamente. 

- Luego de ver el segundo video entiendes por qué la GPU tiene que funcionar tan rápido y de manera paralela. ¿Por qué? 

R/ Porque la GPU debe procesar millones de vértices y píxeles al mismo tiempo para generar imágenes en tiempo real (por ejemplo, 60 cuadros por segundo o más).
Para lograrlo, está diseñada con miles de núcleos que trabajan en paralelo, cada uno ejecutando operaciones similares sobre distintos datos.
Mientras la CPU se enfoca en tareas secuenciales, la GPU destaca en el procesamiento masivo paralelo, ideal para gráficos, simulaciones y aprendizaje profundo.

## Actividad 02 

Observa la salida.

Ahora ejecuta el código original. Analiza los resultados y responde:

- ¿Cómo funciona?
- ¿Qué resultados obtuviste?
- ¿Estás usando un vertex shader?
- ¿Estás usando un fragment shader?
- Analiza el código de los shaders. ¿Qué hace cada uno? 

## Actividad 03

Ahora vas a pasar información personalizada de tu programa a los shaders. Vas a leer con detenimiento el tutorial Adding Uniforms.

- ¿Qué es un uniform?
- ¿Cómo funciona el código de aplicación, los shaders y cómo se comunican estos?

Modifica el código de la actividad para cambiar el color de cada uno de los píxeles de la pantalla personalizando el fragment shader.

## Actividad 4

Vas a realizar la última actividad de esta experiencia de aprendizaje. Yo sé que quieres seguir haciendo más, pero tenemos un tiempo muy limitado.

Analiza el ejemplo Adding some interactivity.

- ¿Qué hace el código del ejemplo?
- ¿Cómo funciona el código de aplicación, los shaders y cómo se comunican estos?
- Realiza modificaciones a ofApp.cpp y al vertex shader para conseguir otros comportamientos.
- Realiza modificaciones al fragment shader para conseguir otros comportamientos.
