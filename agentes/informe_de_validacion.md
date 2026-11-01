# Informe de Validación: Prototipo vs. Guía de Usuario

## 1. Información General y Control de Versiones
* **Proyecto:** FincaControl – Sistema Integral de Gestión Ganadera para Fincas de Doble Propósito (Leche y Carne)
* **Equipo de Desarrollo:** Johan Maldonado – José Chacón
* **Fecha de ejecución:** 01/11/2026
* **Versión del Prototipo:** v3.0-propuesta-a-online-offline-audit (`agentes/prototipo/index.html`)
* **Versión de la Guía:** Manual de Usuario Orientado a Procesos Rev 3.0 (`GUIA_DE_USUARIO.md` / `GUIA_DE_USUARIO.pdf`)

---

## 2. Alcance y Objetivos
El presente informe documenta la inspección técnica y funcional paso a paso ejecutada sobre el prototipo interactivo de **FincaControl** ([`agentes/prototipo/index.html`](./agentes/prototipo/index.html)) contrastándolo contra las instrucciones operativas de la **Guía de Usuario Orientada a Procesos Rev 3.0** ([`GUIA_DE_USUARIO.md`](./GUIA_DE_USUARIO.md)). La validación abarca el esquema general de procesos (Sección 0), los cuatro macroprocesos troncales —**(1) Configuración del Sistema (Admin Online)**, **(2) Carga Inicial del Inventario de Animales (N° Identificador vs. Hierro, Condiciones Fisiológicas Venezolanas, Preñez, Genealogía y Regla de Altas)**, **(3) Producción de Carne (Pesajes, Cálculo de GDP, Retiro en Carne y Venta en Canal con Liberación de N° Identificador)** y **(4) Producción de Leche (Ciclo Reproductivo, Secado, Parto con Alta Automática de Cría, Ordeño Diario con Filtro de Inocuidad y Venta desde Tanque)**— y la Sección 5 correspondiente a la **Experiencia Dual por Rol (Propuesta A: `📱 Terminal de Carga` para el Trabajador vs. `📊 Vista Rápida (Admin)`)**, la arquitectura **Primero Online + Cola Offline Táctica de Campo** y la bitácora inmutable **`📜 Historial de Acciones`**, con el objetivo de certificar la fidelidad 1:1 entre manual, prototipo, historias de usuario y modelo de base de datos antes de iniciar el desarrollo en Flutter.

---

## 3. Metodología Aplicada
* **Tipo de prueba:** Inspección técnica paso a paso (*Walkthrough funcional e inspección de DOM/JS en ejecución headless y navegador*) y pruebas operativas con datos representativos del hato venezolano en escenarios `En Línea` y `Sin Señal`, alternando ambos perfiles de usuario.
* **Entorno de prueba:**
  * **Navegador Web:** Google Chrome / Motor Chromium Headless (`1920x1080 px` escritorio y `412x915 px` vista móvil táctil con controles de `48px+`).
  * **Persistencia Simulada en Prototipo:** Estado reactivo central + `localStorage` (`fincacontrol_config_finca`, `fincacontrol_catalogo_razas`, `fincacontrol_cola_offline_v1`, `fincacontrol_historial_v1`) emulando la relación entre la Base de Datos Relacional Central y las 3 tablas SQLite ligeras del teléfono de campo.
* **Escenarios o tareas evaluadas:**
  1. Apertura del **Esquema General de Procesos** y verificación de rutas directas hacia los 4 procesos.
  2. Parametrización Online del **Hierro Oficial**, **Catálogo Maestro de Razas** y parámetros comerciales por el `Administrador`.
  3. Alternancia de interfaz por rol (**Propuesta A**: `Administrador` ↔ `Trabajador`), comprobando el ocultamiento efectivo de pestañas y botones exclusivos del Administrador cuando opera el `Trabajador`.
  4. Carga manual de animales (exclusiva `Admin Online`) verificando separación entre **N° Identificador único** e **Hierro descriptivo**, condiciones fisiológicas venezolanas, preñez condicional y genealogía por N° Identificador.
  5. Operación de la **`📱 Terminal de Carga`** del Trabajador (4 botones gigantes + buscador instantáneo de corral por N° Identificador con semáforo sanitario) tanto `En Línea` como `Sin Señal (Modo Campo)`.
  6. Encolamiento FIFO en la **Cola Offline de Campo** durante pérdida de señal, bloqueo preventivo de operaciones comerciales/administrativas sin internet y sincronización al reconectar.
  7. Pesajes con cálculo de **GDP**, cuarentena por **Tiempos de Retiro**, **Venta en Canal** (`Peso Vivo × Precio/Kg`) con liberación del N° Identificador, **Parto** con alta automática del becerro/a, **Ordeño Diario** con desvío a descarte y **Despacho de Tanque**.
  8. Auditoría transversal en **`📜 Historial de Acciones`** (inmutabilidad, filtros por Rol/Módulo/Origen/Texto y doble marca de tiempo: hora real de campo + hora servidor).

