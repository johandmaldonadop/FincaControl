# 📖 Manual de Funcionamiento y Especificación de Módulos: FincaControl
> **Sistema Integral de Gestión Ganadera para Fincas de Doble Propósito (Leche y Carne)**  
> **Equipo de Desarrollo:** Johan Maldonado – José Chacón  
> **Ubicación del Prototipo:** [`./prototipo/index.html`](./prototipo/index.html)

---

<a id="indice"></a>
## 📑 Índice General

Haga clic en cualquiera de las secciones para consultar su descripción técnica y operativa:

1. [🎯 Objetivo y Alcance del Proyecto](#objetivo-alcance)
   * [1.1. Propósito y Declaración del Problema](#proposito-problema)
   * [1.2. Declaración de Visión del Producto](#vision-producto)
   * [1.3. Objetivo General y Objetivos Específicos](#objetivos-proyecto)
   * [1.4. Alcance del Proyecto (Dentro y Fuera de Alcance)](#alcance-proyecto)
   * [1.5. Atributos de Calidad y Criterios Arquitectónicos](#criterios-calidad)
2. [Módulo 1: Tablero General (Dashboard) y Arquitectura Base](#modulo-1-dashboard)
3. [Módulo 2: Censo e Inventario Bovino (`Animal`), Condiciones Fisiológicas y Beneficio en Canal](#modulo-2-censo-canal)
4. [Módulo 3: Control de Ordeño y Gestión del Tanque de Leche (`RegistroOrdeno`)](#modulo-3-ordeno-tanque)
5. [Módulo 4: Pesajes, Carne y Ganancia Diaria de Peso (`RegistroPesaje`)](#modulo-4-pesaje-carne)
6. [Módulo 5: Sanidad Animal y Tiempos de Retiro (`EventoSanitario`)](#modulo-5-sanidad-retiros)
7. [Módulo 6: Gestión Reproductiva y Alta Completa de Crías (`EventoReproductivo`)](#modulo-6-reproduccion)
8. [Módulo 7: Financiero Operativo y Costos Directos (`TransaccionFinanciera`)](#modulo-7-finanzas)
9. [Ciclo de Vida del Número Identificador, Hierro y Matriz de Interconexión](#matriz-interconexion)

---

<a id="objetivo-alcance"></a>
## 🎯 Objetivo y Alcance del Proyecto

<a id="proposito-problema"></a>
### 1.1. Propósito y Declaración del Problema

* **Nombre del Proyecto:** FincaControl
* **El Problema:** En las fincas ganaderas productoras de doble propósito (producción combinada de leche y carne), comúnmente se carece de mecanismos formales y ágiles para llevar una trazabilidad ordenada de los animales y de los eventos productivos. La gestión descansa casi exclusivamente en registros físicos sobre papel, cuadernos o libretas de vaquería. Esta práctica genera:
  1. Dificultad extrema para acceder a la información histórica, condición fisiológica y estado reproductivo real de la finca en el momento oportuno.
  2. Alta propensión a pérdidas de datos, deterioros físicos por humedad o barro en el corral, y errores de transcripción.
  3. Falta de control sobre los tiempos de retiro de medicamentos veterinarios, poniendo en riesgo la inocuidad alimentaria de la leche y la carne.
  4. Pérdida de rentabilidad al no poder cruzar costos directos operativos con los rendimientos individuales por animal.
* **Solución Propuesta:** **FincaControl** es una solución de software tipo aplicación móvil con arquitectura *Offline-First* diseñada para llevar el control integral de la explotación ganadera venezolana: inventario bovino con distinción entre **Número Identificador** e **Hierro de propiedad/procedencia**, catálogo extensible de razas, clasificación por **condiciones fisiológicas** y estado de **preñez**, trazabilidad genealógica por número identificador, partos y nacimientos, monitoreo del ordeño diario, pesajes periódicos de carne, semáforo de inocuidad sanitaria y finanzas operativas de caja.

---

<a id="vision-producto"></a>
### 1.2. Declaración de Visión del Producto

* **Para:** Pequeños y medianos productores, encargados y propietarios de fincas ganaderas de doble propósito.
* **Que necesitan:** Centralizar el historial productivo, sanitario y financiero de su finca para optimizar la toma de decisiones zootécnicas y maximizar la rentabilidad del negocio.
* **FincaControl:** Es una aplicación móvil especializada en gestión ganadera de doble propósito.
* **Que permite:** Registrar el ganado en campo, clasificarlo por etapa fisiológica y preñez, monitorear la producción lechera y el crecimiento cárnico en tiempo real, prevenir riesgos sanitarios mediante alertas visuales e integrar métricas financieras para un control total.
* **A diferencia de:** Los registros en físico propensos a extravío y las hojas de cálculo convencionales que requieren conectividad constante a internet y resultan complejas de operar en un corral.
* **Nuestro Producto:** Ofrece una interfaz intuitiva, minimalista, de alto contraste y adaptada a la luz solar exterior, con la capacidad distintiva de **operatividad continua 100% sin conexión a internet (Offline-First)**.

---

<a id="objetivos-proyecto"></a>
### 1.3. Objetivo General y Objetivos Específicos

#### 🏆 Objetivo General
Permitir que las fincas ganaderas de doble propósito transformen su recolección de datos operativos pasando del registro físico tradicional en papel a un sistema digital integrado, facilitando un control preciso de la productividad individual por animal (leche y carne), su clasificación fisiológica, la trazabilidad genealógica y la rentabilidad financiera en tiempo real.

#### 🎯 Objetivos Específicos
1. **Digitalizar el Censo, Condiciones Fisiológicas y Genealogía:** Estandarizar el registro individual de cada bovino separando su **Número Identificador (`ID_Numero`)** de la descripción de su **Hierro (`Hierro`)** de propiedad y procedencia; permitir el registro personalizado y persistente de **razas**; clasificar a cada ejemplar según su **condición fisiológica** (*Becerro/a, Maute/a, Novillo/Novilla, Toro Reproductor, Vaca parida, Vaca escotera, Vaca seca*) e indicar si está **preñada o no** (en caso de hembras reproductoras), consolidando su árbol genealógico mediante el número identificador de la madre y el padre para prevenir la consanguinidad.
2. **Optimizar el Control de Producción:** Proveer mecanismos de carga rápida para registrar la producción lechera diaria por jornadas (mañana/tarde), gestionar el inventario del tanque de leche disponible y controlar los pesajes periódicos con cálculo automático de Ganancia Diaria de Peso ($\text{GDP}$).
3. **Salvaguardar la Inocuidad y Bioseguridad:** Implementar un semáforo sanitario estricto que calcule automáticamente los **Tiempos de Retiro** de fármacos veterinarios, bloqueando la comercialización de leche contaminada y prohibiendo el beneficio en canal de animales medicados.
4. **Sistematizar el Ciclo Reproductivo:** Registrar celos, servicios y diagnósticos de gestación actualizando automáticamente la condición fisiológica y el estado de preñez de la vaca/novilla, emitiendo alertas preventivas de secado y automatizando el alta oficial de las nuevas crías en el censo al momento del parto vinculadas al número identificador de la madre.
5. **Calcular la Rentabilidad Operativa:** Registrar los ingresos por despacho de leche y beneficio en canal junto con los egresos cotidianos de la finca, estimando el costo directo real por litro de leche producido ($\text{\$/L}$).
6. **Asegurar la Disponibilidad en Campo:** Implementar un esquema de almacenamiento local seguro que garantice el uso de la aplicación en áreas rurales sin cobertura de datos móviles o internet.

---

<a id="alcance-proyecto"></a>
### 1.4. Alcance del Proyecto (Dentro y Fuera de Alcance)

#### 📋 Dentro del Alcance (In Scope)
* **Gestión de Inventario, Razas, Condiciones Fisiológicas y Genealogía:**
  * Alta de bovinos con **Número Identificador único (`ID_Numero`)**, **Descripción del Hierro (`Hierro`)** (iniciales o figura que indica propietario y procedencia), nombre/alias, sexo, raza y propósito.
  * **Catálogo Personalizable de Razas:** Incluye razas predeterminadas y permite al usuario registrar nuevas razas que quedan guardadas permanentemente para registrar a otros animales.
  * **Clasificación por Condiciones Fisiológicas y Estado de Preñez:** Registro de la etapa del animal (*Becerro/Becerra*, *Maute/Mauta*, *Novillo/Novilla*, *Toro Reproductor*, *Vaca parida*, *Vaca escotera*, *Vaca seca*) e indicador de si está **Preñada (`Sí / No`)** exclusivo para hembras reproductoras (vacas y novillas).
  * Hoja de vida digital individual con histórico productivo, sanitario y genealógico referenciando a la **Madre** y al **Padre** por su **Número Identificador (`#ID_Numero`)**.
  * Desincorporación de animales por venta o beneficio en canal con **liberación formal del Número Identificador** para su reutilización en nuevas crías.
* **Control de Producción de Doble Propósito:**
  * Registro de ordeño diario individual y masivo por jornadas (Mañana/Tarde).
  * Control del volumen disponible en el tanque de leche enfriada y registro de ventas/despachos a centros de acopio.
  * Registro de pesajes en báscula con cálculo automático de Ganancia Diaria de Peso ($\text{GDP}$ en kg/día) y calificación de desempeño zootécnico.
* **Gestión Sanitaria y Tiempos de Retiro:**
  * Registro de vacunaciones oficiales, desparasitaciones y tratamientos antibióticos.
  * Vademécum básico referencial y cálculo automático de fechas de liberación.
  * Semáforo de advertencia roja con bloqueo preventivo en ordeño (leche a descarte) y en ventas a matadero.
* **Gestión Reproductiva y Ciclo de Cría:**
  * Registro cronológico de celos, servicios (inseminación o monta natural con toro) y palpaciones con actualización automática del estado de preñez y condición fisiológica de la hembra.
  * Alertas automáticas de secado (~60 días antes del parto estimado).
  * Registro de partos con formulario integral que da de alta al nuevo becerro/becerra en el censo (N° Identificador, descripción del hierro, nombre, raza con opción de crear nueva, sexo, condición fisiológica inicial *Becerro/Becerra*, peso al nacer y madre asignada por el N° Identificador de la vaca parida).
* **Módulo Financiero Operativo:**
  * Libro de caja simplificado con acreditación automática de ventas de leche y ganado en canal.
  * Registro de egresos operacionales (concentrado, sal, medicamentos, jornales, combustible).
  * Cálculo en tiempo real de utilidad de caja, margen operativo y costo directo por litro de leche.
* **Arquitectura Offline-First:**
  * Persistencia en base de datos local relacional (SQLite / LocalStorage) para funcionamiento sin cobertura celular.
  * Cola de sincronización en segundo plano con control de acceso basado en roles (`Administrador` vs. `Operador`).

#### 🚫 Fuera del Alcance (Out of Scope)
* **Contabilidad Fiscal y Tributaria Compleja:** No incluye módulos de facturación electrónica bajo normativas de entes tributarios gubernamentales específicos (ej. SENIAT, DIAN, SAT) ni declaraciones de impuestos formales.
* **Marketplace y Pasarelas de Pago Externas:** No contempla comercio electrónico público abierto a terceros, subastas ganaderas virtuales ni pasarelas de pago bancarias integradas.
* **Otras Especies o Explotaciones Agropecuarias:** Diseñado exclusivamente para ganado bovino de doble propósito (leche y carne); no está adaptado para porcicultura, avicultura, ovinos ni agricultura de cosechas extensivas.
* **Hardware Especializado de Automatización:** No incluye integración directa mediante protocolos propietarios con básculas electrónicas industriales, sensores de collares IoT ni ordeñadoras mecánicas automatizadas con telemetría en tiempo real (la captura se realiza mediante teclado táctil optimizado en el dispositivo móvil).

---

<a id="criterios-calidad"></a>
### 1.5. Atributos de Calidad y Criterios Arquitectónicos

1. **Disponibilidad Continua (Enfoque Offline-First):** La aplicación debe funcionar sin degradación en ausencia de señal de red. Todas las escrituras y lecturas se resuelven contra la base de datos local.
2. **Rendimiento y Usabilidad Ergonómica en Campo:** Pantallas con contraste optimizado para luz solar intensa, tipografía legible (`Inter`), controles táctiles mínimos de **48 px** e interfaces de captura rápida en menos de tres toques por animal.
3. **Integridad y Trazabilidad Sanitaria:** La lógica de negocio prioriza la inocuidad alimentaria, impidiendo que animales bajo tratamiento médico descarguen leche al tanque comercial o sean enviados a beneficio en canal.
4. **Seguridad y Control de Acceso (RBAC):** Separación estricta de perfiles: el rol `Operador` registra datos técnicos de vaquería sin acceso a costos, ingresos o balances de dinero; el rol `Administrador` posee acceso total.
5. **Escalabilidad del Modelo de Datos:** Estructura modular relacional capaz de soportar el crecimiento del censo desde hatos pequeños (20 cabezas) hasta medianos y grandes productores (más de 1.000 cabezas).

---

[⬆ Volver al Índice](#indice)

---

<a id="modulo-1-dashboard"></a>
## 2. Módulo 1: Tablero General (Dashboard), Arquitectura Base (Flutter + SQLite) y Sincronización Backend

### 🎯 Propósito
Consolidar el estado productivo, sanitario y financiero de la finca en una sola pantalla de alta visibilidad y establecer la arquitectura técnica **Offline-First** basada en **Flutter + SQLite local** sincronizada con un **Backend API REST + Base de Datos Central**. Esto permite que el trabajador de campo registre datos durante toda su jornada sin conexión a internet y que, al recuperar señal, la información se sincronice automáticamente para que el Administrador pueda visualizarla y auditarla.

### ⚙️ Funcionamiento Operativo y Arquitectura de Datos
1. **Tarjetas de Métricas en Tiempo Real (KPIs):**
   * **Disponible en Tanque:** Muestra el volumen acumulado de leche apta para venta comercial (descontando ventas y descartes).
   * **Rebaño Activo:** Censo de animales vivos en producción, indicando cuántas hembras están preñadas y cuántas reses han sido desincorporadas por venta en canal.
   * **Retiro Sanitario:** Alerta roja con la cantidad de vacas bajo tratamiento médico cuya leche o carne no puede comercializarse.
   * **Utilidad en Caja:** Saldo neto en efectivo (Ingresos totales - Egresos operativos).
2. **Widget de Entrada Rápida en Vaquera:**
   * Diseñado con campos destacados de alto contraste (`2px solid #94A3B8`, foco expansivo y altura táctil de 48px).
   * Permite ingresar el **N° Identificador del animal** (`Ej: 104, 042`), jornada (Mañana/Tarde) y litros producidos.
   * **Validación instantánea:** Si se introduce el N° Identificador de una vaca en tratamiento, el formulario muestra una alerta roja advirtiendo que su producción irá a descarte y no sumará al tanque comercial.
3. **Semáforo de Alertas Prioritarias:**
   * Muestra notificaciones críticas agrupadas por urgencia:
     * 🔴 *Alerta Roja:* Animales con tiempo de retiro activo (con fecha exacta de fin de carencia).
     * 🟡 *Alerta Ámbar:* Vacas preñadas que cumplen ~220 días de gestación para programar secado inmediato (pase a condición *Vaca seca*).
4. **Arquitectura Móvil en Flutter + Base de Datos Local SQLite (Offline-First):**
   * **Persistencia Local durante la Jornada del Trabajador:** La aplicación móvil desarrollada en **Flutter** utiliza **SQLite (`sqflite` / `drift`)** como motor relacional local con 12 tablas normalizadas (`configuracion_finca`, `usuarios`, `catalogo_razas`, `animales`, `registros_pesaje`, `ventas_canal`, `registros_ordeno`, `ventas_leche`, `eventos_sanitarios`, `eventos_reproductivos`, `transacciones_financieras` y `sync_queue`).
   * Cada registro capturado por el trabajador durante su jornada en el potrero o vaquera se almacena inmediatamente en SQLite (`< 50 ms`) con llave primaria `UUID v4` y encola un delta en `sync_queue` (`status = 'PENDING'`).
5. **Sincronización Delta con el Backend (API REST) para el Administrador:**
   * Cuando el dispositivo móvil del trabajador recupera conexión a internet (WiFi o datos móviles), el servicio `SyncEngine` envía los lotes pendientes al endpoint `POST /api/v1/sync/push` del Backend y descarga novedades mediante `GET /api/v1/sync/pull`.
   * El **Administrador** recibe automáticamente las actualizaciones desde la base de datos central del servidor, contando con visibilidad completa de la jornada de trabajo.
6. **Selector de Rol (RBAC):**
   * Alterna entre `Administrador` y `Operador`. Los operadores registran toda la actividad de campo pero tienen restringido el acceso a balances financieros y configuración de precios.

[⬆ Volver al Índice](#indice)

---

<a id="modulo-2-censo-canal"></a>
## 3. Módulo 2: Censo e Inventario Bovino (`Animal`), Condiciones Fisiológicas y Beneficio en Canal

### 🎯 Propósito
Gestionar el padrón oficial de animales de la finca separando el **Número Identificador** individual de la marca del **Hierro** (propietario/procedencia), administrar un catálogo extensible de **razas**, clasificar el ganado según sus **condiciones fisiológicas** y estado de **preñez**, preservar la genealogía por número identificador y gestionar el beneficio en canal liberando el número identificador para nuevas generaciones.

### 🐄 Etapas y Clasificación del Ganado Bovino en Venezuela
El sistema clasifica y valida cada ejemplar según las etapas zootécnicas del hato venezolano:
* **Becerro / Becerra:** Desde el nacimiento hasta el destete (aproximadamente entre los 4 y 10 meses de edad), con un peso que oscila entre los 150 kg y 200 kg. Dependen inicialmente de la leche materna y el calostro, transitando gradualmente hacia el consumo de pastos y concentrados.
* **Maute / Mauta:** Animales jóvenes que van desde los 10 hasta los 18 meses de edad, alcanzando un peso aproximado de 350 kg. Corresponde a la fase de levante o crecimiento intermedio tras el destete.
* **Novillo / Novilla:** Desde los 18 meses hasta alcanzar el peso mínimo requerido para la venta, el engorde final o la reproducción (aproximadamente 400 kg o más). En las hembras, las destinadas a reproducción suelen llamarse *novillas de vientre*.
* **Toro / Toro Reproductor:** Macho adulto destinado a la monta o reproducción, generalmente incorporado a partir de los 30 meses de vida con pesos superiores a los 425 kg.
* **Vaca:** Hembra en etapa adulta (tras su primer parto). Según su estado productivo y reproductivo en el hato venezolano, se clasifica en:
  * **Vaca parida:** Aquella que ha tenido su cría y está en lactancia (*primípara* si es su primer parto, o *multípara* si acumula varios).
  * **Vaca escotera:** Vaca que se encuentra preñada pero no está produciendo leche en ese momento.
  * **Vaca seca:** Aquella que ha finalizado su periodo de lactancia y se encuentra en el último tercio de gestación antes del siguiente parto.

### ⚙️ Funcionamiento Operativo
1. **Separación entre Número Identificador (`ID_Numero`) y Hierro (`Hierro`):**
   * **N° Identificador del Animal:** Es el código numérico único asignado a cada ejemplar dentro del rebaño activo (`#042`, `#104`, `#201`). Se utiliza para identificar al animal en todas las operaciones y para registrar quién es la **Madre (`#ID_Numero`)** y el **Padre (`#ID_Numero`)**.
   * **Hierro (Propietario / Procedencia):** En Venezuela el hierro indica la propiedad y procedencia del animal, y con frecuencia no es un número sino iniciales, letras o una figura. Por ello se registra como una **descripción del hierro** (*Ej: "Hda. La Esperanza (HE)", "Iniciales JM", "Herradura con estrella"*).
2. **Catálogo Personalizable de Razas:**
   * Además de las razas cargadas por defecto (*Gyr Mestizo*, *Carora F1*, *Brahman*, *Guzerá*, *Pardo Suizo*, *Senepol*, *Romosinuano*), el usuario puede presionar **`+ Nueva Raza`** para registrar cualquier raza o cruce personalizado (*Ej: Girolando F1, Carora Puro, Nelore*). La nueva raza queda guardada automáticamente en el catálogo del sistema para poder seleccionarla al registrar otros animales o crías.
3. **Condición Fisiológica y Estado de Preñez:**
   * Al elegir el **Sexo** del animal, el formulario filtra automáticamente las condiciones fisiológicas válidas (*Macho*: Becerro, Maute, Novillo / Torete, Toro Reproductor; *Hembra*: Becerra, Mauta, Novilla de vientre, Vaca parida, Vaca escotera, Vaca seca).
   * El campo **¿Está Preñada? (`Sí / No`)** solo se habilita cuando el animal es una hembra en edad reproductiva (*Novilla de vientre* o *Vaca*). En machos (toros, novillos, mautes, becerros) o becerras/mautas, el sistema lo deshabilita y registra como *"No aplica"*.
4. **Hoja de Vida Individual (Modal Interactivo):**
   * Al presionar **"Hoja de Vida"**, se despliega el expediente completo de la res:
     * **N° Identificador**, **Descripción del Hierro (Propietario/Procedencia)**, **Condición Fisiológica**, **Estado de Preñez**, raza, propósito y último peso registrado.
     * **Árbol de Genealogía Directa:** Madre (`#ID_Numero`) y Padre (`#ID_Numero`) referenciados por su número identificador individual con validación de consanguinidad.
     * **Historial Consolidado:** Último ordeño, último pesaje con GDP y estado sanitario actual.
5. **Beneficio en Canal y Desincorporación por Carne:**
   * Cada fila cuenta con el botón **"🥩 Vender en Canal"**:
     * **Control de Inocuidad Obligatorio:** Si la res tiene un tratamiento médico con *Retiro de Carne Activo*, el sistema **bloquea el botón de confirmación** y emite una alerta roja prohibiendo el beneficio hasta que venza el plazo residual.
     * **Captura de Liquidación:** Solicita Peso Vivo en báscula (Kg), Precio por Kg ($), Fecha y Comprador/Frigorífico.
     * **Efectos al Confirmar:**
       1. **Desincorpora el animal del rebaño activo:** Ya no figura en listas de ordeño, pesaje o reproducción.
       2. **Libera el Número Identificador del Animal:** El `ID_Numero` queda formalmente desocupado en el inventario activo, permitiendo que sea asignado a un nuevo becerro recién nacido.
       3. **Archivo en el Historial de Canal:** Pasa a la sub-pestaña *"🥩 Historial Canal & Ventas"* conservando tanto su N° Identificador liberado como la descripción de su Hierro.
       4. **Ingreso Automático en Finanzas:** Registra el cobro en el libro de caja dentro de la categoría *"Venta de Ganado / Canal"*.

[⬆ Volver al Índice](#indice)

---

<a id="modulo-3-ordeno-tanque"></a>
## 4. Módulo 3: Control de Ordeño y Gestión del Tanque de Leche (`RegistroOrdeno`)

### 🎯 Propósito
Registrar la producción lechera diaria, resguardar la inocuidad alimentaria controlando descartes médicos y gestionar el inventario del tanque de enfriamiento para su despacho comercial.

### ⚙️ Funcionamiento Operativo
1. **Control de Tanque de Leche:**
   * **Leche Disponible en Tanque:** Saldo neto de litros aptos almacenados.
   * **Ordeñado Hoy (Apto):** Volumen ordeñado durante la jornada que cumplió con las normas sanitarias.
   * **Descarte por Retiro:** Litros producidos por vacas medicadas. Se contabilizan para evaluar la ubre, pero **no ingresan al tanque comercial**.
2. **Formulario de Registro de Ordeño:**
   * Selección de vaca por su **N° Identificador**, jornada (Mañana/Tarde) y litros medidos.
   * Detección automática en vivo de períodos de carencia.
3. **Flujo de Venta y Despacho de Leche:**
   * Mediante el botón **"🥛 Vender / Despachar Leche"**:
     * El sistema muestra el saldo actual disponible en el tanque.
     * El operario ingresa los litros a vender (el sistema valida que no exceda el stock existente), el precio unitario pactado (`$/L`), el comprador (*Ej: Quesera Don Pedro*) y la fecha.
     * **Efectos al Confirmar:**
       1. **Resta los litros vendidos del tanque disponible**.
       2. **Genera un asiento de Ingreso en Finanzas:** Monto = $\text{Litros} \times \text{Precio/Litro}$.
       3. Almacena la remisión en la tabla de *Historial de Despachos y Ventas de Leche*.

[⬆ Volver al Índice](#indice)

---

<a id="modulo-4-pesaje-carne"></a>
## 5. Módulo 4: Pesajes, Carne y Ganancia Diaria de Peso (`RegistroPesaje`)

### 🎯 Propósito
Monitorear el crecimiento ponderal de los lotes de cría, levante y ceba en pastoreo según su etapa fisiológica, evaluando la conversión alimenticia y detectando animales estancados.

### ⚙️ Funcionamiento Operativo
1. **Captura de Pesaje en Báscula:**
   * Selección del animal por su **N° Identificador**, fecha y entrada del peso vivo actual en kilogramos.
   * El sistema precarga automáticamente el último peso conocido y su condición fisiológica actual para referencia del usuario.
2. **Cálculo Automático de la Ganancia Diaria de Peso (GDP / GMD):**
   * Aplica la fórmula zootécnica:
     $$\text{GDP (kg/día)} = \frac{\text{Peso Actual (kg)} - \text{Peso Anterior (kg)}}{\text{Días Transcurridos Entre Pesajes}}$$
3. **Calificación de Desempeño:**
   * **Excelente / Óptimo (`> 0.60 kg/día`):** Animal con excelente respuesta al pastoreo y suplementación mineral.
   * **Normal / Aceptable (`0.30 - 0.60 kg/día`):** Rango estándar para trópico bajo.
   * **Estancado / Alerta (`< 0.30 kg/día` o pérdida de peso):** Requiere revisión veterinaria (parasitosis, podología o nutrición).
4. Actualiza inmediatamente el peso vivo en la ficha del animal.

[⬆ Volver al Índice](#indice)

---

<a id="modulo-5-sanidad-retiros"></a>
## 6. Módulo 5: Sanidad Animal y Tiempos de Retiro (`EventoSanitario`)

### 🎯 Propósito
Gestionar planes de vacunación, desparasitación y tratamientos con antibióticos, garantizando la inocuidad mediante el bloqueo estricto por **Tiempos de Retiro**.

### ⚙️ Funcionamiento Operativo
1. **Registro de Tratamiento Médico:**
   * Selección de la res por su **N° Identificador**, tipo de evento (*Tratamiento Antibiótico*, *Vacunación*, *Desparasitación*, *Vitaminas*), producto aplicado y fecha.
   * **Entrada Obligatoria:** `Días de Retiro en Leche` y `Días de Retiro en Carne`.
2. **Activación de Cuarentena y Reglas de Bloqueo:**
   * Si los días de retiro son mayores a cero:
     * El animal pasa a estado **Cuarentena Sanitaria Activa**.
     * **En Ordeño:** Genera alerta roja obligando a enviar la leche a descarte (no comercializable).
     * **En Censo / Canal:** **Inhabilita el botón de venta a matadero** hasta que transcurran los días de carencia reglamentarios.
3. Tabla histórica con auditoría completa de medicamentos y fechas de liberación.

[⬆ Volver al Índice](#indice)

---

<a id="modulo-6-reproduccion"></a>
## 7. Módulo 6: Gestión Reproductiva y Alta Completa de Crías (`EventoReproductivo`)

### 🎯 Propósito
Controlar el ciclo reproductivo de las vacas y novillas de vientre, sincronizar su estado de preñez y condición fisiológica, programar fechas de secado oportunas y dar de alta de forma integral a los nuevos becerros/as nacidos en la finca.

### ⚙️ Funcionamiento Operativo
1. **Eventos de Ciclo y Sincronización Fisiológica:**
   * Registro de celos detectados, inseminaciones artificiales o montas con toro reproductor, palpaciones de diagnóstico de preñez y secados.
   * **Actualización Automática de Preñez y Condición Fisiológica:**
     * Si en *Diagnóstico Preñez* se confirma **Preñada Confirmada**, la hembra pasa automáticamente a `Preñada: Sí`.
     * Si se registra **Secado**, la vaca pasa a condición fisiológica **`Vaca seca`** y `Preñada: Sí` (~60 días antes del parto estimado).
     * Si se registra **Aborto** o diagnóstico **Vacía**, pasa a `Preñada: No`.
2. **Registro de Parto y Alta Completa de la Cría (Ficha de Censo):**
   * Al seleccionar el evento **"Parto (Nacimiento de Cría)"**, se activa el sub-panel especial de captura con todos los campos oficiales del Censo:
     * **N° Identificador de la Cría (`ID_Numero`):** Permite asignar un número identificador nuevo o **reutilizar un número liberado** tras una venta previa en canal.
     * **Hierro (Propietario / Procedencia):** Descripción de las iniciales o figura del hierro (precargado por defecto con el hierro de la finca/madre, editable por el usuario).
     * **Nombre / Alias:** Nombre oficial del becerro/a (*Ej: Relámpago, Diamante, Canelita*).
     * **Sexo:** Hembra (se clasifica automáticamente con condición fisiológica **Becerra**) o Macho (se clasifica automáticamente como **Becerro**).
     * **Raza:** Selección del catálogo o registro directo de una **nueva raza** mediante el botón `+ Nueva Raza`.
     * **Propósito:** Doble Propósito, Leche o Carne.
     * **Peso al Nacer (Kg):** Registro de báscula inicial (típicamente 30 - 40 kg).
   * **Impacto Automatizado al Guardar:**
     1. Registra el evento en la bitácora reproductiva de la madre.
     2. **Da de alta inmediatamente al nuevo animal en el Censo Rebaño** con su N° Identificador, descripción de Hierro, condición fisiológica inicial (*Becerro* o *Becerra*), estado de preñez (*No aplica*) y genealogía vinculada por **Número Identificador** (`Madre` = `#ID_Numero` de la vaca parida, `Padre` = `#ID_Numero` del toro reproductor o semen).
     3. Cambia la condición fisiológica de la vaca madre a **`Vaca parida`** (en lactancia, actualizando si es primípara o multípara) y su estado de preñez a `No` (recién parida), habilitándola para el registro de ordeño.

[⬆ Volver al Índice](#indice)

---

<a id="modulo-7-finanzas"></a>
## 8. Módulo 7: Financiero Operativo y Costos Directos (`TransaccionFinanciera`)

### 🎯 Propósito
Proporcionar una radiografía clara del flujo de caja de la finca ganadera, integrando los ingresos automáticos por venta de leche y animales con los egresos operativos.

### ⚙️ Funcionamiento Operativo
1. **Flujo de Ingresos Automatizados:**
   * Cada vez que se despacha leche del tanque se genera un ingreso en la categoría *"Venta de Leche"*.
   * Cada vez que se beneficia un animal en canal se genera un ingreso en la categoría *"Venta de Ganado / Canal"*.
2. **Registro de Egresos Operativos:**
   * Permite registrar compras de sal mineralizada, concentrados, medicamentos veterinarios, combustible y pago de jornales de vaquería.
3. **Cálculo de Indicadores Clave en Tiempo Real:**
   * **Utilidad Operativa:** $\text{Ingresos Totales} - \text{Egresos Totales}$.
   * **Margen Bruto (%):** Relación porcentual entre utilidad e ingresos.
   * **Costo Directo por Litro de Leche Producido:**
     $$\text{Costo/Litro} = \frac{\sum \text{Egresos Operativos de Lechería}}{\text{Total Litros de Leche Producidos}}$$
4. Permite al productor conocer si el precio pagado por litro de leche cubre los costos directos de la finca.

[⬆ Volver al Índice](#indice)

---

<a id="matriz-interconexion"></a>
## 9. Ciclo de Vida del Número Identificador, Hierro y Matriz de Interconexión

El siguiente flujo resume cómo interactúan los módulos en la operación real de la finca:

```mermaid
flowchart TD
    %% Nacimiento
    REP["🧬 Módulo Reproducción\n(Registro de Parto)"] -->|Alta completa con N° Identificador, Hierro y Madre por N°| CENSO["🐄 Módulo Censo\n(N° Identificador Activo + Etapa Fisiológica)"]
    
    %% Vida Productiva
    CENSO -->|Vaca parida (en lactancia)| ORD["🥛 Módulo Ordeño\n(Litros diarios)"]
    CENSO -->|Becerro, Maute, Novillo| PES["⚖️ Módulo Pesaje\n(Cálculo de GDP)"]
    CENSO -->|Animal tratado| SAN["🩺 Módulo Sanidad\n(Tiempos de retiro)"]
    
    %% Inocuidad
    SAN -.->|Retiro de leche: Descarte| ORD
    SAN -.->|Retiro de carne: Bloqueo| CANAL["🥩 Venta en Canal"]
    
    %% Ventas
    ORD -->|Leche apta a tanque| VTANQUE["🚚 Venta de Leche\n(Descarga de litros)"]
    CENSO -->|Fin de ciclo productivo| CANAL
    
    %% Impacto Financiero
    VTANQUE -->|Ingreso automático| FIN["💰 Módulo Financiero\n(Flujo de Caja & Utilidad)"]
    CANAL -->|Ingreso automático| FIN
    
    %% Liberación de Número Identificador
    CANAL -->|Desincorpora animal| LIB["♻️ N° Identificador Queda Liberado"]
    LIB -.->|Reutilización del número en nuevas crías| REP

    style REP fill:#f3e5f5,stroke:#7b1fa2,stroke-width:2px
    style CENSO fill:#e8f5e9,stroke:#388e3c,stroke-width:2px
    style ORD fill:#e1f5fe,stroke:#0288d1,stroke-width:2px
    style PES fill:#fff3e0,stroke:#f57c00,stroke-width:2px
    style SAN fill:#fce4ec,stroke:#c2185b,stroke-width:2px
    style CANAL fill:#ffebee,stroke:#c62828,stroke-width:2px
    style FIN fill:#e0f2f1,stroke:#00796b,stroke-width:2px
    style LIB fill:#f1f8e9,stroke:#558b2f,stroke-width:2px
```

### 📋 Resumen de Integridad de Datos
| Acción del Usuario | Módulo Origen | Módulos Impactados | Resultado |
| :--- | :--- | :--- | :--- |
| **Registrar Nueva Raza** | Censo / Reproducción | Catálogo de Razas | Guarda la raza personalizada para futuros registros de animales. |
| **Ordeñar Vaca Sana** | Ordeño | Dashboard, Tanque de Leche | Suma litros al stock disponible para venta. |
| **Ordeñar Vaca en Retiro** | Ordeño | Dashboard | Marca la leche como descarte (no comercializable). |
| **Vender Leche** | Ordeño / Dashboard | Tanque, Finanzas | Disminuye el stock del tanque y acredita el dinero en caja. |
| **Tratamiento Médico** | Sanidad | Ordeño, Censo, Dashboard | Activa semáforo rojo y bloquea venta en canal. |
| **Vender en Canal** | Censo | Censo, Finanzas | Desincorpora res, **libera su N° Identificador** y acredita ingreso. |
| **Registrar Parto** | Reproducción | Censo, Ordeño | Da de alta al Becerro/a (con N° Identificador, Hierro y Madre por N°) y pasa a la madre a *Vaca parida* (`Preñada: No`). |

---

[⬆ Volver al Índice](#indice)
