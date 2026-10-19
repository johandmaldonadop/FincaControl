---
name: fincacontrol-produccion-ganadera
description: >-
  Use this skill when developing, testing, or calculating metrics related to milk production
<<<<<<< HEAD
  (daily milking logs, batch entries, lactation curves), cattle physiological stages, custom
  breed catalogs, and beef cattle growth (periodic weighing, Daily Weight Gain / GDP) in dual-purpose farms.
---

# FincaControl - Producción Ganadera, Condiciones Fisiológicas y Pesaje

Esta guía documenta la lógica de negocio, la clasificación por condiciones fisiológicas del ganado bovino en Venezuela, la distinción entre Número Identificador e Hierro, el catálogo personalizable de razas y las fórmulas matemáticas para la gestión de leche y carne en FincaControl.

---

## 1. Identificación del Animal vs. Hierro y Catálogo de Razas

### Distinción entre Número Identificador y Hierro (Contexto Venezolano)
* **Número Identificador (`ID_Numero`):** Es el código numérico individual que identifica de forma única a cada animal activo en el rebaño (ej. `042`, `104`, `201`). Se utiliza para todas las búsquedas operativas, pesajes, ordeños y para referenciar la genealogía (**Madre** y **Padre** se guardan con el `ID_Numero`, nunca con el hierro). Al vender un animal en canal, su `ID_Numero` queda liberado para nuevas crías.
* **Hierro (`Hierro`):** En Venezuela el hierro se utiliza para indicar **propietario y procedencia** del animal. Muchas veces no es un número sino iniciales, letras o una figura (ej. *"Hda. La Esperanza (HE)"*, *"Iniciales JM"*, *"Herradura con estrella"*), por lo que en el sistema se registra una **descripción del hierro**.

### Catálogo Extensible de Razas (`CatalogoRaza`)
* Además de las razas precargadas por defecto (*Gyr Mestizo*, *Carora F1*, *Brahman*, *Guzerá*, *Pardo Suizo*, *Senepol*, *Romosinuano*), el usuario puede **registrar nuevas razas personalizadas**, las cuales quedan guardadas permanentemente en el catálogo local para el registro de otros animales.

---

## 2. Etapas y Clasificación Fisiológica del Ganado Bovino

Cada animal del censo debe clasificarse según su condición fisiológica y sexo:

* **Becerro / Becerra:** Desde el nacimiento hasta el destete (aproximadamente entre los 4 y 10 meses de edad), con un peso que oscila entre los 150 kg y 200 kg. Dependen inicialmente de la leche materna y el calostro, transitando gradualmente hacia el consumo de pastos y concentrados.
* **Maute / Mauta:** Animales jóvenes que van desde los 10 hasta los 18 meses de edad, alcanzando un peso aproximado de 350 kg. Corresponde a la fase de levante o crecimiento intermedio tras el destete.
* **Novillo / Novilla:** Desde los 18 meses hasta alcanzar el peso mínimo requerido para la venta, el engorde final o la reproducción (aproximadamente 400 kg o más). En las hembras, las destinadas a reproducción suelen llamarse *novillas de vientre*.
* **Toro / Toro Reproductor:** Macho adulto destinado a la monta o reproducción, generalmente incorporado a partir de los 30 meses de vida con pesos superiores a los 425 kg.
* **Vaca (Hembra en etapa adulta):** Según su estado productivo y reproductivo en el hato venezolano, se clasifica en:
  * **Vaca parida:** Aquella que ha tenido su cría y está produciendo leche (*primípara* si es su primer parto, o *multípara* si acumula varios).
  * **Vaca escotera:** Vaca que se encuentra preñada pero no está produciendo leche en ese momento.
  * **Vaca seca:** Aquella que ha finalizado su periodo de lactancia y se encuentra en el último tercio de gestación antes del siguiente parto.
* **Indicador de Preñez (`Esta_Prenada`):** Se registra explícitamente si el animal está preñada o no (`Sí / No`) **únicamente en caso de ser hembra reproductora (Vaca o Novilla)**; no aplica en toros ni machos.

---

## 3. Módulo de Ordeño Diario (Producción Lechera)

### Modalidades de Captura
1. **Entrada Individual:** Búsqueda rápida del animal por su **Número Identificador (`ID_Numero`)** y digitación de litros.
2. **Entrada Masiva / Planilla de Vaquera:** Lista prefiltrada con las vacas cuya condición fisiológica es **`Vaca parida` (En Lactancia)**. Permite ingresar los litros de la jornada (Mañana o Tarde) consecutivamente sin salir de la vista.
=======
  (daily milking logs, batch entries, lactation curves) and beef cattle growth (periodic
  weighing, Daily Weight Gain / GDP) in dual-purpose farms.
---

# FincaControl - Producción Ganadera de Doble Propósito