### Criterios de Estado para el Dictamen
* **✔️ Conforme (Aprobado):** La acción descrita en la guía coincide 1:1 con el comportamiento, nombres de controles y retroalimentación del prototipo.
* **⚠️ Observado (Discrepancia menor):** Diferencias de texto, capturas desactualizadas o elementos cosméticos que no impiden completar la tarea.
* **❌ No concuerda / No conforme (Bloqueante / Crítico):** Pasos de la guía que son imposibles de seguir en el prototipo, flujos rotos o contradicciones directas en las reglas de validación.

---

## 4. Matriz de Validación (Núcleo del Documento)

| ID | Módulo / Tarea | Procedimiento según Guía | Respuesta del Prototipo | Estado | Tipo de Discrepancia | Acción Correctiva |
| :---: | :--- | :--- | :--- | :---: | :--- | :--- |
| **VAL-01** | **0. Esquema General de Procesos** | Visualizar al iniciar como Administrador el mapa secuencial (`1. Configuración ➔ 2. Inventario ➔ 3. Carne ➔ 4. Leche`) y navegar con un clic a cada proceso. | La vista inicial activa es `🗺️ Esquema de Procesos` (`#view-procesos`), mostrando el diagrama interactivo y las 4 tarjetas con botones directos de navegación que activan cada módulo. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-02** | **1.1 Configuración: Identidad y Hierro Oficial** | En `⚙️ 1. Configuración`, panel *"Parámetros Generales de la Finca"*, ingresar *"Nombre de la Finca / Hato \*"* y *"Hierro Oficial Predeterminado \*"*, y pulsar *"Guardar Configuración del Sistema"*. | Coincide 1:1 con los títulos y etiquetas del formulario `#form-config-sistema`. Al guardar en línea, actualiza el encabezado global, prellena el hierro en Censo/Parto y audita el cambio. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-03** | **1.2 Configuración: Catálogo Maestro de Razas** | En `🧬 1.2 Catálogo Maestro de Razas Bovinas` pulsar `+ Agregar Nueva Raza`, escribir el nombre y pulsar *"Guardar Raza en Catálogo"*. | El modal `#modal-nueva-raza` valida duplicados sin distinción de mayúsculas, guarda la raza, actualiza chips y desplegables, y audita la creación en `#historial-tbody`. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-04** | **1.3 Configuración: Parámetros Comerciales y Estándares Zootécnicos** | Configurar Capacidad Tanque (`L`), Precio Ref. Leche (`$ / L`), Precio Ref. Carne Pie (`$ / Kg`) y Meta GDP (`kg/día`), indicando que 283 días de gestación y 60 días de secado vienen preconfigurados. | El formulario edita y persiste los 4 parámetros comerciales/productivos precargándolos en los modales de venta, mientras el módulo Reproducción exhibe los estándares preconfigurados de 283 y 60 días. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-05** | **0.3 / 1.3 Propuesta A: Adaptación de Interfaz por Rol** | Alternar entre `👤 Rol: Administrador (Vista Rápida)` y `👷 Rol: Trabajador (Terminal de Carga)`. En modo Trabajador deben ocultarse Configuración, Finanzas, Historial, altas manuales, nueva raza y ventas. | `aplicarExperienciaPorRol()` oculta inmediatamente las pestañas `[data-role="admin"]` y todos los controles `.admin-only-control`, redirigiendo al trabajador a `📱 Terminal de Carga`. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-06** | **2.1 Inventario: N° Identificador vs. Hierro y Regla de Altas** | Con `Admin` en línea, pulsar `+ Nuevo Animal Manual` e ingresar `N° Identificador *` único en activos y `Hierro (Descripción) *`. Verificar que el `Trabajador` no disponga de alta manual. | `handleCrearAnimal()` exige conexión Online, bloquea N° Identificadores duplicados en activos, separa el badge de Hierro y oculta `+ Nuevo Animal Manual` cuando el rol activo es `Trabajador`. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-07** | **2.2 Inventario: Condiciones Fisiológicas (VZLA) y Preñez** | Consultar `📖 Clasificación Fisiológica (VZLA)`. Al seleccionar `Sexo`, filtrar etapas válidas y habilitar `¿Está Preñada?` solo en hembras aptas (`Preñada: Sí` automático en escotera y seca). | Despliega `#panel-guia-etapas`, filtra opciones masculinas/femeninas dinámicamente, bloquea `¿Está Preñada?` en machos y crías, y fija `🤰 Sí (Preñada)` en *Vaca escotera* y *Vaca seca*. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-08** | **2.3 Inventario: Genealogía por N° ID, Filtros y Hoja de Vida** | Vincular `Madre` y `Padre` por su **N° Identificador**, filtrar por Etapa o Preñez y abrir `"Hoja de Vida"`. | Filtra el padrón en tiempo real con `#filtro-censo-etapa` y `#filtro-censo-prenez`, y `#modal-hoja-vida` muestra el árbol genealógico referenciado por `#ID_Numero`. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-09** | **3.2 Producción Carne: Pesajes Periódicos y Cálculo de GDP** | En `⚖️ 3. Producción Carne`, elegir `Animal (N° Identificador) *`, `Fecha de Pesaje *` y `Peso Actual (Kg) *`, y presionar *"Calcular GDP y Guardar"*. | Coincide exactamente con la etiqueta del botón `"Calcular GDP y Guardar"`, calcula `(Peso Actual - Peso Previo) / Días`, aplica semáforo (`≥0.60`, `0.30-0.59`, `<0.30`) y actualiza el peso del animal. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-10** | **3.3 Producción Carne: Control de Retiro Sanitario** | En `🩺 Sanidad & Retiro`, elegir animal por N° ID, producto y días de retiro, y pulsar *"Guardar Tratamiento y Activar Cuarentena"*. | Incorpora al animal en `animalesEnRetiro`, actualiza KPIs y semáforos rojos de inmediato (tanto Online como en caché local si está Sin Señal) y bloquea leche comercial y venta en canal. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-11** | **3.4 Producción Carne: Venta en Canal y Liberación de N° ID** | Con `Admin` en línea, pulsar `🥩 Vender en Canal`, validar ausencia de retiro, confirmar `Peso Vivo en Báscula (Kg)`, `Precio por Kg ($)` y `Destino`, y confirmar venta. | Bloquea animales en retiro (`#104`); en animales aptos (`#201`) calcula `Peso Vivo × Precio/Kg` (sin campos superfluos), archiva en `🥩 Historial Canal & Ventas`, **libera el N° Identificador**, suma ingreso en `💰 Financiero` y audita. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-12** | **4.2 Producción Leche: Preñez, Secado y Parto (Alta de Cría)** | En `🧬 Reproducción`, registrar `Diagnóstico Preñez`, `Secado de Vaca` y `Parto (Nacimiento de Cría)` completando la ficha del recién nacido vinculada al N° ID de la madre. | Habilitado para `Trabajador` y `Admin` (Online y Offline). En `Parto` despliega `#panel-parto-completo`, da de alta al `Becerro/a` con `madre = N° ID`, reutiliza números liberados y pasa a la madre a `Vaca parida` (`Preñada: No`). | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-13** | **4.3 Producción Leche: Ordeño Diario y Filtro de Inocuidad** | En `🥛 4. Producción Leche`, seleccionar `Vaca (N° ID)`, `Jornada` y `Litros Medidos`, y pulsar *"Registrar Ordeño"*. | Si la vaca tiene retiro activo (`#104`), exhibe `#ordeno-warning` y envía los litros a `⚠️ Descarte por Retiro`. Si está sana (`#042`), suma los litros a `🥛 Leche Disponible en Tanque`. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-14** | **4.4 Producción Leche: Tanque, Despacho y Costo por Litro** | Con `Admin` en línea, pulsar `🥛 Vender / Despachar Leche`, ingresar litros (≤ saldo en tanque), precio (`$/L`) y comprador, y pulsar *"Confirmar Venta y Descargar Tanque"*. | Valida stock disponible en tanque, descuenta litros vendidos, registra el ingreso automático en `💰 Financiero`, recalcula utilidad y costo directo por litro (`$/L`) y registra auditoría. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-15** | **5.1 Terminal de Carga del Trabajador y Buscador en Corral** | En modo `Trabajador`, usar las 4 tarjetas grandes de `📱 Terminal de Carga` y escribir un N° Identificador (ej. `104`, `042`) en el buscador rápido de corral. | `#view-campo` presenta las 4 tarjetas táctiles gigantes y `buscarAnimalRapidoCampo()` devuelve instantáneamente etapa, preñez, peso y badge `🚨 EN RETIRO SANITARIO ACTIVO` o `✅ Libre de Retiro`. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-16** | **0.3 / 5.1 Guardas de Operaciones Exclusivas Online** | Cambiar conectividad a `Sin Señal (Modo Campo)` e intentar guardar Configuración, Nueva Raza, Alta Manual, Venta de Leche, Venta en Canal o Transacción Financiera. | `validarOperacionExclusivaOnline()` intercepta la acción, impide mutaciones sin conexión sobre operaciones maestras/comerciales y muestra notificación clara solicitando reconectar al Servidor Central. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-17** | **5.1 Cola Offline FIFO de Campo y Sincronización** | En modo `Sin Señal`, registrar un ordeño o pesaje, verificar su ingreso al buzón local y luego reconectar / pulsar `🔄 Enviar Cola al Servidor`. | `encolarOperacionCampo()` guarda el evento con su hora real de captura en `#campo-cola-tbody` y actualiza `#btn-sync-queue`. Al reconectar o sincronizar, `sincronizarColaOffline()` procesa la cola en orden FIFO y la vacía. | ✔️ Conforme | Ninguna | Ninguna |
| **VAL-18** | **5.2 Vista Rápida (Admin) e Historial Inmutable de Acciones** | Con `Admin`, revisar resumen reciente en `📊 Vista Rápida (Admin)` y abrir `📜 Historial de Acciones`, probando filtros por Rol, Módulo, Origen (`Online` / `Offline sincronizado`) y texto. | `#dash-audit-tbody` lista las últimas 4 acciones y `#view-historial` muestra los 4 KPIs de conteo, filtra en vivo sin botones de edición/borrado (inmutable) y exhibe **hora real de campo + hora servidor** en eventos offline. | ✔️ Conforme | Ninguna | Ninguna |

