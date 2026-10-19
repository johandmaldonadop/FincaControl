# FincaControl 🚜🐄

**FincaControl** es una solución de software tipo aplicación móvil diseñada para la gestión ganadera integral en fincas de doble propósito (producción de leche y carne). Permite a los pequeños y medianos productores digitalizar sus registros operativos en físico para centralizar el historial productivo y financiero, optimizando la toma de decisiones y mejorando la rentabilidad del negocio.

---

## 👥 Equipo de Trabajo (Grupo 3)
* **Johan Maldonado**
* **José Chacón**

---

## 🔴 El Problema
En las fincas productoras comúnmente se carece de mecanismos eficientes para llevar una trazabilidad ordenada del ganado y la producción. La dependencia de registros en físico (papel o libretas) dificulta el acceso rápido a la información, limita la visibilidad sobre el estado de la finca y es propensa a errores o pérdidas de datos.

## 🟢 Nuestra Solución
Ofrecemos una **aplicación móvil con enfoque Offline-First** que cuenta con una interfaz intuitiva y fácil de usar. El sistema permite a los productores pasar de la recolección física a la digital, garantizando un control preciso de la productividad por animal y la rentabilidad directamente desde el campo, incluso sin conexión a internet.

---

## 🎯 Características Principales (Alcance)

### Dentro del Alcance 📋
<<<<<<< HEAD
* **Gestión de Inventario, Condiciones Fisiológicas y Genealogía:** Registro detallado de animales separando el **Número Identificador** individual de la marca descriptiva del **Hierro** (propietario y procedencia), catálogo extensible de **razas** (predeterminadas y personalizadas), clasificación por **condiciones fisiológicas** (*Becerro/a, Maute/a, Novillo/Novilla, Toro Reproductor, Vaca parida, Vaca escotera, Vaca seca*), estado de **preñez** e historial genealógico referenciado por el número identificador.
* **Control de Producción:** Módulos específicos para el registro diario de ordeño (con gestión de tanque de leche) y pesajes periódicos con cálculo de GDP.
* **Gestión Sanitaria y Reproductiva:** Calendarios de vacunación, seguimiento de servicios, gestaciones, secados, partos (con alta automática de crías) y tiempos de retiro de medicamentos.
=======
* **Gestión de Inventario y Genealogía:** Registro detallado de animales e historial genealógico.
* **Control de Producción:** Módulos específicos para el registro diario de ordeño y pesajes.
* **Gestión Sanitaria y Reproductiva:** Calendarios de vacunación, seguimiento de servicios, gestaciones, partos y tiempos de retiro de medicamentos.
>>>>>>> origin/Jose
* **Módulo Financiero Operativo:** Gestión de ingresos, egresos y cálculo de costos directos de producción de leche y carne.
* **Capacidad Offline:** Almacenamiento local de datos para garantizar la operatividad continua en zonas rurales sin cobertura.

### Fuera de Alcance 🚫
* Contabilidad fiscal compleja (facturación electrónica avanzada o módulos tributarios específicos).
* Marketplace o comercio electrónico integrado para la compra/venta de ganado.
* Soporte para otras categorías productivas (diseñado exclusivamente para ganado bovino de leche y carne).

---

## 🏗️ Atributos de Calidad y Criterios Arquitectónicos
* **Disponibilidad (Modo Offline):** Priorización de una arquitectura *Offline-First* que garantiza la integridad de la base de datos local y sincronización posterior.
* **Escalabilidad:** Arquitectura capaz de soportar el crecimiento del volumen de datos a medida que la finca se expande.
* **Seguridad:** Implementación de esquemas de autenticación robusta y control de acceso basado en roles para proteger la información financiera y operativa.

---

## 🛠️ Tecnologías Utilizadas
*(Completa este apartado con las tecnologías exactas de tu proyecto)*
* **Frontend Móvil:** [Ej: Flutter / React Native / Android Studio]
* **Base de Datos Local:** [Ej: SQLite / Hive / Room]
* **Backend / API (Si aplica):** [Ej: Node.js / Firebase]

---

## 🚀 Instalación y Configuración Local

### Prerrequisitos
Asegúrate de tener instalado lo siguiente en tu entorno de desarrollo:
* Git
* [Herramienta o SDK según la tecnología elegida]

### Pasos para ejecutar el proyecto

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com
   ```

2. **Acceder al directorio del proyecto:**
   ```bash
   cd FincaControl
   ```

3. **Instalar dependencias:**
   ```bash
   # Cambia este comando según el framework (ej: npm install, flutter pub get, etc.)
   [comando_de_instalacion]
   ```

4. **Ejecutar la aplicación:**
   ```bash
   [comando_para_ejecutar]
   ```
<<<<<<< HEAD

---

## 📘 Guía de Usuario Orientada a Procesos y Verificación del Prototipo
El proyecto incluye la **[Guía de Usuario Paso a Paso (`GUIA_DE_USUARIO.md`)](./GUIA_DE_USUARIO.md)** diseñada tanto para el cliente/productor como para los agentes de verificación sobre el **[Prototipo Interactivo (`agentes/prototipo/index.html`)](./agentes/prototipo/index.html)**:

0. **Esquema de Procesos Soportados por el Sistema:** Mapa arquitectónico y flujo secuencial de extremo a extremo mostrado antes de cualquier funcionalidad.
1. **(1) Configuración del Sistema:** Identidad de la finca, descripción del *Hierro* oficial por defecto, catálogo extensible de razas, parámetros comerciales/zootécnicos, roles RBAC y motor *Offline-First*.
2. **(2) Carga Inicial del Inventario de Animales:** Registro separando `N° Identificador` único vs. `Hierro` descriptivo (propietario/procedencia), selección o alta de razas personalizadas, clasificación por condiciones fisiológicas venezolanas (*Becerro/a, Maute/a, Novillo/Novilla, Toro Reproductor, Vaca parida, Vaca escotera, Vaca seca*), estado `¿Está Preñada?` y genealogía por `N° Identificador`.
3. **(3) Proceso de Producción de Carne:** Pesajes periódicos en báscula, cálculo automático de Ganancia Diaria de Peso (`GDP`), control de tiempos de retiro en carne, liquidación/beneficio en canal, liberación del `N° Identificador` y asiento financiero automático.
4. **(4) Proceso de Producción de Leche:** Ciclo reproductivo y parto (con alta automática de cría vinculada al `N° Identificador` de la madre y transición a *Vaca parida*), ordeño diario (Mañana/Tarde) con bloqueo por retiro sanitario en leche, gestión de inventario en tanque de enfriamiento, despacho comercial y cálculo de costo directo por litro.

=======
>>>>>>> origin/Jose
