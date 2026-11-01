# FincaControl 🚜🐄

**FincaControl** es una solución de software móvil diseñada para la gestión ganadera integral en fincas de doble propósito (producción de leche y carne). Permite a los pequeños y medianos productores pasar de cuadernos físicos a un sistema digital centralizado con una interfaz adaptada a cada rol: **Terminal Ligera de Carga en Campo** para el trabajador y **Vista Rápida Ejecutiva + Control Online + Historial Inmutable de Auditoría** para el Administrador.

---

## 👥 Equipo de Trabajo (Grupo 3)
* **Johan Maldonado**
* **José Chacón**

---

## 🔴 El Problema
En las fincas productoras comúnmente se carece de mecanismos formales y ágiles para llevar una trazabilidad ordenada del ganado, la producción y las acciones del personal. La dependencia de registros físicos (papel o libretas) dificulta la consulta rápida por parte del propietario, expone a riesgos sanitarios por falta de control de tiempos de retiro y provoca extravíos o errores de transcripción.

## 🟢 Nuestra Solución (Arquitectura Primero Online + Extensión Offline de Campo y Propuesta A)
Ofrecemos **una sola aplicación móvil en Flutter** que adapta su experiencia según el rol (**Propuesta A**) sobre un núcleo **Primero Online** (Base de Datos Relacional Central como Fuente Única de Verdad) complementado con una **Extensión Offline Táctica de Campo** (caché ligera y cola FIFO en SQLite móvil) para capturar ordeños, pesajes, sanidad y partos en vaqueras sin señal y sincronizarlos en cuanto regrese la cobertura.

---

## 🎯 Características Principales (Alcance)

### Dentro del Alcance 📋
* **Propuesta A — Experiencia Dual por Rol:**
  * **Trabajador (`📱 Terminal de Carga`):** 4 tarjetas táctiles grandes (*Ordeño, Pesaje, Sanidad, Reproducción/Parto*), buscador instantáneo de corral por `N° Identificador` con semáforo sanitario y buzón local de cola offline.
  * **Administrador (`📊 Vista Rápida` + Control Online + `📜 Historial de Acciones`):** Lectura ejecutiva inmediata de tanque, rebaño, alertas y caja, gobierno de operaciones maestras/comerciales en línea y auditoría total.
* **Gestión de Inventario, Condiciones Fisiológicas y Genealogía:** Registro separando **Número Identificador** único en activos vs. **Hierro** descriptivo (propietario y procedencia), catálogo maestro extensible de **razas**, clasificación por **condiciones fisiológicas venezolanas** (*Becerro/a, Maute/a, Novillo/Novilla, Toro Reproductor, Vaca parida, Vaca escotera, Vaca seca*), estado de **preñez** condicional y genealogía por `N° Identificador`. *(Altas manuales/compras exclusivas del Administrador Online; en campo solo se incorporan crías nacidas en un **Parto**).*
* **Control de Producción (Leche y Carne):** Ordeño diario (Mañana/Tarde) con desvío automático a descarte por retiro activo, gestión y despacho Online del tanque de enfriamiento, pesajes periódicos con cálculo automático de `GDP` y venta en canal Online con liberación del `N° Identificador`.
* **Módulo Financiero Operativo (Online):** Libro de caja con ingresos automáticos por venta de leche/canal, registro de egresos y cálculo del costo directo por litro de leche (`$/L`).
* **Historial General Inmutable de Acciones (`📜 Historial de Acciones`):** Bitácora *append-only* exclusiva para el Administrador que audita todo cambio realizado por Administrador o Trabajador (Online u Offline sincronizado), conservando tanto la hora real de captura en campo como la hora de recepción en servidor.

### Fuera de Alcance 🚫
* Contabilidad fiscal compleja (facturación electrónica tributaria avanzada).
* Marketplace público o comercio electrónico abierto a terceros.
* Soporte para otras especies agropecuarias (diseñado exclusivamente para ganado bovino de doble propósito).

---

## 🛠️ Definición Arquitectónica y Tecnológica
* **Frontend Móvil (Cross-Platform):** **Flutter (Dart 3+)** con arquitectura en capas y controles táctiles ergonómicos (`>= 48px`) para uso bajo luz solar en corral.
* **Base de Datos Relacional Central y API Lógica (Primero Online):** Esquema relacional estándar SQL de **12 tablas** + contrato lógico **API REST (`/api/v1`)** *(tecnología de backend e infraestructura de despliegue a definir en fase posterior)*.
* **Persistencia Local Táctica en el Móvil (Extensión Offline de Campo):** **SQLite** ligero de **3 tablas** (`cache_padron_activo`, `cache_referencia_resumen` y `cola_envios_campo` FIFO) exclusivamente para consulta rápida en corral y encolamiento de capturas de campo sin señal.

---

## 📂 Documentación Técnica y Entregables de Análisis
* 🗄️ **[Modelo Formal de Base de Datos Relacional Central, SQLite Móvil y API Lógica (`modelo_base_de_datos.md`)](./modelo_base_de_datos.md)**
* 📘 **[Guía de Usuario Orientada a Procesos (`GUIA_DE_USUARIO.md`)](./GUIA_DE_USUARIO.md)** y **[Versión Ejecutiva en PDF (`GUIA_DE_USUARIO.pdf`)](./GUIA_DE_USUARIO.pdf)**
* ✅ **[Informe de Validación: Prototipo vs. Guía de Usuario (`informe_de_validacion.md`)](./informe_de_validacion.md)**
* 📋 **[Historias de Usuario y Criterios de Aceptación BDD (`historias_de_usuario.md`)](./historias_de_usuario.md)**
* 🗂️ **[Planificación de Módulos y Roadmap (`PLANIFICACION_MODULOS.md`)](./PLANIFICACION_MODULOS.md)**
* 📖 **[Manual de Especificación de Módulos (`agentes/DOCUMENTACION_MODULOS.md`)](./agentes/DOCUMENTACION_MODULOS.md)**
* 🔄 **[Skill de Arquitectura Primero Online + Extensión Offline de Campo (`.agents/skills/fincacontrol-offline-sync/SKILL.md`)](./.agents/skills/fincacontrol-offline-sync/SKILL.md)**
* 🖥️ **[Prototipo Interactivo Verificable (`agentes/prototipo/index.html`)](./agentes/prototipo/index.html)**

---

## 🚀 Verificación Rápida del Prototipo Interactivo
Abra [`agentes/prototipo/index.html`](./agentes/prototipo/index.html) en cualquier navegador moderno (Chrome / Edge) para probar en vivo:
1. **Alternancia de Rol (Propuesta A):** Haga clic en el badge superior `👤 Rol: Administrador (Vista Rápida)` para cambiar a `👷 Rol: Trabajador (Terminal de Carga)` y comprobar cómo se adapta toda la interfaz.
2. **Simulación de Campo Sin Señal y Cola FIFO:** Haga clic en `En Línea (Servidor Central)` para pasar a `Sin Señal (Modo Campo)`, registre un ordeño o pesaje como Trabajador, observe el buzón local y reconecte para sincronizar.
3. **Auditoría Inmutable:** Con rol `Administrador`, abra `📜 Historial de Acciones` para filtrar y auditar todas las operaciones realizadas por ambos roles con sus marcas de tiempo de campo y servidor.