---

## 5. Análisis de Hallazgos y Clasificación

Resumen cuantitativo y cualitativo de los **18 escenarios evaluados** en la Matriz de Validación:

* **Total de escenarios evaluados:** 18 casos (100% de cobertura de la Guía de Usuario Rev 3.0 y las 20 Historias de Usuario).
  * **✔️ Conformes (Aprobados 1:1):** **18 casos (100.0%)**
  * **⚠️ Observados (Discrepancias menores):** **0 casos (0.0%)**
  * **❌ No concuerda / No conformes (Bloqueantes / Críticos):** **0 casos (0.0%)**

### Resumen por Categoría de Discrepancia y Cierre de Iteración Previa:
* **Errores de Documentación:** **0 casos** *(se homologaron en la Guía Rev 3.0 las etiquetas exactas `"Parámetros Generales de la Finca"`, `"Calcular GDP y Guardar"` y la nota sobre los estándares preconfigurados de 283 días de gestación y 60 días de secado observadas en la Rev 2.1)*.
* **Errores de Interfaz / UX:** **0 casos** *(se implementó en el prototipo v3.0 el ocultamiento real de pestañas y controles administrativos al activar el perfil `Trabajador` bajo la Propuesta A, eliminando la observación de RBAC previa, además de suprimir anteriormente el campo innecesario de Rendimiento Canal %)*.
* **Brechas Funcionales / Reglas de Negocio:** **0 casos**. Todas las reglas del dominio ganadero venezolano, el esquema **Primero Online + Cola Offline de Campo**, la gobernanza de altas de animales y la bitácora inmutable **`📜 Historial de Acciones`** operan en completa concordancia entre prototipo, manual y modelo de datos.

