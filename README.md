# Sistema de Gestión de Infracciones de Tránsito

Este proyecto es una implementación completa de un sistema de gestión de bases de datos relacional construida **desde cero**, sin utilizar motores de bases de datos existentes (como SQL) ni librerías de alto nivel.

El objetivo principal de este desarrollo fue resolver problemas complejos de ingeniería de software: **persistencia de datos**, **indexación eficiente**, **gestión de memoria dinámica** y **complejidad algorítmica**, implementando manualmente las estructuras que los frameworks modernos suelen abstraer.

---

## 🎯 Propósito del Proyecto

El sistema es una plataforma de **Gestión de Infracciones de Tránsito y Control de Conductores**. Su función principal es automatizar el seguimiento de la conducta vial mediante un sistema de **Scoring**.

### Funcionalidades principales:
- **Gestión de Conductores (ABMC):** Registro completo de conductores con validación de identidad y datos de contacto.
- **Sistema de Scoring Dinámico:** Cada conductor inicia con un puntaje (20 puntos). Al registrarse una infracción, el sistema descuenta automáticamente los puntos según la gravedad de la falta.
- **Inhabilitación Automática:** Si el scoring llega a cero, el sistema bloquea automáticamente al conductor y calcula una fecha de rehabilitación basada en su historial de reincidencias.
- **Módulo de Estadísticas y Reportes:** Generación de métricas sobre rangos etarios con más faltas, porcentajes de reincidencia y listados de conductores inhabilitados.

---

## 🚀 Desafíos Técnicos y Soluciones Implementadas

### 1. Arquitectura Híbrida: Disco + RAM (Indexación)
Uno de los mayores retos fue garantizar búsquedas rápidas sin cargar todos los datos en memoria.
- **Problema:** Realizar búsquedas secuenciales en archivos binarios (disco) tiene una complejidad de $O(n)$, lo cual es ineficiente con grandes volúmenes de datos.
- **Solución:** Implementé un sistema de **Indexación en Memoria** utilizando **Árboles Binarios de Búsqueda (BST)**.
    - Al iniciar el sistema, solo se cargan en RAM las "claves" (DNI y Nombre) y la "dirección física" (puntero al archivo) del registro.
    - Esto permite realizar búsquedas con complejidad **logarítmica $O(\log n)$**.
    - Una vez encontrado el nodo en el árbol, el sistema hace un **acceso directo (Seek)** al archivo binario para recuperar la información completa. *Es básicamente cómo funciona un índice SQL por debajo.*

### 2. Persistencia de Datos Binaria (Custom DB)
- Implementación de un sistema **ABMC (Alta, Baja, Modificación, Consulta)** persistente.
- Uso de archivos tipados (binarios) para almacenamiento optimizado.
- Manejo de **bajas lógicas** (flags de habilitación) para mantener la integridad referencial e histórica de los datos sin fragmentar el archivo físico.

### 3. Gestión Manual de Memoria (Punteros)
A diferencia de lenguajes con *Garbage Collector* (como Java o Python), en este proyecto la gestión de memoria es manual.
- Uso extensivo de **Punteros** y asignación dinámica de memoria (`New`/`Dispose`) para la creación de nodos en Árboles y Listas Enlazadas.
- Implementación de algoritmos recursivos para el recorrido de árboles (Preorden, Inorden) y búsqueda de datos.

### 4. Estructuras de Datos Dinámicas
El sistema selecciona la estructura de datos adecuada según la necesidad del algoritmo:
- **Árboles Binarios:** Para búsquedas rápidas (Indexación).
- **Listas Enlazadas Simples:** Para la generación de reportes y filtrado temporal de datos (ej. "Listar infracciones entre dos fechas"), permitiendo ordenamientos dinámicos sin afectar la estructura principal de almacenamiento.

---

## 🛠 Habilidades de Ingeniería Demostradas

Más allá del lenguaje utilizado, este proyecto demuestra dominio sobre los fundamentos de la computación:

*   **Algoritmia:** Búsqueda binaria, ordenamiento, recursividad.
*   **Estructuras de Datos:** BST (Binary Search Trees), Listas Enlazadas, Vectores/Arrays.
*   **Sistemas de Archivos:** Acceso aleatorio (`Seek`), lectura/escritura de buffers.
*   **Modularización:** Arquitectura separada en unidades (Front-controller, Lógica de Negocio, Definición de Datos, Utilidades).
*   **Clean Code:** Código refactorizado para mantenibilidad y escalabilidad.

---

## 💻 Ejecución del Proyecto

El proyecto está escrito en Pascal estándar, priorizando la portabilidad y el rendimiento nativo.

**Requisitos:**
- Free Pascal Compiler (FPC) o Lazarus IDE.

**Compilación y Ejecución:**
```bash
fpc proyecto.pas
./proyecto.exe
```

---

*Este proyecto fue desarrollado como una prueba de concepto para demostrar la capacidad de construir sistemas complejos de gestión de datos entendiendo las bases fundamentales de la programación estructurada y el manejo de recursos.*