Esta guía documenta la lógica de negocio, validaciones de campo y fórmulas matemáticas para la gestión de la producción de leche y carne en FincaControl.

---

## 1. Módulo de Ordeño Diario (Producción Lechera)

### Modalidades de Captura
1. **Entrada Individual:** Búsqueda rápida del animal por `ID_Hierro` y digitación de litros.
2. **Entrada Masiva / Planilla de Vaquera:** Lista prefiltrada con las vacas que están en estado `En Lactancia`. Permite ingresar los litros de la jornada (Mañana o Tarde) consecutivamente sin salir de la vista.
>>>>>>> origin/Jose

### Reglas de Validación de Campo
* **Rango Válido de Producción:** Advertir al usuario si el valor ingresado es menor a `0.5 L` o mayor a `40.0 L` en una sola jornada (prevención de errores de dedo).
* **Verificación de Sanidad Previa:** Consultar activamente el estado de tiempo de retiro. Si la vaca está bajo tratamiento médico no apto para consumo humano, **bloquear o advertir en color rojo** que la leche debe descartarse.

### Fórmulas y Métricas Clave
* **Total Diario por Vaca:**
  $$\text{Total Día} = \text{Litros Jornada Mañana} + \text{Litros Jornada Tarde}$$
* **Promedio Diario del Rebaño:**
<<<<<<< HEAD
  $$\text{Promedio Litros/Vaca} = \frac{\sum \text{Litros Totales del Día}}{\text{N° Vacas Paridas en Ordeño}}$$
=======
  $$\text{Promedio Litros/Vaca} = \frac{\sum \text{Litros Totales del Día}}{\text{N° Vacas en Ordeño}}$$
>>>>>>> origin/Jose
* **Proyección de Lactancia a 305 Días:** Monitoreo del pico de lactancia (semanas 4 a 8 posparto) y tasa de persistencia mensual (declinación normal del 7% al 10% mensual).

---

<<<<<<< HEAD
## 4. Módulo de Pesaje y Control de Carne

### Captura de Pesajes
* Registro de peso vivo en kilogramos (`Peso_Kg`) por `ID_Numero`, con fecha y método de pesaje (Romana/Báscula mecánica, Báscula digital o Cinta bovinométrica).

### Ganancia Diaria de Peso (GDP / GMD)
Fórmula fundamental para evaluar la eficiencia alimenticia y el crecimiento en lotes de cría (becerros), levante (mautes) y ceba (novillos):
=======
## 2. Módulo de Pesaje y Control de Carne

### Captura de Pesajes
* Registro de peso vivo en kilogramos (`Peso_Kg`) con fecha y método de pesaje (Báscula mecánica, Báscula digital o Cinta bovinométrica).

### Ganancia Diaria de Peso (GDP / GMD)
Fórmula fundamental para evaluar la eficiencia alimenticia y el crecimiento en lotes de levante y ceba:
>>>>>>> origin/Jose

$$\text{GDP (kg/día)} = \frac{\text{Peso Actual (kg)} - \text{Peso Anterior (kg)}}{\text{Días Transcurridos Entre Pesajes}}$$

### Rangos de Referencia para Ganadería Doble Propósito (Trópico):
<<<<<<< HEAD
* **Cría / Destete (Becerro / Becerra, hasta ~150-200 kg):** 0.350 a 0.550 kg/día.
* **Levante a pasto (Maute / Mauta, hasta ~350 kg):** 0.400 a 0.700 kg/día.
* **Ceba / Engorde final (Novillo / Novilla, ≥400 kg):** 0.700 a 1.100 kg/día.
=======
* **Cría / Destete:** 0.350 a 0.550 kg/día.
* **Levante / Ceba a pasto:** 0.400 a 0.700 kg/día.
* **Ceba intensiva / suplementada:** 0.700 a 1.100 kg/día.
>>>>>>> origin/Jose
* **Alerta Crítica:** Si $\text{GDP} \le 0$, generar alerta amarilla (estancamiento) o roja (pérdida de peso que indica parasitismo, nutrición deficiente o enfermedad).

---

<<<<<<< HEAD
## 5. Checklist de Implementación
- [ ] Separar en todos los formularios el `ID_Numero` (identificador individual del animal) de la descripción del `Hierro` (propietario/procedencia).
- [ ] Permitir registrar y persistir nuevas razas personalizadas en el catálogo de razas.
- [ ] Validar coherencia entre `Sexo`, `Condicion_Fisiologica` y el campo `Esta_Prenada` (habilitado solo para hembras aptas).
=======
## 3. Checklist de Implementación
- [ ] Implementar teclado numérico adaptado con punto decimal directo.
- [ ] Validar que un animal solo tenga máximo 2 registros de ordeño por día (Mañana y Tarde).
>>>>>>> origin/Jose
- [ ] Cachear el último peso conocido en la entidad `Animal` para no tener que recalcularlo mediante consultas costosas en listas.
