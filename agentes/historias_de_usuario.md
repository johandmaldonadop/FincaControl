# 📋 Especificación Técnica de Historias de Usuario: FincaControl
> **Sistema Integral de Gestión Ganadera para Fincas de Doble Propósito (Leche y Carne)**  
> **Equipo de Desarrollo:** Johan Maldonado – José Chacón  
> **Arquitectura Definida:** Aplicación Móvil en **Flutter** (Propuesta A: Dos Experiencias por Rol) + **Primero Online** (API REST Lógica y Base de Datos Relacional Central con tecnología/infraestructura a definir) + **Extensión Offline Táctica de Campo** (SQLite ligero local en el móvil)  
> **Metodología:** Plantilla Clásica Ágil (*Quién, Qué, Para qué*) + Las 3 "C" de Ron Jeffries (*Card, Conversation, Confirmation*) + Criterios de Aceptación BDD (*Gherkin: Dado que / Cuando / Entonces*)

---

## 📑 Índice de Historias de Usuario por Proceso y Módulo

Todas las historias de usuario del sistema se consolidan en una única sección de catálogo técnico (ver abajo) mediante fichas numeradas de la **`HU-01`** a la **`HU-20`**:

* **Proceso 0 y 1: Arquitectura Primero Online + Cola Offline de Campo, Roles (Propuesta A) y Configuración**
  * [**HU-01:** Visualización del Esquema General de Procesos del Sistema](#hu-01)
  * [**HU-02:** Configuración Online de Identidad de la Finca y Hierro Oficial Predeterminado](#hu-02)
  * [**HU-03:** Gestión Online del Catálogo Maestro Extensible de Razas Bovinas y Caché de Campo](#hu-03)
  * [**HU-04:** Parametrización Comercial, Zootécnica y Experiencia Dual por Rol — Propuesta A](#hu-04)
  * [**HU-05:** Motor Primero Online + Extensión Offline Táctica de Campo (Caché Ligera y Cola FIFO en SQLite Móvil)](#hu-05)
* **Proceso 2: Carga Inicial del Inventario de Animales (Censo, Etapas, Genealogía y Regla de Altas)**
  * [**HU-06:** Alta Manual de Inventario Inicial y Compras (Exclusivo Admin Online) Separando N° Identificador y Hierro](#hu-06)
  * [**HU-07:** Clasificación por Condiciones Fisiológicas Venezolanas y Estado de Preñez Condicional](#hu-07)
  * [**HU-08:** Registro de Genealogía por N° Identificador y Consulta de Hoja de Vida Individual](#hu-08)
  * [**HU-09:** Búsqueda y Filtrado Multicriterio del Censo por Etapa Fisiológica y Preñez](#hu-09)
* **Proceso 3: Registro de Datos del Proceso de Producción de Carne**
  * [**HU-10:** Registro de Pesajes Periódicos en Báscula (Online u Offline en Campo) y Cálculo Automático de GDP (`kg/día`)](#hu-10)
  * [**HU-11:** Registro de Tratamientos Sanitarios (Online u Offline en Campo) y Activación de Tiempos de Retiro](#hu-11)
  * [**HU-12:** Liquidación Online de Venta en Canal, Bloqueo Sanitario y Liberación del N° Identificador](#hu-12)
* **Proceso 4: Registro de Datos del Proceso de Producción de Leche**
  * [**HU-13:** Registro de Eventos Reproductivos, Diagnóstico de Preñez y Secado de Vacas](#hu-13)
  * [**HU-14:** Registro de Parto en Campo con Alta Automática del Becerro/a y Pase de Madre a Vaca Parida](#hu-14)
  * [**HU-15:** Registro de Ordeño Diario (Mañana/Tarde) con Filtro Sanitario de Inocuidad](#hu-15)
  * [**HU-16:** Gestión del Tanque de Enfriamiento y Despacho / Venta Comercial de Leche (Exclusivo Admin Online)](#hu-16)
* **Módulos de Experiencia por Rol, Finanzas y Auditoría Inmutable**
  * [**HU-17:** Registro Online de Transacciones Financieras, Flujo de Caja y Costo Directo por Litro (`$/L`)](#hu-17)
  * [**HU-18:** Terminal Ligera de Carga de Datos en Campo para el Trabajador (`📱 Terminal de Carga`)](#hu-18)
  * [**HU-19:** Vista Rápida Ejecutiva del Administrador (`📊 Vista Rápida (Admin)`), KPIs y Semáforo de Alertas](#hu-19)
  * [**HU-20:** Historial General Inmutable de Acciones y Bitácora de Auditoría (`📜 Historial de Acciones`)](#hu-20)

---

## 🗂️ Catálogo Único de Historias de Usuario (Fichas Técnicas HU-01 a HU-20)

<a id="hu-01"></a>
### 🏷️ Ficha HU-01: Visualización del Esquema General de Procesos del Sistema

#### 1. Card (Tarjeta)
* **ID:** `HU-01`
* **Título:** Mapa interactivo del esquema de procesos soportados por FincaControl.
* **Prioridad:** Alta | **Estimación:** 3 Puntos | **Proceso:** 0. Esquema de Procesos
* **Enunciado Clásico:**
  * **Como** Administrador de la finca,
  * **quiero** visualizar en el sistema un esquema claro de los procesos soportados en su orden lógico (*1. Configuración ➔ 2. Inventario ➔ 3. Producción Carne ➔ 4. Producción Leche*),
  * **para** comprender el flujo encadenado del software y navegar directamente al proceso que necesito gestionar.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Contexto de Negocio:** Antes de mostrar formularios operativos aislados, la plataforma orienta al productor ganadero mostrando cómo la parametrización de la finca y el censo inicial habilitan las dos líneas productivas (carne y leche) y alimentan el historial transversal de auditoría.
* **Detalles Técnicos (Flutter):**
  * Pantalla `ProcessSchemaScreen` accesible como primera pestaña del perfil `Administrador`.
  * Incluye diagrama secuencial interactivo superior y 4 tarjetas de detalle con navegación directa a cada módulo más accesos rápidos a *Sanidad, Reproducción, Finanzas, Vista Rápida e Historial de Acciones*.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Apertura inicial con sesión de Administrador**
  * **Dado que** el usuario con rol `Administrador` abre la aplicación FincaControl,
  * **Cuando** se carga la pantalla principal por defecto,
  * **Entonces** el sistema muestra activa la vista `"🗺️ Esquema de Procesos"` con la secuencia numerada del Paso 1 al Paso 4.
* **Escenario 2: Navegación directa desde una tarjeta de proceso**
  * **Dado que** el Administrador se encuentra en la vista `"🗺️ Esquema de Procesos"`,
  * **Cuando** presiona `"Ir al Proceso 1: Configuración del Sistema ➔"` (o cualquiera de los nodos de los Procesos 1, 2, 3 o 4),
  * **Entonces** la aplicación cambia inmediatamente a la pestaña del módulo seleccionado y marca activo su botón en la navegación.

---

<a id="hu-02"></a>
### 🏷️ Ficha HU-02: Configuración Online de Identidad de la Finca y Hierro Oficial Predeterminado

#### 1. Card (Tarjeta)
* **ID:** `HU-02`
* **Título:** Parametrización Online de los datos maestros del hato y marca de Hierro Oficial.
* **Prioridad:** Alta (Bloqueante Fase 1) | **Estimación:** 5 Puntos | **Proceso:** 1. Configuración del Sistema
* **Enunciado Clásico:**
  * **Como** Administrador de la finca conectado en línea,
  * **quiero** configurar el nombre del hato, ubicación, propósito productivo y la descripción del **Hierro Oficial Predeterminado** de mi propiedad,
  * **para** centralizar la identidad de la unidad de producción y que dicho hierro se pre-cargue automáticamente en las altas de inventario y en los partos registrados en campo.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Regla de Negocio Venezolana:** El hierro certifica propiedad y procedencia (iniciales como `HE` o figuras como *Herradura*). Al guardarlo en la configuración maestra, todo formulario de alta manual o nacimiento de cría precarga ese valor por defecto.
* **Alcance Online Obligatorio:** La edición de `configuracion_finca` es **exclusiva del `Administrador` en modo `Online`** (`PUT /api/v1/configuracion`), actualizando la tabla `cache_referencia_resumen` de los teléfonos de campo en su siguiente descarga de referencia y generando un registro en `historial_acciones`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Guardado exitoso en línea de identidad e hierro oficial**
  * **Dado que** el Administrador tiene conexión activa con el Servidor Central y está en `"⚙️ 1. Configuración"`,
  * **Cuando** ingresa Nombre `"Hda. La Esperanza"`, Hierro Oficial `"Hda. La Esperanza (Iniciales HE)"` y presiona `"Guardar Configuración del Sistema"`,
  * **Entonces** el Servidor Central persiste los cambios en `configuracion_finca`, registra la acción en `"📜 Historial de Acciones"` y actualiza el encabezado global del sistema.
* **Escenario 2: Bloqueo preventivo de cambio de configuración sin conexión**
  * **Dado que** el teléfono del Administrador se encuentra temporalmente `"Sin Señal"`,
  * **Cuando** intenta guardar cambios en `"⚙️ 1. Configuración"`,
  * **Entonces** el sistema impide la modificación e informa que la configuración maestra requiere conexión en línea con el Servidor Central.

---

<a id="hu-03"></a>
### 🏷️ Ficha HU-03: Gestión Online del Catálogo Maestro Extensible de Razas Bovinas y Caché de Campo

#### 1. Card (Tarjeta)
* **ID:** `HU-03`
* **Título:** Creación centralizada de razas bovinas personalizadas y sincronización hacia la caché móvil.
* **Prioridad:** Alta | **Estimación:** 5 Puntos | **Proceso:** 1. Configuración / 2. Inventario
* **Enunciado Clásico:**
  * **Como** Administrador de la finca,
  * **quiero** registrar en línea nuevas razas o cruces de ganado además de las predeterminadas y que queden almacenadas permanentemente en el catálogo maestro,
  * **para** evitar duplicados o errores ortográficos y dejarlas disponibles en la caché de los teléfonos de los trabajadores cuando registren partos en campo.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Catálogo Semilla:** Incluye *Gyr Mestizo, Carora F1, Brahman, Brahman Rojo, Guzerá, Pardo Suizo, Senepol y Romosinuano*.
* **Gobernanza Centralizada:** La creación de nuevas entradas en `catalogo_razas` (`POST /api/v1/razas`) es exclusiva del `Administrador` en modo `Online` (normalizando mayúsculas/minúsculas). El JSON del catálogo activo se descarga en `cache_referencia_resumen.catalogo_razas_json` del SQLite móvil para que el `Trabajador` pueda seleccionar cualquier raza existente al registrar un parto sin internet.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Registro Online de una nueva raza personalizada por el Administrador**
  * **Dado que** el Administrador está en línea y necesita agregar la raza `"Girolando F1"`,
  * **Cuando** pulsa `"+ Agregar Nueva Raza"`, escribe `"Girolando F1"` y confirma `"Guardar Raza en Catálogo"`,
  * **Entonces** la raza se persiste en `catalogo_razas` de la Base de Datos Central, aparece en todos los selectores de raza, se audita en `historial_acciones` y pasa a formar parte de la caché descargable por los móviles de campo.
* **Escenario 2: Prevención de razas duplicadas**
  * **Dado que** la raza `"Brahman"` ya existe en `catalogo_razas`,
  * **Cuando** el Administrador intenta registrar `"brahman"` en minúsculas,
  * **Entonces** el sistema detecta la coincidencia insensible a mayúsculas, evita duplicar el registro y selecciona la raza existente.

---

<a id="hu-04"></a>
### 🏷️ Ficha HU-04: Parametrización Comercial, Zootécnica y Experiencia Dual por Rol — Propuesta A

#### 1. Card (Tarjeta)
* **ID:** `HU-04`
* **Título:** Configuración de precios/metas y adaptación completa de interfaz por rol (`Administrador` vs. `Trabajador`).
* **Prioridad:** Crítica | **Estimación:** 8 Puntos | **Proceso:** 1. Configuración / Arquitectura UI
* **Enunciado Clásico:**
  * **Como** propietario/Administrador de la finca,
  * **quiero** que una única aplicación móvil adapte su interfaz según el perfil autenticado (**Propuesta A**: *Vista Rápida y Control* para `Administrador`, y *Terminal Ligera de Carga* para `Trabajador`),
  * **para** que el personal de campo capture datos con botones simples sin ver finanzas, ventas, configuración ni altas manuales, mientras yo consulto indicadores rápidos y gobierno las operaciones administrativas.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Parámetros Configurables (`configuracion_finca`):** `capacidad_tanque_litros`, `precio_ref_leche`, `precio_ref_carne_kg`, `meta_gdp_kg_dia`, `dias_gestacion_ref` (283) y `dias_alerta_secado` (60).
* **Reglas de Interfaz de la Propuesta A en Flutter:**
  * Si `usuario.rol == 'ADMIN'`: Habilita `Esquema de Procesos`, `Vista Rápida (Admin)`, `Configuración`, `Inventario` (con `+ Nuevo Animal Manual`, `+ Registrar Nueva Raza`, `Vender en Canal` e `Historial Canal`), `Producción Carne`, `Producción Leche` (con `Vender / Despachar Leche`), `Sanidad`, `Reproducción`, `Financiero` e `Historial de Acciones`.
  * Si `usuario.rol == 'OPERADOR'`: Activa por defecto `📱 Terminal de Carga` y oculta estrictamente `Configuración`, `Financiero`, `Historial de Acciones`, `+ Nuevo Animal Manual`, `+ Registrar Nueva Raza`, `Vender / Despachar Leche` y `Vender en Canal`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Adaptación automática de interfaz al iniciar como Trabajador (Operador)**
  * **Dado que** un usuario autenticado posee el rol `"Trabajador / Operador"`,
  * **Cuando** ingresa a la aplicación móvil,
  * **Entonces** el sistema abre directamente `"📱 Terminal de Carga"` y oculta las pestañas `"⚙️ 1. Configuración"`, `"💰 Financiero"`, `"📜 Historial de Acciones"` así como todos los botones de alta manual de animales, creación de razas y ventas comerciales.
* **Escenario 2: Precarga de precios referenciales configurados por el Administrador**
  * **Dado que** el Administrador guardó en línea `Precio Ref. Leche = $0.50` y `Precio Ref. Carne = $1.95`,
  * **Cuando** abre los formularios de `"Vender Leche"` o `"Vender en Canal"`,
  * **Entonces** ambos modales precargan automáticamente `$0.50` y `$1.95` respectivamente.

---

<a id="hu-05"></a>
### 🏷️ Ficha HU-05: Motor Primero Online + Extensión Offline Táctica de Campo (Caché Ligera y Cola FIFO en SQLite Móvil)

#### 1. Card (Tarjeta)
* **ID:** `HU-05`
* **Título:** Operación centralizada Online con soporte táctico sin señal mediante 3 tablas ligeras en SQLite móvil.
* **Prioridad:** Crítica (Núcleo Arquitectónico) | **Estimación:** 13 Puntos | **Proceso:** Transversal (Módulo 1)
* **Enunciado Clásico:**
  * **Como** trabajador de campo (`Operador`) que captura datos en vaqueras y mangas donde se pierde la señal móvil,
  * **quiero** que mi teléfono conserve una caché ligera del padrón activo y almacene mis registros de campo en una **cola local de envíos** cuando no haya internet, transmitiéndolos automáticamente al Servidor Central al recuperar cobertura,
  * **para** no interrumpir la faena diaria sin necesidad de cargar toda la base de datos histórica y financiera de la finca en el teléfono.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Modelo Arquitectónico Aprobado (`modelo_base_de_datos.md`):**
  1. **Fuente Única de Verdad (Online):** Las 12 tablas maestras, saldos del tanque, inventario oficial, ventas, caja e `historial_acciones` residen y se calculan en la **Base de Datos Relacional Central**.
  2. **SQLite Ligero en el Móvil (Solo 3 Tablas Locales):**
     * `cache_padron_activo`: Copia de lectura de los animales con `estado_actual = 'Activo'` incluyendo banderas de `tiene_retiro_leche_activo` y `tiene_retiro_carne_activo`.
     * `cache_referencia_resumen`: Hierro oficial, catálogo de razas JSON y último snapshot ejecutivo de solo lectura para el Admin.
     * `cola_envios_campo`: Buzón de salida FIFO (`id_cola_uuid`, `tipo_operacion` en `ORDENO | PESAJE | SANIDAD | REPRODUCCION | PARTO_CON_CRIA`, `payload_json`, `fecha_hora_captura_campo`, `estado_envio`).
  3. **Sincronización (`POST /api/v1/campo/sincronizar-lote`):** Al detectar red, el móvil envía los ítems `PENDIENTE` en orden FIFO. El servidor valida idempotencia por `id_cola_uuid`, impacta las tablas centrales, inserta el registro de auditoría en `historial_acciones` con `origen_red = 'OFFLINE_SINCRONIZADO'` y devuelve la caché fresca (`GET /api/v1/campo/cache-inicial`).

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Captura en campo sin señal con encolamiento local FIFO**
  * **Dado que** el teléfono del trabajador se encuentra `"Sin Señal (Modo Campo)"`,
  * **Cuando** registra un ordeño de `10.5 L` para `#042` y un pesaje de `355 Kg` para `#201`,
  * **Entonces** la aplicación valida al animal contra `cache_padron_activo`, inserta ambos eventos en `cola_envios_campo` con `estado_envio = 'PENDIENTE'` y su hora exacta de campo, e incrementa el contador `"🔄 Cola: 2 pend."`.
* **Escenario 2: Vaciado automático de la cola al reconectar y visibilidad inmediata para el Administrador**
  * **Dado que** existen `2` registros pendientes en `cola_envios_campo` del móvil del trabajador,
  * **Cuando** el dispositivo recupera conexión con el Servidor Central,
  * **Entonces** envía el lote en orden cronológico FIFO, vacía la cola pendiente, actualiza el saldo oficial del tanque y pesos en la BD Central, y el Administrador visualiza inmediatamente los nuevos KPIs y los 2 asientos en `"📜 Historial de Acciones"` marcados como `"Offline sincronizado"`.
* **Escenario 3: Bloqueo de operaciones administrativas/comerciales cuando no hay internet**
  * **Dado que** el dispositivo se encuentra `"Sin Señal"`,
  * **Cuando** se intenta ejecutar una Venta de Leche, una Venta en Canal, un Asiento Financiero o un Alta Manual de Inventario,
  * **Entonces** el sistema bloquea la operación e indica que las transacciones comerciales y maestras son `100% Online` contra el Servidor Central.

---

<a id="hu-06"></a>
### 🏷️ Ficha HU-06: Alta Manual de Inventario Inicial y Compras (Exclusivo Admin Online) Separando N° Identificador y Hierro

#### 1. Card (Tarjeta)
* **ID:** `HU-06`
* **Título:** Registro Online de censo inicial y compras diferenciando `numero_identificador` único e `hierro` descriptivo.
* **Prioridad:** Crítica | **Estimación:** 8 Puntos | **Proceso:** 2. Carga Inicial del Inventario
* **Enunciado Clásico:**
  * **Como** Administrador de la finca conectado en línea,
  * **quiero** cargar el inventario inicial y las compras externas ingresando por separado el **N° Identificador** único de cada animal y la **descripción de su Hierro** (propietario/procedencia),
  * **para** individualizar sin ambigüedad a cada ejemplar activo en la Base de Datos Central evitando que en campo se creen animales manuales duplicados.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Separación de Claves en `animales`:**
  * `id_animal` (`UUID` inmutable): Clave primaria interna que preserva relaciones históricas de por vida.
  * `numero_identificador` (`VARCHAR`): Número operativo único entre animales con `estado_actual = 'Activo'` (`idx_unico_numero_animal_activo`).
  * `hierro` (`VARCHAR`): Descripción de iniciales o figura de propiedad/procedencia.
* **Regla de Permisos de Alta:** El endpoint `POST /api/v1/animales` (`origen_incorporacion = 'CARGA_INICIAL' | 'COMPRA_EXTERNA'`) solo acepta peticiones autenticadas con rol `ADMIN` en línea.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Alta manual exitosa por el Administrador en línea**
  * **Dado que** el Administrador está en línea y el número `"112"` está libre en el censo activo,
  * **Cuando** completa `+ Nuevo Animal Manual` con `N° Identificador = "112"`, `Hierro = "Iniciales JM (Media Luna)"`, `Nombre = "Consentida"` y guarda,
  * **Entonces** el Servidor Central crea el registro en `animales`, registra el alta en `historial_acciones` y muestra a `#112` en el padrón activo con su badge de hierro diferenciado.
* **Escenario 2: Rechazo inmediato por N° Identificador duplicado en el padrón activo**
  * **Dado que** el ejemplar `#042` (*Mariposa*) está activo en la Base de Datos Central,
  * **Cuando** el Administrador intenta dar de alta otro animal con `N° Identificador = "042"`,
  * **Entonces** el sistema rechaza el registro e informa que el N° Identificador `#042` ya está ocupado por un animal activo.

---

<a id="hu-07"></a>
### 🏷️ Ficha HU-07: Clasificación por Condiciones Fisiológicas Venezolanas y Estado de Preñez Condicional

#### 1. Card (Tarjeta)
* **ID:** `HU-07`
* **Título:** Clasificación del ganado según etapas fisiológicas de Venezuela y validación condicional de preñez.
* **Prioridad:** Alta | **Estimación:** 8 Puntos | **Proceso:** 2. Carga Inicial del Inventario
* **Enunciado Clásico:**
  * **Como** Administrador o encargado zootécnico,
  * **quiero** clasificar cada animal según su etapa fisiológica real (*Becerro/Becerra, Maute/Mauta, Novillo/Torete, Novilla de vientre, Toro Reproductor, Vaca parida, Vaca escotera, Vaca seca*) e indicar si está **preñada o no** exclusivamente en hembras aptas,
  * **para** organizar el manejo del hato por lotes productivos e impedir inconsistencias biológicas en la base de datos.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Reglas de Integridad Biológica (UI Flutter + Constraint `chk_coherencia_prenez_sexo` en BD Central):**
  * `Macho` (*Becerro, Maute, Novillo / Torete, Toro Reproductor*) y crías/levante hembra (*Becerra, Mauta*) ➔ `esta_prenada = 'NO_APLICA'` (control bloqueado en UI).
  * `Novilla de vientre` y `Vaca parida (Primípara | Multípara)` ➔ `esta_prenada IN ('SI', 'NO')`.
  * `Vaca escotera` y `Vaca seca` ➔ preselecciona y exige `esta_prenada = 'SI'`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Bloqueo automático de preñez al elegir Sexo Macho**
  * **Dado que** el usuario está registrando un animal en el formulario de inventario,
  * **Cuando** selecciona `Sexo = "Macho"`,
  * **Entonces** el selector de Condición Fisiológica filtra únicamente etapas masculinas y el campo `"¿Está Preñada?"` queda bloqueado en `"No aplica (Macho / Cría)"`.
* **Escenario 2: Asignación automática de preñez en Vaca escotera y Vaca seca**
  * **Dado que** el usuario selecciona `Sexo = "Hembra"`,
  * **Cuando** elige `"Vaca escotera"` o `"Vaca seca"`,
  * **Entonces** el sistema establece automáticamente el estado `"🤰 Sí (Preñada)"`.

---

<a id="hu-08"></a>
### 🏷️ Ficha HU-08: Registro de Genealogía por N° Identificador y Consulta de Hoja de Vida Individual

#### 1. Card (Tarjeta)
* **ID:** `HU-08`
* **Título:** Trazabilidad materna y paterna por N° Identificador y expediente consolidado en Hoja de Vida.
* **Prioridad:** Alta | **Estimación:** 5 Puntos | **Proceso:** 2. Carga Inicial del Inventario
* **Enunciado Clásico:**
  * **Como** Administrador o Trabajador de campo,
  * **quiero** vincular la madre y el padre de cada animal mediante su **N° Identificador** (nunca mediante el hierro) y consultar su expediente en una **Hoja de Vida**,
  * **para** verificar la ascendencia exacta de cada res y prevenir cruces consanguíneos.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Modelado Relacional:** En la tabla `animales`, la genealogía almacena tanto la referencia inmutable (`id_madre`, `id_padre`) como el código visible (`madre_numero_ref`, `padre_numero_ref`), garantizando que aunque años después la madre sea vendida en canal y su número se reutilice, el vínculo histórico hacia la madre biológica original permanezca intacto.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Visualización del árbol genealógico por N° Identificador en la Hoja de Vida**
  * **Dado que** la novilla `#108` (*Lucero*) tiene registrada como madre a `#042` (*Mariposa*) y como padre a `#009` (*Titán*),
  * **Cuando** el usuario pulsa `"Hoja de Vida"` sobre `#108`,
  * **Entonces** el modal muestra su N° Identificador `#108`, su Hierro descriptivo, su condición fisiológica y su Árbol Genealógico referenciando a Madre `#042` y Padre `#009`.

---

<a id="hu-09"></a>
### 🏷️ Ficha HU-09: Búsqueda y Filtrado Multicriterio del Censo por Etapa Fisiológica y Preñez

#### 1. Card (Tarjeta)
* **ID:** `HU-09`
* **Título:** Filtros combinados del padrón activo por condición fisiológica y estado de preñez.
* **Prioridad:** Media | **Estimación:** 3 Puntos | **Proceso:** 2. Carga Inicial del Inventario
* **Enunciado Clásico:**
  * **Como** usuario del sistema,
  * **quiero** filtrar el listado del padrón activo por etapa fisiológica y por estado de preñez (*Preñadas vs. Vacías*),
  * **para** consultar rápidamente lotes específicos de manejo en oficina o en corral.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Consultas Indexadas:** En modo Online consulta `GET /api/v1/animales?estado=Activo&etapa=...&prenada=...` apoyado en `idx_animales_etapa_prenez`; en modo Offline del trabajador filtra instantáneamente sobre `cache_padron_activo`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Filtrado rápido de hembras preñadas**
  * **Dado que** el usuario visualiza `"🐄 2. Inventario (Censo)"`,
  * **Cuando** elige `"🤰 Solo Preñadas (Sí)"` en el filtro de preñez,
  * **Entonces** la tabla exhibe únicamente las vacas y novillas activas con estado de gestación positivo.

---

<a id="hu-10"></a>
### 🏷️ Ficha HU-10: Registro de Pesajes Periódicos en Báscula (Online u Offline en Campo) y Cálculo Automático de GDP (`kg/día`)

#### 1. Card (Tarjeta)
* **ID:** `HU-10`
* **Título:** Captura de peso vivo en manga, cálculo automático de Ganancia Diaria de Peso (`GDP`) y semáforo zootécnico.
* **Prioridad:** Alta | **Estimación:** 8 Puntos | **Proceso:** 3. Producción de Carne
* **Enunciado Clásico:**
  * **Como** Trabajador en la manga de pesaje o Administrador,
  * **quiero** ingresar el peso actual de un animal por su **N° Identificador** (con o sin señal) y que el sistema calcule de inmediato su **Ganancia Diaria de Peso (`GDP` en `kg/día`)**,
  * **para** monitorear el rendimiento de levante/ceba y detectar animales estancados en el acto.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Fórmula Zootécnica:**
  $$\text{GDP (kg/día)} = \frac{\text{Peso Actual (kg)} - \text{Peso Previo (kg)}}{\text{Días Transcurridos}}$$
* **Semáforo:** `≥ 0.60 kg/día` ➔ 🟢 **Óptimo** | `0.30 a 0.59 kg/día` ➔ ⚪ **Normal** | `< 0.30 kg/día` ➔ 🔴 **Alerta**.
* **Soporte Dual Online/Offline:** Si hay red, llama a `POST /api/v1/pesajes`, actualiza `animales.peso_actual_kg` y audita en `historial_acciones`. Si no hay red, calcula la referencia local contra `cache_padron_activo.peso_actual_kg` y encola `PESAJE` en `cola_envios_campo`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Registro de pesaje y cálculo automático de GDP**
  * **Dado que** el maute `#201` (*Campeón*) registra un peso previo de `340 Kg`,
  * **Cuando** el operador ingresa `361 Kg` transcurridos `30 días` y pulsa `"Calcular GDP y Guardar"`,
  * **Entonces** el sistema calcula `+0.70 kg/día`, muestra el badge `"🟢 Excelente / Óptimo"`, actualiza el peso de `#201` a `361 Kg` y genera el registro correspondiente para auditoría.

---

<a id="hu-11"></a>
### 🏷️ Ficha HU-11: Registro de Tratamientos Sanitarios (Online u Offline en Campo) y Activación de Tiempos de Retiro

#### 1. Card (Tarjeta)
* **ID:** `HU-11`
* **Título:** Aplicación de medicamentos/vacunas y activación inmediata de cuarentena por retiro en leche y carne.
* **Prioridad:** Crítica (Inocuidad Alimentaria) | **Estimación:** 8 Puntos | **Proceso:** 3. Carne / 4. Leche / Sanidad
* **Enunciado Clásico:**
  * **Como** Trabajador encargado de sanidad o Administrador,
  * **quiero** registrar tratamientos veterinarios indicando sus **días de retiro en leche y en carne**, activando de inmediato la alerta roja incluso si estoy sin señal en el corral,
  * **para** evitar que un ordeñador en el mismo teléfono mezcle leche con antibióticos en el tanque o que el Administrador venda un animal medicado a matadero.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Cálculo de Fechas de Liberación:** `fecha_liberacion_leche = fecha_aplicacion + dias_retiro_leche` y `fecha_liberacion_carne = fecha_aplicacion + dias_retiro_carne`.
* **Protección Preventiva Inmediata Offline:** Si el trabajador registra un antibiótico sin conexión, además de encolar el evento `SANIDAD` en `cola_envios_campo`, la app actualiza instantáneamente las banderas `tiene_retiro_leche_activo = 1` / `tiene_retiro_carne_activo = 1` en `cache_padron_activo` para proteger los ordeños siguientes de esa misma jornada.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Activación inmediata de bloqueo sanitario**
  * **Dado que** la vaca `#042` (*Mariposa*) está libre de medicamentos,
  * **Cuando** se registra `"Oxitetraciclina L.A."` con `5 días` de retiro en leche y `28 días` de retiro en carne y se pulsa `"Guardar Tratamiento y Activar Cuarentena"`,
  * **Entonces** `#042` queda marcada inmediatamente en cuarentena roja para ordeño y canal, y la acción queda registrada con su autor y hora en la bitácora del sistema.

---

<a id="hu-12"></a>
### 🏷️ Ficha HU-12: Liquidación Online de Venta en Canal, Bloqueo Sanitario y Liberación del N° Identificador

#### 1. Card (Tarjeta)
* **ID:** `HU-12`
* **Título:** Beneficio/venta en canal exclusivo para Administrador Online con liberación de `numero_identificador` e ingreso en caja.
* **Prioridad:** Crítica | **Estimación:** 8 Puntos | **Proceso:** 3. Producción de Carne
* **Enunciado Clásico:**
  * **Como** Administrador de la finca conectado en línea,
  * **quiero** liquidar la venta a matadero/frigorífico de un animal libre de retiro ingresando su **Peso Vivo en Báscula (Kg)**, **Precio por Kg (`$`)** y **Destino**,
  * **para** desincorporarlo del censo activo, **liberar su N° Identificador** para futuros becerros, acreditar automáticamente el ingreso en caja y dejar constancia en el historial de auditoría.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Fórmula Limpia de Liquidación:** `monto_total = peso_vivo_kg * precio_kg` (sin campos innecesarios de rendimiento porcentual).
* **Transacción Atómica Cuádruple en BD Central (`POST /api/v1/ventas-canal`, exclusivo `ADMIN` Online):**
  1. Verifica que no exista `fecha_liberacion_carne >= CURRENT_DATE` en `eventos_sanitarios`.
  2. Inserta en `ventas_canal` guardando `numero_identificador_liberado` e `hierro_snapshot`.
  3. Actualiza `animales.estado_actual = 'Vendido_Canal'`, liberando automáticamente `numero_identificador` en el índice único parcial de activos mientras preserva `id_animal` para el historial.
  4. Crea el asiento `Ingreso` en `transacciones_financieras` y el registro inmutable en `historial_acciones`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Bloqueo de venta en canal por retiro sanitario vigente**
  * **Dado que** el ejemplar `#104` mantiene días de retiro en carne activos,
  * **Cuando** el Administrador abre `"🥩 Vender en Canal"` sobre `#104`,
  * **Entonces** el modal exhibe `"🚨 PROHIBIDO EL BENEFICIO SANITARIO"` y mantiene deshabilitado el botón de confirmación.
* **Escenario 2: Liquidación Online exitosa, liberación de N° Identificador, ingreso y auditoría**
  * **Dado que** el Administrador está en línea y el animal `#201` está libre de retiro sanitario,
  * **Cuando** ingresa `Peso Vivo = 420 Kg`, `Precio por Kg = $1.85` (`Total = $777.00`), `Destino = "Frigorífico Ganadero"` y confirma,
  * **Entonces** `#201` pasa a `"🥩 Historial Canal & Ventas"`, el N° Identificador `201` queda libre para nuevas crías, se acredita un ingreso de `$777.00` en `"💰 Financiero"` y se inserta el asiento en `"📜 Historial de Acciones"`.

---

<a id="hu-13"></a>
### 🏷️ Ficha HU-13: Registro de Eventos Reproductivos, Diagnóstico de Preñez y Secado de Vacas

#### 1. Card (Tarjeta)
* **ID:** `HU-13`
* **Título:** Control de servicios, diagnóstico de gestación y transición automática a Vaca Seca.
* **Prioridad:** Alta | **Estimación:** 5 Puntos | **Proceso:** 4. Producción de Leche / Reproducción
* **Enunciado Clásico:**
  * **Como** Trabajador encargado de reproducción o Administrador,
  * **quiero** registrar celos, montas/inseminaciones, diagnósticos de preñez y secados en vacas y novillas (Online u Offline en campo),
  * **para** actualizar automáticamente su estado de preñez y su condición fisiológica (`Vaca escotera` o `Vaca seca`).

#### 2. Conversation (Conversación y Especificación Técnica)
* **Transiciones Automáticas:**
  * `Diagnóstico Preñez` (`Preñada Confirmada`) ➔ `esta_prenada = 'SI'`.
  * `Diagnóstico Preñez` (`Preñada Escotera`) ➔ `condicion_fisiologica = 'Vaca escotera'`, `esta_prenada = 'SI'`.
  * `Diagnóstico Preñez` (`Vacía`) o `Aborto` ➔ `esta_prenada = 'NO'`.
  * `Secado` (~60 días previos al parto) ➔ `condicion_fisiologica = 'Vaca seca'`, `esta_prenada = 'SI'`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Transición automática a Vaca seca**
  * **Dado que** la vaca `#042` está preñada y entra en su período de descanso mamario,
  * **Cuando** se registra el evento `"Secado de Vaca"` para `#042`,
  * **Entonces** su condición fisiológica cambia a `"Vaca seca"` (`Preñada: Sí`) y deja de aparecer en el selector de vacas paridas en ordeño.

---

<a id="hu-14"></a>
### 🏷️ Ficha HU-14: Registro de Parto en Campo con Alta Automática del Becerro/a y Pase de Madre a Vaca Parida

#### 1. Card (Tarjeta)
* **ID:** `HU-14`
* **Título:** Única vía habilitada en campo para incorporar nuevos animales: nacimiento de cría vinculado a la madre y pase a lactancia.
* **Prioridad:** Crítica | **Estimación:** 8 Puntos | **Proceso:** 4. Producción de Leche / Reproducción
* **Enunciado Clásico:**
  * **Como** Trabajador de campo o Administrador,
  * **quiero** que al registrar el **Parto** de una vaca o novilla se despliegue la ficha del recién nacido para asignarle su **N° Identificador**, **Hierro**, nombre, sexo, raza y peso al nacer,
  * **para** incorporar automáticamente al nuevo *Becerro/Becerra* en el Censo vinculado al **N° Identificador de su madre** y habilitar a la madre como **Vaca parida** en ordeño.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Regla de Negocio Aprobada sobre Altas en Campo:** El `Trabajador` no tiene acceso a `+ Nuevo Animal Manual`, pero sí da de alta becerros/as al registrar un `Parto`.
* **Protección contra Colisión Offline (`conflicto_numero_pendiente`):** Si un trabajador sin señal asigna a un recién nacido un `numero_identificador` que fue ocupado minutos antes en el servidor, al sincronizar `PARTO_CON_CRIA` el servidor **no descarta ni pierde el nacimiento**: registra a la cría con un sufijo temporal (`115-PEND`), activa `conflicto_numero_pendiente = TRUE` para que el Administrador reasigne el número definitivo y registra el evento en `historial_acciones`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Parto exitoso con alta automática de cría y pase de madre a Vaca parida**
  * **Dado que** el usuario selecciona a la hembra `#078` (*Rubia*) en `"🧬 Reproducción"` y elige `"Parto (Nacimiento de Cría)"`,
  * **Cuando** ingresa `N° Identificador Cría = "115"`, `Nombre = "Relámpago"`, `Sexo = "Macho"`, `Peso = 35 Kg` y guarda,
  * **Entonces** el sistema incorpora a `#115 Relámpago` en el Censo como `"Becerro"` con `Madre = #078`, cambia a `#078` a `"Vaca parida"` (`Preñada: No`) habilitándola en ordeño y audita la operación en `historial_acciones`.

---

<a id="hu-15"></a>
### 🏷️ Ficha HU-15: Registro de Ordeño Diario (Mañana/Tarde) con Filtro Sanitario de Inocuidad

#### 1. Card (Tarjeta)
* **ID:** `HU-15`
* **Título:** Captura rápida de litros por vaca parida y jornada con desvío automático a descarte si tiene retiro activo.
* **Prioridad:** Crítica | **Estimación:** 8 Puntos | **Proceso:** 4. Producción de Leche
* **Enunciado Clásico:**
  * **Como** ordeñador (`Trabajador`) en vaquera o Administrador,
  * **quiero** registrar los litros ordeñados de cada vaca parida en las jornadas de Mañana y Tarde (con o sin señal),
  * **para** sumar automáticamente la leche apta al tanque de enfriamiento y aislar como **descarte** la leche de vacas con tratamiento médico vigente.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Validación de Inocuidad:** Tanto contra la BD Central (Online) como contra `cache_padron_activo.tiene_retiro_leche_activo` (Offline), si la vaca está en retiro (`#104`), el formulario muestra alerta roja inmediata y marca `destino_leche = 'DESCARTE_RETIRO'`, impidiendo que sume a `leche_disponible_tanque`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Ordeño de vaca sana incrementa el tanque comercial**
  * **Dado que** el tanque central dispone de `342.5 L` y la vaca `#042` está libre de retiro sanitario,
  * **Cuando** se registra un ordeño de `"10.5 L"` en jornada `"Mañana"` para `#042` en línea (o tras sincronizar la cola de campo),
  * **Entonces** el saldo del tanque sube a `353.0 L` y el registro figura como `"✅ Sumó a Tanque"`.
* **Escenario 2: Ordeño de vaca medicada se aísla en descarte sanitario**
  * **Dado que** la vaca `#104` (*Canela*) tiene retiro sanitario en leche activo,
  * **Cuando** el trabajador selecciona `#104` y registra `"8.0 L"`,
  * **Entonces** la pantalla muestra la alerta roja de retiro activo, suma `8.0 L` a `"⚠️ Descarte por Retiro"` y conserva intacto el saldo comercial del tanque.

---

<a id="hu-16"></a>
### 🏷️ Ficha HU-16: Gestión del Tanque de Enfriamiento y Despacho / Venta Comercial de Leche (Exclusivo Admin Online)

#### 1. Card (Tarjeta)
* **ID:** `HU-16`
* **Título:** Liquidación Online de despacho de leche a quesera/receptoría con descuento de tanque e ingreso en caja.
* **Prioridad:** Alta | **Estimación:** 5 Puntos | **Proceso:** 4. Producción de Leche
* **Enunciado Clásico:**
  * **Como** Administrador de la finca conectado en línea,
  * **quiero** registrar la venta de leche del tanque indicando litros despachados, precio por litro (`$`) y comprador,
  * **para** descontar con exactitud el stock del tanque central, acreditar el cobro en el módulo financiero y dejar trazabilidad en el historial de acciones.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Control Centralizado de Stock (`POST /api/v1/ventas-leche`):** Exclusivo para `ADMIN` en modo `Online`. Valida `litros_despachados <= configuracion_finca.leche_disponible_tanque`, descuenta el saldo, crea el asiento en `ventas_leche` y `transacciones_financieras`, y audita en `historial_acciones`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Despacho exitoso de leche del tanque**
  * **Dado que** el Administrador está en línea y el tanque tiene `342.5 L` disponibles,
  * **Cuando** registra una venta de `200 L` a `$0.45 / L` para `"Quesera Don Pedro"`,
  * **Entonces** el tanque queda en `142.5 L`, se acredita un ingreso automático de `$90.00` en `"💰 Financiero"` y se registra la operación en `"📜 Historial de Acciones"`.
* **Escenario 2: Bloqueo por volumen superior al disponible en tanque**
  * **Dado que** el saldo del tanque es `142.5 L`,
  * **Cuando** el Administrador intenta despachar `200 L`,
  * **Entonces** el sistema rechaza la operación advirtiendo que supera la existencia disponible en el tanque.

---

<a id="hu-17"></a>
### 🏷️ Ficha HU-17: Registro Online de Transacciones Financieras, Flujo de Caja y Costo Directo por Litro (`$/L`)

#### 1. Card (Tarjeta)
* **ID:** `HU-17`
* **Título:** Libro de caja operativo Online (ingresos/egresos), margen bruto y costo directo estimado por litro de leche.
* **Prioridad:** Media | **Estimación:** 5 Puntos | **Proceso:** Transversal (Módulo Financiero)
* **Enunciado Clásico:**
  * **Como** Administrador de la finca conectado en línea,
  * **quiero** registrar gastos operativos (alimentación, medicinas, jornales, mantenimiento) y consultarlos junto a los ingresos automáticos por venta de leche y canal,
  * **para** conocer al instante la utilidad neta en caja, el margen bruto (%) y el **costo directo estimado por litro de leche producido (`$/L`)**.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Cálculos Centralizados (`GET / POST /api/v1/finanzas`):**
  * $\text{Utilidad Neta} = \sum \text{Ingresos} - \sum \text{Egresos}$
  * $\text{Margen Bruto (\%)} = \left(\frac{\text{Utilidad Neta}}{\sum \text{Ingresos}}\right) \times 100$
  * $\text{Costo Directo por Litro (\$/L)} = \frac{\sum \text{Egresos Operativos}}{\text{Total Litros Producidos Acumulados}}$
* Toda transacción manual o automática queda vinculada y auditada en `historial_acciones`.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Registro de gasto operativo y recálculo inmediato de rentabilidad**
  * **Dado que** el Administrador está en línea dentro de `"💰 Financiero"`,
  * **Cuando** registra un `"Egreso (-)"` en `"Alimentación / Sal"` por `"$50.00"` y presiona `"Registrar Asiento"`,
  * **Entonces** el asiento se guarda en la BD Central, se recalculan Egresos, Margen de Caja y Costo Estimado por Litro, y se añade la acción en `"📜 Historial de Acciones"`.

---

<a id="hu-18"></a>
### 🏷️ Ficha HU-18: Terminal Ligera de Carga de Datos en Campo para el Trabajador (`📱 Terminal de Carga`)

#### 1. Card (Tarjeta)
* **ID:** `HU-18`
* **Título:** Interfaz minimalista de campo con 4 tarjetas de captura rápida, buscador en corral y monitor de cola offline.
* **Prioridad:** Alta | **Estimación:** 5 Puntos | **Proceso:** Experiencia Trabajador (Propuesta A)
* **Enunciado Clásico:**
  * **Como** Trabajador de campo (`Operador`),
  * **quiero** contar con una pantalla principal simplificada con **4 tarjetas táctiles grandes** (*Ordeño, Pesaje, Sanidad, Reproducción/Parto*), un **buscador instantáneo por N° Identificador** y el **buzón de mi cola offline**,
  * **para** registrar mi trabajo bajo el sol del corral en menos de 3 toques y verificar al instante si una res tiene retiro sanitario activo aunque no haya internet.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Componentes de `FieldTerminalScreen` (`#view-campo`):**
  1. Grid de 4 tarjetas de `>= 56px` de alto táctil que abren directamente los formularios operativos limpios de botones administrativos.
  2. Buscador instantáneo (`buscarAnimalRapidoCampo`) sobre `cache_padron_activo` que devuelve al escribir el `numero_identificador` la ficha resumida y el badge `🚨 EN RETIRO SANITARIO ACTIVO` o `✅ Libre de Retiro`.
  3. Tabla en vivo de `cola_envios_campo` mostrando hora real de captura en campo, módulo, animal y botón de sincronización.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Consulta instantánea de semáforo sanitario en corral sin internet**
  * **Dado que** el trabajador está en `"📱 Terminal de Carga"` con el teléfono `"Sin Señal"`,
  * **Cuando** digita `"104"` en el buscador rápido de corral,
  * **Entonces** la pantalla muestra de inmediato la ficha de `#104 Canela` con la alerta roja `"🚨 EN RETIRO SANITARIO ACTIVO"` leída desde la caché local.

---

<a id="hu-19"></a>
### 🏷️ Ficha HU-19: Vista Rápida Ejecutiva del Administrador (`📊 Vista Rápida (Admin)`), KPIs y Semáforo de Alertas

#### 1. Card (Tarjeta)
* **ID:** `HU-19`
* **Título:** Tablero móvil de lectura ejecutiva inmediata para el Administrador.
* **Prioridad:** Alta | **Estimación:** 5 Puntos | **Proceso:** Experiencia Administrador (Propuesta A)
* **Enunciado Clásico:**
  * **Como** Administrador que usa el teléfono principalmente para supervisar el estado de la finca de forma rápida,
  * **quiero** abrir una **Vista Rápida Ejecutiva** con el saldo del tanque, el censo activo, las vacas en retiro sanitario, la utilidad en caja, las alertas críticas y las últimas acciones realizadas en la finca,
  * **para** enterarme en segundos de lo que ocurre en mi unidad de producción sin navegar por múltiples tablas.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Consulta Consolidada (`GET /api/v1/resumen-ejecutivo`):** Devuelve en una sola respuesta ligera los 4 KPIs maestros, alertas sanitarias/reproductivas activas, últimos ordeños del día y las últimas 4 entradas de `historial_acciones`. Guarda copia en `cache_referencia_resumen.resumen_ejecutivo_json` para lectura rápida si el Admin abre la app en un trayecto sin cobertura.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Actualización inmediata de la Vista Rápida tras sincronización de campo**
  * **Dado que** un trabajador sincroniza nuevos ordeños y un tratamiento sanitario al Servidor Central,
  * **Cuando** el Administrador abre `"📊 Vista Rápida (Admin)"`,
  * **Entonces** visualiza actualizados los litros disponibles en tanque, el contador de retiro sanitario, la tabla de últimos ordeños y las últimas acciones registradas con el nombre del trabajador.

---

<a id="hu-20"></a>
### 🏷️ Ficha HU-20: Historial General Inmutable de Acciones y Bitácora de Auditoría (`📜 Historial de Acciones`)

#### 1. Card (Tarjeta)
* **ID:** `HU-20`
* **Título:** Bitácora cronológica inmutable de auditoría de todas las acciones del Administrador y los Trabajadores.
* **Prioridad:** Crítica (Gobernanza y Trazabilidad) | **Estimación:** 8 Puntos | **Proceso:** Transversal (Exclusivo Administrador)
* **Enunciado Clásico:**
  * **Como** Administrador de la finca,
  * **quiero** tener acceso exclusivo a un **Historial General de Acciones** inmutable donde quede registrado automáticamente cada cambio u operación realizada tanto por mí como por cualquier trabajador de campo,
  * **para** auditar quién hizo qué, sobre qué animal o módulo, con qué valores, si se originó en línea o sin señal, y a qué hora exacta ocurrió en campo frente a la hora en que llegó al servidor.

#### 2. Conversation (Conversación y Especificación Técnica)
* **Inmutabilidad (*Append-Only* en `historial_acciones`):**
  * La tabla `historial_acciones` en la Base de Datos Central **solo admite `INSERT` y `SELECT`**; no existe ningún endpoint ni botón para editar o eliminar registros de auditoría.
  * Toda mutación en los 11 flujos del sistema (*Configuración, Nueva Raza, Alta Animal, Pesaje, Tratamiento Sanitario, Venta en Canal, Evento Reproductivo, Parto con Cría, Ordeño, Venta de Leche y Transacción Financiera*) dispara atómicamente la inserción de un registro en `historial_acciones`.
* **Campos Clave y Filtros (`GET /api/v1/historial-acciones`):**
  * Muestra `id_auditoria`, `usuario_nombre`, `usuario_rol` (`Administrador` / `Operador`), `modulo`, `accion`, `entidad_referencia` (ej. `#104 Canela`), `descripcion_cambio` (y snapshots JSON en BD), `origen_red` (`Online` vs. `Offline sincronizado`), **`fecha_hora_accion_campo`** y **`fecha_hora_registro_servidor`**.
  * Incluye 4 KPIs de conteo (*Total*, *Por Administrador*, *Por Trabajador*, *Vía Cola Offline*) y filtros combinados por Rol, Módulo, Origen de Red y búsqueda de texto libre.

#### 3. Confirmation (Confirmación y Criterios de Aceptación BDD)
* **Escenario 1: Registro automático de auditoría en operaciones Online y Offline sincronizadas**
  * **Dado que** un trabajador captura un pesaje sin señal a las `07:15 AM` y su teléfono lo sincroniza a las `11:40 AM`, y luego el Administrador registra una venta de leche en línea a las `12:10 PM`,
  * **Cuando** el Administrador abre `"📜 Historial de Acciones"`,
  * **Entonces** visualiza ambos registros ordenados cronológicamente: la venta de leche marcada como `"Online"` por `"Administrador"`, y el pesaje marcado como `"Offline sincronizado"` por `"Trabajador"` exhibiendo tanto la hora real de campo (`07:15 AM`) como la hora de recepción en servidor (`11:40 AM`).
* **Escenario 2: Filtrado multicriterio y restricción de acceso por rol**
  * **Dado que** existen múltiples acciones en `"📜 Historial de Acciones"`,
  * **Cuando** el Administrador filtra por `Rol = "Solo Trabajador / Operador"` y `Origen = "Offline sincronizado"`,
  * **Entonces** la tabla muestra exclusivamente los eventos capturados sin señal por personal de campo; y cuando la sesión cambia a `Rol: Trabajador`, el módulo `"📜 Historial de Acciones"` permanece completamente oculto e inaccesible.