---

## 6. Plan de Acción y Conclusiones

### Acciones Prioritarias para la Siguiente Fase (Diseño Técnico y Construcción)
1. **Selección de Plataforma para Backend y Base de Datos Central:** Con el modelo lógico relacional de **12 tablas centrales** y el contrato de API REST ya cerrados de forma agnóstica en [`modelo_base_de_datos.md`](./modelo_base_de_datos.md), proceder en la siguiente etapa a elegir el motor SQL relacional y entorno de despliegue del servidor.
2. **Construcción de la App Móvil en Flutter (Propuesta A + 3 Tablas SQLite Móviles):** Implementar las vistas adaptativas por rol (`Vista Rápida + Control + Historial` para `ADMIN` y `Terminal de Carga` para `OPERADOR`) apoyadas únicamente en las 3 tablas locales ligeras (`cache_padron_activo`, `cache_referencia_resumen`, `cola_envios_campo`).
3. **Garantía de Inmutabilidad en `historial_acciones`:** Asegurar en la capa de datos del servidor que la tabla de auditoría revoque permisos de `UPDATE` y `DELETE`, permitiendo exclusivamente inserciones transaccionales junto con cada operación de negocio.

### Dictamen y Aprobación
* **Dictamen:** **✔️ APROBADO (100% Conforme – Listo para Fase de Implementación)**
* **Firmas / Conformidad del Equipo de Análisis y Desarrollo:**
  * **Johan Maldonado** — *Co-Autor / Análisis y Arquitectura FincaControl*
  * **José Chacón** — *Co-Autor / Análisis y Arquitectura FincaControl*
