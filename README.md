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
* **Gestión de Inventario, Condiciones Fisiológicas y Genealogía:** Registro detallado de animales separando el **Número Identificador** individual de la marca descriptiva del **Hierro** (propietario y procedencia), catálogo extensible de **razas** (predeterminadas y personalizadas), clasificación por **condiciones fisiológicas** (*Becerro/a, Maute/a, Novillo/Novilla, Toro Reproductor, Vaca parida, Vaca escotera, Vaca seca*), estado de **preñez** e historial genealógico referenciado por el número identificador.
* **Control de Producción:** Módulos específicos para el registro diario de ordeño (con gestión de tanque de leche) y pesajes periódicos con cálculo de GDP.
* **Gestión Sanitaria y Reproductiva:** Calendarios de vacunación, seguimiento de servicios, gestaciones, secados, partos (con alta automática de crías) y tiempos de retiro de medicamentos.
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
* **Frontend Móvil (Cross-Platform):** **Flutter (Dart 3+)** con arquitectura limpia en capas y controles táctiles ergonómicos para uso en corral.
* **Base de Datos Local (Offline-First en el Móvil):** **SQLite** (`sqflite` / `drift`), donde el trabajador registra toda su jornada de campo sin conexión a internet y encola los cambios en `sync_queue`.
* **Backend / API y Base de Datos Remota:** **API RESTful (`/api/v1`)** con autenticación JWT y sincronización Delta (`push` / `pull`) conectada a una base de datos relacional central (**PostgreSQL** en plataforma cloud a definir), permitiendo que cuando el trabajador tenga conexión a internet la información se actualice automáticamente para que el **Administrador** pueda visualizarla en tiempo real.

---

## 📂 Documentación Técnica y Entregables de Análisis
* 📘 **[Guía de Usuario Orientada a Procesos (`GUIA_DE_USUARIO.md`)](./GUIA_DE_USUARIO.md)** y **[Versión Ejecutiva en PDF (`GUIA_DE_USUARIO.pdf`)](./GUIA_DE_USUARIO.pdf)**
* ✅ **[Informe de Validación: Prototipo vs. Guía de Usuario (`informe_de_validacion.md`)](./informe_de_validacion.md)**
* 📋 **[Historias de Usuario y Criterios de Aceptación BDD (`historias_de_usuario.md`)](./historias_de_usuario.md)**
* 🗂️ **[Planificación de Módulos, Modelo de Base de Datos SQLite y Endpoints API (`PLANIFICACION_MODULOS.md`)](./PLANIFICACION_MODULOS.md)**
* 📖 **[Manual de Especificación de Módulos (`agentes/DOCUMENTACION_MODULOS.md`)](./agentes/DOCUMENTACION_MODULOS.md)**
* 🔄 **[Skill de Arquitectura Offline-First Flutter + SQLite & Sync (`.agents/skills/fincacontrol-offline-sync/SKILL.md`)](./.agents/skills/fincacontrol-offline-sync/SKILL.md)**
* 🖥️ **[Prototipo Interactivo Verificable (`agentes/prototipo/index.html`)](./agentes/prototipo/index.html)**

---

## 🚀 Instalación y Configuración Local

### Prerrequisitos
Asegúrate de tener instalado lo siguiente en tu entorno de desarrollo:
* Git
* Flutter SDK (v3.x+) y Android Studio / VS Code

### Pasos para ejecutar el proyecto

1. **Clonar el repositorio:**
   ```bash
   git clone https://github.com
   ```

2. **Acceder al directorio del proyecto:**
   ```bash
   cd FincaControl
   ```

3. **Instalar dependencias de Flutter:**
   ```bash
   flutter pub get
   ```

4. **Ejecutar la aplicación móvil (o abrir `agentes/prototipo/index.html` en el navegador):**
   ```bash
   flutter run
   ```

---

## 📘 Guía de Usuario Orientada a Procesos y Verificación del Prototipo
El proyecto incluye la **[Guía de Usuario Paso a Paso (`GUIA_DE_USUARIO.md`)](./GUIA_DE_USUARIO.md)** diseñada tanto para el cliente/productor como para los agentes de verificación sobre el **[Prototipo Interactivo (`agentes/prototipo/index.html`)](./agentes/prototipo/index.html)**:

0. **Esquema de Procesos Soportados por el Sistema:** Mapa arquitectónico y flujo secuencial de extremo a extremo mostrado antes de cualquier funcionalidad.
1. **(1) Configuración del Sistema:** Identidad de la finca, descripción del *Hierro* oficial por defecto, catálogo extensible de razas, parámetros comerciales/zootécnicos, roles RBAC y motor *Offline-First*.
2. **(2) Carga Inicial del Inventario de Animales:** Registro separando `N° Identificador` único vs. `Hierro` descriptivo (propietario/procedencia), selección o alta de razas personalizadas, clasificación por condiciones fisiológicas venezolanas (*Becerro/a, Maute/a, Novillo/Novilla, Toro Reproductor, Vaca parida, Vaca escotera, Vaca seca*), estado `¿Está Preñada?` y genealogía por `N° Identificador`.
3. **(3) Proceso de Producción de Carne:** Pesajes periódicos en báscula, cálculo automático de Ganancia Diaria de Peso (`GDP`), control de tiempos de retiro en carne, liquidación/beneficio en canal, liberación del `N° Identificador` y asiento financiero automático.
4. **(4) Proceso de Producción de Leche:** Ciclo reproductivo y parto (con alta automática de cría vinculada al `N° Identificador` de la madre y transición a *Vaca parida*), ordeño diario (Mañana/Tarde) con bloqueo por retiro sanitario en leche, gestión de inventario en tanque de enfriamiento, despacho comercial y cálculo de costo directo por litro.
