---
name: fincacontrol-produccion-ganadera
description: >-
  Use this skill when developing, testing, or calculating metrics related to milk production
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

### Reglas de Validación de Campo
* **Rango Válido de Producción:** Advertir al usuario si el valor ingresado es menor a `0.5 L` o mayor a `40.0 L` en una sola jornada (prevención de errores de dedo).
* **Verificación de Sanidad Previa:** Consultar activamente el estado de tiempo de retiro. Si la vaca está bajo tratamiento médico no apto para consumo humano, **bloquear o advertir en color rojo** que la leche debe descartarse.

### Fórmulas y Métricas Clave
* **Total Diario por Vaca:**
  $$\text{Total Día} = \text{Litros Jornada Mañana} + \text{Litros Jornada Tarde}$$
* **Promedio Diario del Rebaño:**
  $$\text{Promedio Litros/Vaca} = \frac{\sum \text{Litros Totales del Día}}{\text{N° Vacas en Ordeño}}$$
* **Proyección de Lactancia a 305 Días:** Monitoreo del pico de lactancia (semanas 4 a 8 posparto) y tasa de persistencia mensual (declinación normal del 7% al 10% mensual).

---

## 2. Módulo de Pesaje y Control de Carne

### Captura de Pesajes
* Registro de peso vivo en kilogramos (`Peso_Kg`) con fecha y método de pesaje (Báscula mecánica, Báscula digital o Cinta bovinométrica).

### Ganancia Diaria de Peso (GDP / GMD)
Fórmula fundamental para evaluar la eficiencia alimenticia y el crecimiento en lotes de levante y ceba:

$$\text{GDP (kg/día)} = \frac{\text{Peso Actual (kg)} - \text{Peso Anterior (kg)}}{\text{Días Transcurridos Entre Pesajes}}$$

### Rangos de Referencia para Ganadería Doble Propósito (Trópico):
* **Cría / Destete:** 0.350 a 0.550 kg/día.
* **Levante / Ceba a pasto:** 0.400 a 0.700 kg/día.
* **Ceba intensiva / suplementada:** 0.700 a 1.100 kg/día.
* **Alerta Crítica:** Si $\text{GDP} \le 0$, generar alerta amarilla (estancamiento) o roja (pérdida de peso que indica parasitismo, nutrición deficiente o enfermedad).

---

## 3. Checklist de Implementación
- [ ] Implementar teclado numérico adaptado con punto decimal directo.
- [ ] Validar que un animal solo tenga máximo 2 registros de ordeño por día (Mañana y Tarde).
- [ ] Cachear el último peso conocido en la entidad `Animal` para no tener que recalcularlo mediante consultas costosas en listas.
