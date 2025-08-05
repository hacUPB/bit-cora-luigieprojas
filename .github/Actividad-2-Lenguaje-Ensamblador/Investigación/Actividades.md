c### Actividad 1

- **¿Qué es la entrada-salida mapeada a memoria?**
**R/** La entrada-salida mapeada a memoria (o memory-mapped I/O) es una técnica donde ciertos rangos de la memoria RAM están reservados para representar dispositivos de entrada y salida, como la pantalla o el teclado. Es decir, en vez de usar instrucciones especiales para controlar estos dispositivos, simplemente se leen o escriben valores en direcciones específicas de memoria y eso automáticamente interactúa con el hardware.
- ¿Cómo se implementa en la plataforma Hack?
**R/** En la arquitectura Hack esto se hace asignando rangos fijos en la memoria para representar tanto la pantalla (SCREEN) como el teclado (KBD). Por ejemplo:

La dirección 16384 (0x4000) en adelante representa la pantalla (cada palabra representa 16 pixeles en horizontal).

La dirección 24576 (0x6000) representa el estado actual del teclado (el código ASCII de la tecla presionada, o 0 si no hay ninguna).
Así, para dibujar en pantalla, se escribe directamente en la RAM empezando desde la dirección SCREEN, y para leer del teclado, se accede al valor almacenado en KBD
- Inventa un programa que haga uso de la entrada-salida mapeada a memoria.
- Investiga el funcionamiento del programa con el simulador.

### Actividad 3

Vas a implementar y simular una modificación al reto 20 de la unidad anterior. Si se presiona la letra “d” muestras la imagen que diseñaste en el reto 18. Si no se presiona ninguna tecla, borrarás la imagen.

**R/**  
```

```
### Actividad 4

Ahora realizarás una nueva variación al programa de la actividad anterior. Si se presiona la letra “d” muestras la imagen que diseñaste en el reto 18. Solo si se presiona la letra “e” borrarás la imagen que se muestra en pantalla.

```

```
