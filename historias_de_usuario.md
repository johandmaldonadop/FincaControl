# 📋 Especificación Técnica de Historias de Usuario: FincaControl
> **Sistema Integral de Gestión Ganadera para Fincas de Doble Propósito (Leche y Carne)**  
> **Equipo de Desarrollo:** Johan Maldonado – José Chacón  
> **Stack Tecnológico:** Flutter (App Móvil) + SQLite Local (*Offline-First*) + API REST Backend & Base de Datos Central  
> **Metodología:** Plantilla Clásica Ágil (*Quién, Qué, Para qué*) + Las 3 "C" de Ron Jeffries (*Card, Conversation, Confirmation*) + Criterios de Aceptación BDD (*Gherkin: Dado que / Cuando / Entonces*)

---

## 📑 Índice de Historias de Usuario por Proceso

Todas las historias de usuario del sistema se consolidan en la sección única de catálogo técnico (ver abajo) mediante fichas numeradas de la **`HU-01`** a la **`HU-18`**:

* **Módulo / Proceso 0 y 1: Arquitectura Offline-First, Sincronización, Seguridad y Configuración**
  * [**HU-01:** Visualización del Esquema General de Procesos del Sistema](#hu-01)
  * [**HU-02:** Configuración de Identidad de la Finca y Hierro Oficial Predeterminado](#hu-02)
  * [**HU-03:** Gestión del Catálogo Extensible y Persistente de Razas Bovinas](#hu-03)
  * [**HU-04:** Parametrización Comercial, Zootécnica y Control de Acceso por Roles (RBAC)](#hu-04)
  * [**HU-05:** Persistencia Local Offline-First (SQLite en Flutter) y Sincronización Delta con Backend API](#hu-05)
* **Módulo / Proceso 2: Carga Inicial del Inventario de Animales (Censo, Etapas y Genealogía)**
  * [**HU-06:** Alta de Bovinos Separando N° Identificador Único (`id_numero`) y Hierro (`hierro`)](#hu-06)
  * [**HU-07:** Clasificación por Condiciones Fisiológicas Venezolanas y Estado de Preñez Condicional](#hu-07)
  * [**HU-08:** Registro de Genealogía por N° Identificador y Consulta de Hoja de Vida Individual](#hu-08)
  * [**HU-09:** Búsqueda y Filtrado Multicriterio del Censo por Etapa Fisiológica y Preñez](#hu-09)
* **Módulo / Proceso 3: Registro de Datos del Proceso de Producción de Carne**
  * [**HU-10:** Registro de Pesajes Periódicos en Báscula y Cálculo Automático de GDP (`kg/día`)](#hu-10)
  * [**HU-11:** Registro de Tratamientos Sanitarios y Activación de Tiempos de Retiro (Carne y Leche)](#hu-11)
  * [**HU-12:** Liquidación de Venta en Canal, Bloqueo Sanitario y Liberación del N° Identificador](#hu-12)
* **Módulo / Proceso 4: Registro de Datos del Proceso de Producción de Leche**
  * [**HU-13:** Registro de Eventos Reproductivos, Diagnóstico de Preñez y Secado de Vacas](#hu-13)
  * [**HU-14:** Registro de Parto con Alta Automática del Becerro/a y Pase de Madre a Vaca Parida](#hu-14)
  * [**HU-15:** Registro de Ordeño Diario (Mañana/Tarde) con Filtro Sanitario de Inocuidad](#hu-15)
  * [**HU-16:** Gestión del Tanque de Enfriamiento y Despacho / Venta Comercial de Leche](#hu-16)
* **Módulos Transversales: Financiero Operativo y Tablero Gerencial (Dashboard)**
  * [**HU-17:** Registro de Transacciones Financieras, Flujo de Caja y Costo Directo por Litro (`$/L`)](#hu-17)
  * [**HU-18:** Tablero de Control Operativo (Dashboard), KPIs en Tiempo Real y Semáforo de Alertas](#hu-18)

---

## 🗂️ Catálogo Único de Historias de Usuario (Fichas Técnicas HU-01 a HU-18)

<a id="hu-01"></a>
### 🏷️ Ficha HU-01: Visualización del Esquema General de Procesos del Sistema

#### 1. Card (Tarjeta)
* **ID:** `HU-01`
* **Título:** Mapa interactivo del esquema de procesos soportados por FincaControl.
* **Prioridad:** Alta | **Estimación:** 3 Puntos | **Proceso:** 0. Esquema de Procesos
* **Enunciado Clásico:**
  * **Como** usuario nuevo (Administrador u Operador de la finca),
  * **quiero** visualizar al abrir la aplicación un esquema claro de los procesos soportados en su orden lógico (*1. Configuración ➔ 2. Inventario ➔ 3. Producción Carne ➔ 4. Producción Leche*),
  * **para** comprender el flujo operativo del software y navegar directamente al paso que necesito ejecutar.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Contexto de Negocio:** Antes de mostrar formularios aislados, el sistema debe guiar al productor ganadero mostrando cómo la parametrización de la finca y el censo inicial habilitan los procesos diarios de carne y leche.
* **Detalles Técnicos (Flutter):**
  * Pantalla inicial (`ProcessSchemaScreen`) renderizada como primera pestaña activa al iniciar la app.
  * Contiene un diagrama de flujo interactivo superior (`Stepper` / tarjetas conectadas) y 4 tarjetas de detalle con botón de navegación directa (`Navigator` / cambio de índice en `TabController`) más accesos rápidos a los módulos transversales (*Sanidad, Reproducción, Finanzas y Dashboard*).

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Apertura inicial del sistema**
  * **Dado que** el usuario abre la aplicación FincaControl en su dispositivo móvil o navegador,
  * **Cuando** se carga la pantalla principal sin haber seleccionado otra pestaña,
  * **Entonces** el sistema muestra activa la vista `"🗺️ Esquema de Procesos"` con la secuencia numerada del Paso 1 al Paso 4.
* **Escenario 2: Navegación directa desde una tarjeta de proceso**
  * **Dado que** el usuario se encuentra en la vista `"🗺️ Esquema de Procesos"`,
  * **Cuando** presiona el botón `"Ir al Proceso 1: Configuración del Sistema ➔"` (o cualquiera de los nodos de los Procesos 1, 2, 3 o 4),
  * **Entonces** el sistema cambia inmediatamente a la pestaña del módulo correspondiente y resalta su indicador activo en la barra de navegación.

---

<a id="hu-02"></a>
### 🏷️ Ficha HU-02: Configuración de Identidad de la Finca y Hierro Oficial Predeterminado

#### 1. Card (Tarjeta)
* **ID:** `HU-02`
* **Título:** Parametrización de los datos maestros del hato y marca de Hierro Oficial.
* **Prioridad:** Alta (Bloqueante Fase 1) | **Estimación:** 5 Puntos | **Proceso:** 1. Configuración del Sistema
* **Enunciado Clásico:**
  * **Como** Administrador de la finca,
  * **quiero** configurar el nombre del hato, ubicación, propósito productivo y la descripción del **Hierro Oficial** de mi propiedad,
  * **para** identificar formalmente la unidad de producción y que dicho hierro se pre-cargue automáticamente al registrar animales nacidos en la finca.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Regla de Negocio Venezolana:** En Venezuela, el hierro certifica propiedad y procedencia (suele ser iniciales como `HE` o figuras como *Herradura*). Al guardarlo en configuración, todo formulario de alta en Censo o registro de Parto debe prellenar ese valor por defecto para ahorrar tiempo en el corral, permitiendo editarlo si el animal fue comprado a otro criador.
* **Detalles Técnicos (Flutter + SQLite + API):**
  * Se almacena localmente en la tabla SQLite `configuracion_finca` (`id = 1`, `nombre_finca`, `hierro_oficial`, `proposito`, `ubicacion`, `updated_at`) y se encola en `sync_queue` (`operation_type = 'UPDATE'`) para sincronizar con el endpoint `PUT /api/v1/config`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Guardado exitoso de identidad e hierro oficial**
  * **Dado que** el Administrador se encuentra en la pestaña `"⚙️ 1. Configuración"`,
  * **Cuando** ingresa el Nombre de la Finca `"Hda. La Esperanza"`, el Hierro Oficial `"Hda. La Esperanza (Iniciales HE)"`, el propósito `"Doble Propósito"` y presiona `"Guardar Configuración del Sistema"`,
  * **Entonces** el sistema persiste los datos en SQLite local, actualiza de inmediato el subtítulo de la barra superior de la aplicación y encola el cambio para sincronización.
* **Escenario 2: Prellenado automático del Hierro en formularios de Censo y Parto**
  * **Dado que** el Hierro Oficial configurado es `"Hda. La Esperanza (Iniciales HE)"`,
  * **Cuando** el usuario abre el formulario `"+ Nuevo Animal Manual"` en Censo o selecciona `"Parto"` en Reproducción,
  * **Entonces** el campo `"Hierro (Descripción) *"` aparece prellenado automáticamente con `"Hda. La Esperanza (Iniciales HE)"`.

---

<a id="hu-03"></a>
### 🏷️ Ficha HU-03: Gestión del Catálogo Extensible y Persistente de Razas Bovinas

#### 1. Card (Tarjeta)
* **ID:** `HU-03`
* **Título:** Creación y persistencia local/remota de razas bovinas personalizadas.
* **Prioridad:** Alta | **Estimación:** 5 Puntos | **Proceso:** 1. Configuración / 2. Inventario
* **Enunciado Clásico:**
  * **Como** Administrador u Operador de registro,
  * **quiero** poder registrar nuevas razas o cruces de ganado además de las que vienen por defecto y que queden guardadas permanentemente en el sistema,
  * **para** utilizarlas al registrar tanto el animal actual como cualquier otro animal o cría en el futuro sin volver a escribirlas.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Catálogo Semilla:** Incluye por defecto *Gyr Mestizo, Carora F1, Brahman, Brahman Rojo, Guzerá, Pardo Suizo, Senepol y Romosinuano*.
* **Extensibilidad Offline-First:** El usuario puede abrir el modal `"+ Nueva Raza"` desde Configuración, desde el Censo o desde el sub-panel de Parto. Al guardar, se inserta en la tabla SQLite `catalogo_razas` (normalizando mayúsculas/minúsculas para evitar duplicados) y durante la sincronización con el servidor aplica una estrategia de **Unión Aditiva (*Set Union*)** vía `POST /api/v1/breeds`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Registro de una nueva raza personalizada sin conexión**
  * **Dado que** el usuario está registrando un animal y necesita la raza `"Girolando F1"` que no figura en la lista inicial,
  * **Cuando** presiona `"+ Nueva Raza"`, escribe `"Girolando F1"` y pulsa `"Guardar Raza en Catálogo"`,
  * **Entonces** la raza se guarda en SQLite local, se añade como chip en Configuración, aparece en todos los desplegables de raza del sistema y queda seleccionada automáticamente en el formulario actual.
* **Escenario 2: Prevención de razas duplicadas**
  * **Dado que** la raza `"Brahman"` ya existe en `catalogo_razas`,
  * **Cuando** el usuario intenta registrar `"brahman"` (en minúsculas),
  * **Entonces** el sistema detecta la coincidencia insensible a mayúsculas, no duplica el registro en la base de datos y selecciona la raza existente.

---

<a id="hu-04"></a>
### 🏷️ Ficha HU-04: Parametrización Comercial, Zootécnica y Control de Acceso por Roles (RBAC)

#### 1. Card (Tarjeta)
* **ID:** `HU-04`
* **Título:** Configuración de precios/metas de referencia y restricción de interfaz por rol (`Administrador` vs. `Operador`).
* **Prioridad:** Media | **Estimación:** 5 Puntos | **Proceso:** 1. Configuración / Módulo 1
* **Enunciado Clásico:**
  * **Como** Administrador de la finca,
  * **quiero** definir la capacidad del tanque de leche, precios referenciales (`$/L` y `$/Kg`), meta de GDP (`kg/día`) y restringir el acceso financiero a los usuarios con rol `Operador`,
  * **para** agilizar las liquidaciones comerciales y proteger la confidencialidad del flujo de caja frente al personal de campo.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Parámetros Configurables:** `capacidad_tanque_litros`, `precio_ref_leche_usd`, `precio_ref_carne_kg_usd`, `meta_gdp_kg_dia`, `dias_gestacion` (283) y `dias_secado` (60).
* **Seguridad RBAC en Flutter:** La tabla `usuarios` almacena el campo `rol` (`ADMIN` o `OPERADOR`). El `OPERADOR` tiene acceso completo a *Censo, Pesajes, Ordeño, Sanidad y Reproducción*, pero tiene bloqueado el acceso al módulo `Financiero` y a la edición de precios maestros.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Actualización de precios referenciales y meta de GDP**
  * **Dado que** el Administrador modifica el Precio Ref. de Leche a `"$0.50"`, el Precio Ref. de Carne a `"$1.95"` y la Meta GDP a `"0.75 kg/día"`,
  * **Cuando** guarda la configuración,
  * **Entonces** los modales de `"Vender Leche"` y `"Vender en Canal"` precargan por defecto `$0.50` y `$1.95` respectivamente, y el módulo de Producción de Carne muestra `"Meta Ceba: +0.75 kg/día"`.
* **Escenario 2: Restricción de acceso financiero para el rol Operador**
  * **Dado que** la sesión activa en el dispositivo corresponde a un usuario con `Rol: Operador`,
  * **Cuando** el usuario navega por la aplicación durante su faena,
  * **Entonces** puede registrar ordeños, pesajes, vacunas y partos, pero el módulo `"💰 Financiero"` permanece restringido/oculto.

---

<a id="hu-05"></a>
### 🏷️ Ficha HU-05: Persistencia Local Offline-First (SQLite en Flutter) y Sincronización Delta con Backend API

#### 1. Card (Tarjeta)
* **ID:** `HU-05`
* **Título:** Operación 100% sin conexión en jornada de campo y sincronización automática con el servidor para visibilidad del Administrador.
* **Prioridad:** Crítica (Núcleo Arquitectónico) | **Estimación:** 13 Puntos | **Proceso:** Transversal (Módulo 1)
* **Enunciado Clásico:**
  * **Como** trabajador de campo (`Operador`) que labora en vaqueras y potreros sin cobertura de internet,
  * **quiero** que todos los registros de mi jornada se guarden instantáneamente en la base de datos **SQLite** local de mi móvil y se sincronicen automáticamente cuando recupere conexión a internet,
  * **para** no detener mi trabajo en el corral y permitir que el `Administrador` visualice la información actualizada desde su dispositivo en cuanto haya señal.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Flujo de Trabajo Real (Trabajador ➔ SQLite Local ➔ Backend API ➔ Administrador):**
  1. **Captura Offline en Jornada:** El trabajador registra pesajes, ordeños, eventos sanitarios o partos en la app **Flutter**. El repositorio local escribe en **SQLite (`sqflite`)** en `< 50 ms` usando claves primarias `UUID v4` y encola la operación en la tabla local `sync_queue` (`status = 'PENDING'`, `payload_json`, `created_at`).
  2. **Detección de Red y Push Delta:** Cuando el móvil del trabajador se conecta al WiFi de la casa de la finca o capta datos móviles (`connectivity_plus`), el servicio `SyncEngine` agrupa los registros `PENDING` ordenados cronológicamente y los envía mediante `POST /api/v1/sync/push` al Backend.
  3. **Confirmación y Pull para el Administrador:** El Backend procesa la transacción en su base de datos central (PostgreSQL), devuelve `HTTP 200 OK` con los `UUID` confirmados, la app móvil marca los registros de `sync_queue` como `SYNCED`, y el dispositivo del **Administrador** descarga los cambios vía `GET /api/v1/sync/pull?since=...` actualizando su Dashboard, Censo y Finanzas.
* **Resolución de Conflictos:** *Last-Write-Wins (LWW)* basado en `updated_at` (UTC) para fichas maestras, *Append-Only* (inmutable) para pesajes, ordeños y transacciones, y *Set Union* para el catálogo de razas.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Registro de datos durante la jornada sin conexión a internet**
  * **Dado que** el teléfono móvil del trabajador no tiene conexión WiFi ni datos móviles (modo avión / potrero sin señal),
  * **Cuando** registra 15 ordeños, 5 pesajes y 1 tratamiento sanitario,
  * **Entonces** la aplicación guarda cada registro en SQLite local sin mostrar errores de red, actualiza los KPIs locales al instante e inserta 21 registros con estado `'PENDING'` en la tabla `sync_queue`.
* **Escenario 2: Sincronización automática al recuperar conexión y visualización por el Administrador**
  * **Dado que** existen registros con estado `'PENDING'` en `sync_queue` del móvil del trabajador,
  * **Cuando** el dispositivo detecta conexión a internet estable,
  * **Entonces** envía el lote al endpoint `POST /api/v1/sync/push`, cambia el estado local a `'SYNCED'` y el Administrador puede visualizar inmediatamente los nuevos litros en tanque, pesajes y alertas sanitarias en su propio dispositivo.
* **Escenario 3: Reintento seguro ante corte abrupto de señal durante la sincronización**
  * **Dado que** la sincronización está en curso (`status = 'SYNCING'`) y se pierde la señal a mitad del envío,
  * **Cuando** la petición falla por timeout,
  * **Entonces** el sistema revierte el estado del lote a `'PENDING'`, incrementa `retry_count` y aplica *backoff exponencial* (1s, 2s, 4s, 8s) sin duplicar ni perder ningún registro.

---

<a id="hu-06"></a>
### 🏷️ Ficha HU-06: Alta de Bovinos Separando N° Identificador Único (`id_numero`) y Hierro (`hierro`)

#### 1. Card (Tarjeta)
* **ID:** `HU-06`
* **Título:** Registro individual de animales en el Censo diferenciando N° Identificador e Hierro de propiedad.
* **Prioridad:** Crítica | **Estimación:** 8 Puntos | **Proceso:** 2. Carga Inicial del Inventario
* **Enunciado Clásico:**
  * **Como** Administrador u Operador encargado del censo,
  * **quiero** registrar cada animal ingresando tanto su **N° Identificador** único como la **descripción de su Hierro** (iniciales o figura de propietario/procedencia),
  * **para** individualizar sin ambigüedad a cada res del rebaño aunque cientos de animales compartan el mismo hierro de la finca.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Separación Conceptual:**
  * `id_numero` (`TEXT NOT NULL`): Código identificador individual de la res (ej. `042`, `104`, `201`). Tiene restricción de unicidad parcial en SQLite sobre animales activos (`CREATE UNIQUE INDEX idx_animales_numero_activo ON animales(id_numero) WHERE estado_actual = 'Activo'`).
  * `hierro` (`TEXT NOT NULL`): Descripción de la marca de hierro quemado o frío que indica propietario y procedencia (ej. `"Hda. La Esperanza (HE)"`, `"Finca San José - Iniciales SJ"`, `"Figura Herradura"`).

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Registro exitoso de un animal con N° Identificador único y Hierro descriptivo**
  * **Dado que** el número identificador `"112"` no está ocupado por ningún animal activo en el censo,
  * **Cuando** el usuario ingresa `N° Identificador = "112"`, `Hierro = "Iniciales JM (Media Luna)"`, `Nombre = "Consentida"`, completa su clasificación y presiona `"Guardar en Inventario"`,
  * **Entonces** el sistema inserta el animal en la tabla `animales` de SQLite y lo muestra en la lista de Rebaño Activo diferenciando `#112` y el badge `🔥 Iniciales JM (Media Luna)`.
* **Escenario 2: Bloqueo por N° Identificador duplicado en el censo activo**
  * **Dado que** ya existe un animal activo en el censo con el `N° Identificador = "042"` (*Mariposa*),
  * **Cuando** el usuario intenta guardar otro animal con `N° Identificador = "042"`,
  * **Entonces** el sistema impide el guardado y muestra un mensaje de validación indicando que el N° Identificador `#042` ya pertenece a un ejemplar activo.

---

<a id="hu-07"></a>
### 🏷️ Ficha HU-07: Clasificación por Condiciones Fisiológicas Venezolanas y Estado de Preñez Condicional

#### 1. Card (Tarjeta)
* **ID:** `HU-07`
* **Título:** Clasificación del ganado según etapas fisiológicas de Venezuela y validación de preñez por sexo/etapa.
* **Prioridad:** Alta | **Estimación:** 8 Puntos | **Proceso:** 2. Carga Inicial del Inventario
* **Enunciado Clásico:**
  * **Como** productor o encargado del hato,
  * **quiero** clasificar cada animal según su condición fisiológica real (*Becerro/Becerra, Maute/Mauta, Novillo/Novilla, Toro Reproductor, Vaca parida, Vaca escotera, Vaca seca*) e indicar si está **preñada o no** únicamente cuando sea hembra apta,
  * **para** organizar el manejo zootécnico por lotes e impedir errores ilógicos como marcar preñez en toros, novillos o crías.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Reglas de Filtrado por Sexo y Etapa:**
  * Si `sexo == 'Macho'`: Condiciones permitidas = `Becerro` (nacimiento a destete 4–10m, 150–200 kg), `Maute` (10–18m, ~350 kg), `Novillo / Torete` (≥18m, ≥400 kg), `Toro Reproductor` (≥30m, >425 kg). El campo `esta_prenada` se deshabilita y guarda como `'No aplica'`.
  * Si `sexo == 'Hembra'`: Condiciones permitidas = `Becerra`, `Mauta`, `Novilla de vientre`, `Vaca parida (Primípara)`, `Vaca parida (Multípara)`, `Vaca escotera`, `Vaca seca`.
  * Si es `Becerra` o `Mauta`, `esta_prenada` se marca como `'No aplica'`.
  * Si es `Vaca escotera` o `Vaca seca`, por definición zootécnica se asigna automáticamente `esta_prenada = 'Sí'`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Bloqueo automático de preñez al seleccionar Sexo Macho**
  * **Dado que** el usuario está en el formulario de alta de animal,
  * **Cuando** selecciona `Sexo = "Macho"`,
  * **Entonces** el desplegable de Condición Fisiológica muestra únicamente etapas masculinas (*Becerro, Maute, Novillo / Torete, Toro Reproductor*) y el campo `"¿Está Preñada?"` queda deshabilitado con el valor `"No aplica (Macho / Cría)"`.
* **Escenario 2: Preselección automática de preñez en Vaca escotera y Vaca seca**
  * **Dado que** el usuario selecciona `Sexo = "Hembra"`,
  * **Cuando** elige la condición fisiológica `"Vaca escotera"` o `"Vaca seca"`,
  * **Entonces** el sistema establece automáticamente el campo `"¿Está Preñada?"` en `"🤰 Sí (Preñada)"`.

---

<a id="hu-08"></a>
### 🏷️ Ficha HU-08: Registro de Genealogía por N° Identificador y Consulta de Hoja de Vida Individual

#### 1. Card (Tarjeta)
* **ID:** `HU-08`
* **Título:** Vínculo materno/paterno por N° Identificador (`#ID_Numero`) y modal de Hoja de Vida.
* **Prioridad:** Alta | **Estimación:** 5 Puntos | **Proceso:** 2. Carga Inicial del Inventario
* **Enunciado Clásico:**
  * **Como** Administrador u Operador,
  * **quiero** registrar quién es la madre y el padre de cada animal utilizando su **N° Identificador** (y no el hierro) y consultar su expediente completo en una **Hoja de Vida**,
  * **para** conocer la ascendencia exacta de cada ejemplar y evitar cruces consanguíneos (endogamia).

#### 2. Conversation (Conversación y Especificación Técnica)
* **Por qué no usar el Hierro para la Madre:** Todos los animales nacidos en la misma finca llevan el mismo hierro del propietario; por tanto, la única forma de saber cuál vaca específica es la madre de un becerro es referenciando el `id_numero` de la madre (`madre_numero = '042'`).
* **Hoja de Vida:** Modal o pantalla de detalle en Flutter que consolida datos de identificación, hierro, etapa, preñez, genealogía (`#madre_numero` y `#padre_numero`) y últimos eventos de ordeño, pesaje y sanidad.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Consulta de Hoja de Vida y Árbol Genealógico por N° Identificador**
  * **Dado que** la novilla `#108` (*Lucero*) tiene registrada como madre a la vaca `#042` (*Mariposa*) y como padre al toro `#009` (*Titán*),
  * **Cuando** el usuario presiona el botón `"Hoja de Vida"` en la fila del animal `#108`,
  * **Entonces** se abre la ventana de expediente mostrando su N° Identificador `#108`, su Hierro, su condición fisiológica y su Árbol de Genealogía referenciando a Madre `#042 (Mariposa)` y Padre `#009`.

---

<a id="hu-09"></a>
### 🏷️ Ficha HU-09: Búsqueda y Filtrado Multicriterio del Censo por Etapa Fisiológica y Preñez

#### 1. Card (Tarjeta)
* **ID:** `HU-09`
* **Título:** Filtros combinados del padrón bovino por condición fisiológica y estado de gestación.
* **Prioridad:** Media | **Estimación:** 3 Puntos | **Proceso:** 2. Carga Inicial del Inventario
* **Enunciado Clásico:**
  * **Como** usuario del sistema,
  * **quiero** filtrar la tabla del censo por etapa fisiológica (*Becerros, Mautes, Novillos, Vacas paridas, Vacas escoteras, Vacas secas, Toros*) y por estado de preñez (*Preñadas vs. Vacías*),
  * **para** ubicar rápidamente los lotes de manejo sin recorrer manualmente todo el listado de animales.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Consultas Indexadas en SQLite:** La tabla `animales` cuenta con índices sobre `condicion_fisiologica` y `esta_prenada` para ejecutar el filtrado en memoria/SQLite de forma instantánea.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Filtrado de hembras preñadas**
  * **Dado que** el usuario visualiza la pestaña `"🐄 2. Inventario (Censo)"`,
  * **Cuando** selecciona en el filtro de preñez la opción `"🤰 Solo Preñadas (Sí)"`,
  * **Entonces** la tabla muestra únicamente las vacas y novillas cuyo estado `esta_prenada` es igual a `"Sí"`.

---

<a id="hu-10"></a>
### 🏷️ Ficha HU-10: Registro de Pesajes Periódicos en Báscula y Cálculo Automático de GDP (`kg/día`)

#### 1. Card (Tarjeta)
* **ID:** `HU-10`
* **Título:** Control de peso vivo en báscula, cálculo de Ganancia Diaria de Peso (`GDP`) y semáforo zootécnico.
* **Prioridad:** Alta | **Estimación:** 8 Puntos | **Proceso:** 3. Producción de Carne
* **Enunciado Clásico:**
  * **Como** Operador de romana o Administrador,
  * **quiero** registrar el peso actual de un animal por su **N° Identificador** y que el sistema calcule automáticamente su **Ganancia Diaria de Peso (`GDP` en `kg/día`)** respecto al pesaje anterior,
  * **para** evaluar la eficiencia del engorde y detectar a tiempo animales estancados por nutrición o parasitismo.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Fórmula Zootécnica:**
  $$\text{GDP (kg/día)} = \frac{\text{Peso Actual (kg)} - \text{Peso Previo (kg)}}{\text{Días Transcurridos}}$$
* **Semáforo de Desempeño:**
  * `GDP >= 0.60 kg/día`: 🟢 **Excelente / Óptimo**
  * `0.30 <= GDP < 0.60 kg/día`: ⚪ **Aceptable / Normal**
  * `GDP < 0.30 kg/día`: 🔴 **Estancado / Alerta**
* **Efecto Colateral:** Al insertar en `registros_pesaje`, una transacción SQLite actualiza simultáneamente `animales.peso_actual = nuevo_peso`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Cálculo automático de GDP y actualización de peso en el Censo**
  * **Dado que** el maute `#201` (*Campeón*) tiene un último peso registrado de `340 Kg`,
  * **Cuando** el usuario selecciona `#201` en `"⚖️ 3. Producción Carne"`, ingresa un nuevo peso de `"361 Kg"` tras `30 días` y presiona `"Calcular GDP y Guardar"`,
  * **Entonces** el sistema calcula una GDP de `+0.70 kg/día`, le asigna el badge `"🟢 Excelente / Óptimo"` y actualiza el peso de `#201` a `361 Kg` en el Censo.

---

<a id="hu-11"></a>
### 🏷️ Ficha HU-11: Registro de Tratamientos Sanitarios y Activación de Tiempos de Retiro (Carne y Leche)

#### 1. Card (Tarjeta)
* **ID:** `HU-11`
* **Título:** Control de eventos sanitarios, vacunaciones INSAI y cuarentena automática por tiempos de retiro.
* **Prioridad:** Crítica (Inocuidad Alimentaria) | **Estimación:** 8 Puntos | **Proceso:** 3. Carne / 4. Leche / Sanidad
* **Enunciado Clásico:**
  * **Como** encargado sanitario o veterinario de la finca,
  * **quiero** registrar los medicamentos, antiparasitarios o vacunas aplicados a un animal indicando sus **días de retiro en leche y en carne**,
  * **para** activar automáticamente una cuarentena sanitaria que impida contaminar el tanque de leche o vender animales medicados a matadero.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Cálculo Local de Fechas de Liberación:**
  * `fecha_liberacion_leche = fecha_aplicacion + dias_retiro_leche`
  * `fecha_liberacion_carne = fecha_aplicacion + dias_retiro_carne`
* Mientras la fecha actual del dispositivo sea menor o igual a la fecha de liberación, el animal figura activo en cuarentena (`Retiro Activo`).

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Activación inmediata de cuarentena al registrar antibiótico**
  * **Dado que** la vaca `#042` (*Mariposa*) está sana,
  * **Cuando** el usuario registra en `"🩺 Sanidad & Retiro"` la aplicación de `"Oxitetraciclina L.A."` con `5 días` de retiro en leche y `28 días` de retiro en carne,
  * **Entonces** el animal `#042` pasa inmediatamente a estado de cuarentena activa, aparece en el semáforo de alertas rojas del Dashboard y queda bloqueado para leche comercial y venta en canal.

---

<a id="hu-12"></a>
### 🏷️ Ficha HU-12: Liquidación de Venta en Canal, Bloqueo Sanitario y Liberación del N° Identificador

#### 1. Card (Tarjeta)
* **ID:** `HU-12`
* **Título:** Beneficio en canal / venta de ganado con validación de inocuidad, liberación de N° Identificador e ingreso en caja.
* **Prioridad:** Crítica | **Estimación:** 8 Puntos | **Proceso:** 3. Producción de Carne
* **Enunciado Clásico:**
  * **Como** Administrador de la finca,
  * **quiero** liquidar la venta a matadero/canal de un animal apto registrando su Peso Vivo en Báscula (Kg), Precio por Kg ($) y Destino,
  * **para** desincorporarlo del censo activo, **liberar su N° Identificador** para nuevas crías y acreditar automáticamente el monto de la venta en el libro de caja.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Bloqueo Sanitario Estricto:** Si el animal tiene `dias_retiro_carne` vigentes, el botón de confirmación se deshabilita y muestra alerta roja.
* **Transacción Atómica Triple en SQLite:**
  1. Inserta el registro en `ventas_canal` (`monto_total = peso_vivo_kg * precio_kg`).
  2. Cambia `animales.estado_actual = 'Vendido_Canal'`, lo que **libera automáticamente el `id_numero`** en el índice único de animales activos.
  3. Inserta un asiento automático de `Ingreso` en `transacciones_financieras` bajo la categoría `"Venta de Ganado / Canal"`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Bloqueo de venta en canal por retiro sanitario activo**
  * **Dado que** el animal `#104` tiene un tratamiento médico con retiro en carne vigente,
  * **Cuando** el usuario presiona `"🥩 Vender en Canal"` sobre la fila de `#104`,
  * **Entonces** el modal muestra el aviso `"🚨 PROHIBIDO EL BENEFICIO SANITARIO"` y mantiene deshabilitado el botón de confirmación.
* **Escenario 2: Venta exitosa, liberación de N° Identificador e ingreso financiero**
  * **Dado que** el maute/novillo `#201` está libre de retiro sanitario,
  * **Cuando** el usuario ingresa `Peso Vivo = 420 Kg`, `Precio por Kg = $1.85` (`Total = $777.00`), `Destino = "Frigorífico Ganadero"` y confirma la venta,
  * **Entonces** `#201` sale del Rebaño Activo, pasa a `"🥩 Historial Canal & Ventas"`, el número identificador `201` queda disponible para asignarse a un nuevo becerro y se suma un ingreso de `$777.00` en `"💰 Financiero"`.

---

<a id="hu-13"></a>
### 🏷️ Ficha HU-13: Registro de Eventos Reproductivos, Diagnóstico de Preñez y Secado de Vacas

#### 1. Card (Tarjeta)
* **ID:** `HU-13`
* **Título:** Control de celo, monta/inseminación, diagnóstico de gestación y pase a Vaca Seca.
* **Prioridad:** Alta | **Estimación:** 5 Puntos | **Proceso:** 4. Producción de Leche / Reproducción
* **Enunciado Clásico:**
  * **Como** encargado reproductivo o Administrador,
  * **quiero** registrar servicios, diagnósticos de palpación y eventos de secado en vacas y novillas de vientre,
  * **para** que el sistema actualice automáticamente su estado de preñez (`Sí / No`) y su condición fisiológica (`Vaca escotera` o `Vaca seca`).

#### 2. Conversation (Conversación y Especificación Técnica)
* **Reglas de Transición Fisiológica Automática:**
  * `Diagnóstico Preñez` con resultado `"Preñada Confirmada"` ➔ actualiza `esta_prenada = 'Sí'`.
  * `Diagnóstico Preñez` con resultado `"Preñada Escotera"` ➔ actualiza `condicion_fisiologica = 'Vaca escotera'` y `esta_prenada = 'Sí'`.
  * `Diagnóstico Preñez` con resultado `"Vacía"` o evento `"Aborto"` ➔ actualiza `esta_prenada = 'No'`.
  * Evento `"Secado"` (~60 días antes del parto) ➔ actualiza `condicion_fisiologica = 'Vaca seca'` y `esta_prenada = 'Sí'`, retirándola de la lista de ordeño diario.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Paso automático a Vaca seca al registrar el secado**
  * **Dado que** la vaca `#042` se encuentra preñada y cumple su período previo al parto,
  * **Cuando** el usuario registra en `"🧬 Reproducción"` el evento `"Secado de Vaca"` para `#042`,
  * **Entonces** la condición fisiológica de `#042` en el Censo cambia automáticamente a `"Vaca seca"` con estado `"🤰 Sí (Preñada)"`.

---

<a id="hu-14"></a>
### 🏷️ Ficha HU-14: Registro de Parto con Alta Automática del Becerro/a y Pase de Madre a Vaca Parida

#### 1. Card (Tarjeta)
* **ID:** `HU-14`
* **Título:** Registro integral de parto con incorporación automática de la cría al Censo y habilitación de lactancia de la madre.
* **Prioridad:** Crítica | **Estimación:** 8 Puntos | **Proceso:** 4. Producción de Leche / Reproducción
* **Enunciado Clásico:**
  * **Como** Operador o Administrador,
  * **quiero** que al registrar el **Parto** de una hembra se despliegue la ficha del recién nacido para asignarle su **N° Identificador**, **Hierro**, nombre, sexo, raza y peso al nacer,
  * **para** dar de alta automáticamente al nuevo *Becerro/Becerra* en el Censo (vinculado al **N° Identificador de su madre**) y pasar a la madre a condición de **Vaca parida** lista para el ordeño.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Transacción Compuesta en SQLite:**
  1. Inserta el evento `"Parto"` en `eventos_reproductivos`.
  2. Crea el registro del recién nacido en `animales` con `condicion_fisiologica = 'Becerro'` (si es macho) o `'Becerra'` (si es hembra), `esta_prenada = 'No aplica'`, `madre_numero = hembra_id_numero` y `padre_numero = toro_id_numero`.
  3. Actualiza a la madre en `animales`: `condicion_fisiologica = 'Vaca parida (Primípara | Multípara)'` y `esta_prenada = 'No'`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Alta automática del becerro vinculando a la madre por N° Identificador**
  * **Dado que** el usuario selecciona en `"🧬 Reproducción"` a la vaca `#055` (*Lucero*) y elige el evento `"Parto (Nacimiento de Cría)"`,
  * **Cuando** completa la ficha del recién nacido con `N° Identificador Cría = "115"`, `Nombre = "Relámpago"`, `Sexo = "Macho"`, `Peso = 36 Kg` y presiona guardar,
  * **Entonces** el sistema incorpora a `#115 Relámpago` en el Censo como `"Becerro"` con `Madre = #055`, cambia a la vaca `#055` a `"Vaca parida"` (`Preñada: No`) y la habilita en los selectores de Ordeño Diario.

---

<a id="hu-15"></a>
### 🏷️ Ficha HU-15: Registro de Ordeño Diario (Mañana/Tarde) con Filtro Sanitario de Inocuidad

#### 1. Card (Tarjeta)
* **ID:** `HU-15`
* **Título:** Captura de litros de leche por vaca y jornada con desvío automático a descarte por retiro sanitario.
* **Prioridad:** Crítica | **Estimación:** 8 Puntos | **Proceso:** 4. Producción de Leche
* **Enunciado Clásico:**
  * **Como** ordeñador (`Operador`) o Administrador,
  * **quiero** registrar los litros ordeñados de cada vaca parida en las jornadas de Mañana y Tarde tanto desde el módulo de Leche como desde el widget rápido del Dashboard,
  * **para** acumular la leche sana en el tanque comercial y desviar automáticamente a **descarte** la leche de vacas con tratamiento médico activo.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Regla de Inocuidad Láctea:** Antes de guardar, el sistema verifica si el `id_numero` de la vaca tiene un retiro de leche vigente.
  * Si `es_retiro == false`: Suma `litros` al saldo `leche_disponible_tanque`.
  * Si `es_retiro == true`: Muestra alerta roja en vivo, guarda el registro con `es_descarte_retiro = 1`, suma al indicador de *Descarte por Retiro* y **no** altera el saldo del tanque comercial.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Ordeño de vaca sana suma al tanque disponible**
  * **Dado que** el tanque tiene `342.5 L` disponibles y la vaca `#042` (*Mariposa*) está libre de tratamientos médicos,
  * **Cuando** el operador registra un ordeño de `"10.5 L"` en la jornada `"Mañana"` para `#042`,
  * **Entonces** el saldo del tanque aumenta a `353.0 L` y el registro se marca con el estado `"✅ Sumó a Tanque"`.
* **Escenario 2: Ordeño de vaca en cuarentena se desvía a descarte**
  * **Dado que** la vaca `#104` (*Canela*) tiene un retiro sanitario en leche activo,
  * **Cuando** el operador selecciona `#104` en el formulario de ordeño y registra `"8.0 L"`,
  * **Entonces** el sistema muestra la advertencia roja `"⚠️ ¡RETIRO SANITARIO ACTIVO!"`, registra los `8.0 L` en `"⚠️ Descarte por Retiro"` y mantiene intacto el saldo del tanque comercial.

---

<a id="hu-16"></a>
### 🏷️ Ficha HU-16: Gestión del Tanque de Enfriamiento y Despacho / Venta Comercial de Leche

#### 1. Card (Tarjeta)
* **ID:** `HU-16`
* **Título:** Control de inventario en tanque de enfriamiento, liquidación de despacho a quesera e ingreso en caja.
* **Prioridad:** Alta | **Estimación:** 5 Puntos | **Proceso:** 4. Producción de Leche
* **Enunciado Clásico:**
  * **Como** Administrador de la finca,
  * **quiero** registrar la venta o despacho de leche del tanque indicando los litros entregados, el precio por litro ($) y el comprador,
  * **para** descontar el volumen despachado del tanque de enfriamiento y registrar automáticamente el cobro como un ingreso en el módulo financiero.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Validación de Stock:** El campo `litros_despachados` no puede superar `leche_disponible_tanque`.
* **Impacto Cruzado:** Resta los litros del tanque, inserta en `ventas_leche` e inserta una transacción de `Ingreso` en `transacciones_financieras` (`monto = litros * precio_litro`).

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Despacho exitoso de leche y acreditación en caja**
  * **Dado que** el tanque cuenta con `342.5 L` disponibles,
  * **Cuando** el usuario abre `"🥛 Vender / Despachar Leche"`, ingresa `200 L` a `$0.45 / L` para `"Quesera Don Pedro"` y confirma la venta,
  * **Entonces** el saldo del tanque disminuye a `142.5 L`, se añade el despacho al historial y se acredita automáticamente un ingreso de `$90.00` en el libro de caja.
* **Escenario 2: Bloqueo por intento de vender más litros de los disponibles en tanque**
  * **Dado que** el saldo disponible en el tanque es de `142.5 L`,
  * **Cuando** el usuario intenta despachar `200 L`,
  * **Entonces** el sistema impide completar la operación mostrando una alerta de que el volumen supera la existencia en tanque.

---

<a id="hu-17"></a>
### 🏷️ Ficha HU-17: Registro de Transacciones Financieras, Flujo de Caja y Costo Directo por Litro (`$/L`)

#### 1. Card (Tarjeta)
* **ID:** `HU-17`
* **Título:** Libro de caja operativo (ingresos/egresos), margen bruto y cálculo de costo directo por litro de leche.
* **Prioridad:** Media | **Estimación:** 5 Puntos | **Proceso:** Transversal (Módulo Financiero)
* **Enunciado Clásico:**
  * **Como** Administrador de la finca,
  * **quiero** registrar gastos operativos (alimentación, medicinas, jornales, mantenimiento) y consultarlos junto a los ingresos automáticos por venta de leche y carne,
  * **para** conocer en tiempo real la utilidad neta en caja, el margen bruto (%) y el **costo directo estimado por litro de leche producido (`$/L`)**.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Fórmulas Financieras Locales:**
  * $\text{Utilidad Neta} = \sum \text{Ingresos} - \sum \text{Egresos}$
  * $\text{Margen Bruto (\%)} = \left(\frac{\text{Utilidad Neta}}{\sum \text{Ingresos}}\right) \times 100$
  * $\text{Costo Directo por Litro (\$/L)} = \frac{\sum \text{Egresos Operativos}}{\text{Total Litros Producidos Acumulados}}$

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Registro de un gasto operativo y recálculo de indicadores**
  * **Dado que** el Administrador se encuentra en `"💰 Financiero"`,
  * **Cuando** selecciona `Tipo = "Egreso (-)"`, `Categoría = "Alimentación / Sal"`, `Monto = "$50.00"`, `Concepto = "Compra de sal mineralizada"` y presiona `"Registrar Asiento"`,
  * **Entonces** el asiento se agrega al Libro de Caja en SQLite, aumentan los Egresos Operativos en `$50.00` y se recalculan inmediatamente el Margen de Caja y el Costo Estimado por Litro.

---

<a id="hu-18"></a>
### 🏷️ Ficha HU-18: Tablero de Control Operativo (Dashboard), KPIs en Tiempo Real y Semáforo de Alertas

#### 1. Card (Tarjeta)
* **ID:** `HU-18`
* **Título:** Dashboard gerencial con KPIs consolidados, captura rápida en vaquera y semáforo de alertas sanitarias/reproductivas.
* **Prioridad:** Alta | **Estimación:** 5 Puntos | **Proceso:** Transversal (Módulo Dashboard)
* **Enunciado Clásico:**
  * **Como** Administrador u Operador,
  * **quiero** disponer de un tablero consolidado con el saldo del tanque, el censo activo (preñadas y ventas en canal), los animales en retiro sanitario, la utilidad en caja y las alertas prioritarias del día,
  * **para** tomar decisiones rápidas en una sola vista al iniciar o cerrar la jornada.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Consultas Reactivas en Flutter:** El Dashboard escucha los `Streams` / `ChangeNotifiers` de los repositorios SQLite locales (y se actualiza tras cada `pull` de sincronización del Backend), garantizando que cualquier cambio en Ordeño, Censo, Sanidad o Finanzas se refleje en tiempo real sin recargar la aplicación.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Sincronización instantánea de KPIs en el Dashboard**
  * **Dado que** se registra un nuevo parto, un ordeño o una venta en canal en cualquiera de los módulos,
  * **Cuando** el usuario abre la pestaña `"📊 Dashboard"`,
  * **Entonces** las 4 tarjetas superiores (*Disponible en Tanque, Rebaño Activo, Retiro Sanitario y Utilidad en Caja*) y la tabla de últimos ordeños muestran las cifras actualizadas al instante.
