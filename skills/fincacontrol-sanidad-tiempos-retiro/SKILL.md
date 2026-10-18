---
name: fincacontrol-sanidad-tiempos-retiro
description: >-
<<<<<<< HEAD
  Use this skill when developing animal health modules, INSAI mandatory vaccinations/tests,
  medical treatments, and critical withdrawal period (tiempo de retiro) alerts to guarantee milk and meat safety.
=======
  Use this skill when developing animal health modules, vaccination logs, medical treatments,
  and critical withdrawal period (tiempo de retiro) alerts to guarantee milk and meat safety.
>>>>>>> origin/Jose
---

# FincaControl - Sanidad y Tiempos de Retiro (Inocuidad)

<<<<<<< HEAD
Esta guía define las reglas de negocio veterinarias, el manejo sanitario preventivo/curativo en Venezuela y los mecanismos de seguridad biológica para evitar la presencia de residuos de medicamentos en la leche y la carne comercializada.
=======
Esta guía define las reglas de negocio veterinarias y los mecanismos de seguridad biológica para evitar la presencia de residuos de medicamentos en la leche y la carne comercializada.
>>>>>>> origin/Jose

---

## 1. El Concepto Crítico: Período de Retiro / Carencia

<<<<<<< HEAD
El **Tiempo de Retiro** es el intervalo obligatorio entre la última aplicación de un medicamento veterinario y el momento en que los alimentos procedentes de ese animal (leche o carne) pueden ser destinados al consumo humano sin riesgo toxicológico. El animal tratado se identifica de forma unívoca por su **Número Identificador (`ID_Numero`)** (mostrando adicionalmente su nombre y descripción de `Hierro` en los certificados y bitácoras).
=======
El **Tiempo de Retiro** es el intervalo obligatorio entre la última aplicación de un medicamento veterinario y el momento en que los alimentos procedentes de ese animal (leche o carne) pueden ser destinados al consumo humano sin riesgo toxicológico.
>>>>>>> origin/Jose

### Cálculo de Fechas de Liberación
Para cada aplicación médica registrada en la entidad `EventoSanitario`:

$$\text{Fecha Fin Retiro Leche} = \text{Fecha Aplicación} + \text{Dias\_Retiro\_Leche}$$

$$\text{Fecha Fin Retiro Carne} = \text{Fecha Aplicación} + \text{Dias\_Retiro\_Carne}$$

---

## 2. Lógica del Semáforo Sanitario

<<<<<<< HEAD
Cada animal consultado por su `ID_Numero` en la aplicación debe calcular su estado de inocuidad en tiempo real:

```mermaid
flowchart TD
    A[Consultar Animal por ID_Numero] --> B{¿Tiene tratamiento activo?}
=======
Cada animal consultado en la aplicación debe calcular su estado de inocuidad en tiempo real:

```mermaid
flowchart TD
    A[Consultar Animal] --> B{¿Tiene tratamiento activo?}
>>>>>>> origin/Jose
    B -- No --> C[Estado: LIBRE / APTO]
    B -- Sí --> D{¿Fecha Actual <= Fecha Fin Retiro?}
    D -- No --> C
    D -- Sí --> E[Estado: EN CUARENTENA / RETIRO ACTIVO]
    
<<<<<<< HEAD
    E --> F[ALERTA LECHE: Marcar leche como descarte o becerros]
    E --> G[ALERTA CARNE: Bloquear venta para matadero / canal]
=======
    E --> F[ALERTA LECHE: Marcar leche como descarte o terneros]
    E --> G[ALERTA CARNE: Bloquear venta para matadero]
>>>>>>> origin/Jose
    
    style C fill:#d4edda,stroke:#28a745,stroke-width:2px
    style E fill:#f8d7da,stroke:#dc3545,stroke-width:2px
```

---

## 3. Puntos de Bloqueo en la Interfaz de Usuario

<<<<<<< HEAD
1. **Pantalla de Ordeño Diario (Vacas Paridas):**
   * Si la vaca seleccionada (por su `ID_Numero`) está en período de retiro de leche:
     * Mostrar banner rojo visible: `⚠️ VACA BAJO TRATAMIENTO: NO MEZCLAR LECHE EN TANQUE`.
     * Permitir registrar los litros ordeñados (para control de vaciado de ubre), pero marcar internamente el registro con el flag `es_descarte = true`.
2. **Pantalla de Bajas / Venta de Animales en Canal:**
   * Si el usuario intenta registrar una venta con destino `Frigorífico / Matadero` y el animal tiene retiro de carne vigente:
     * Bloquear la confirmación de la venta y la desincorporación hasta que se cumpla el período de carencia.

---

## 4. Vademécum Referencial y Exigencias Sanitarias (Venezuela / INSAI)

En Venezuela, el manejo sanitario preventivo contempla el control de parásitos, las **vacunaciones de ley** (*Fiebre Aftosa*, *Rabia* y *Brucelosis en hembras*) y las **pruebas serológicas diagnósticas** (*Brucelosis* y *Tuberculosis*) exigidas por el INSAI para la movilización de animales y comercialización de leche/subproductos.

| Tipo de Producto | Principio Activo / Biológico Ejemplo | Retiro Leche Habitual | Retiro Carne Habitual |
=======
1. **Pantalla de Ordeño Diario:**
   * Si la vaca seleccionada está en período de retiro de leche:
     * Mostrar banner rojo visible: `⚠️ VACA BAJO TRATAMIENTO: NO MEZCLAR LECHE EN TANQUE`.
     * Permitir registrar los litros ordeñados (para control de vaciado de ubre), pero marcar internamente el registro con el flag `es_descarte = true`.
2. **Pantalla de Bajas / Venta de Animales:**
   * Si el usuario intenta registrar una venta con destino `Frigorífico / Matadero` y el animal tiene retiro de carne vigente:
     * Impedir la confirmación o requerir doble confirmación con advertencia explícita de penalización legal/sanitaria.

---

## 4. Vademécum Referencial de Principios Activos Comunes

| Tipo de Producto | Principio Activo Ejemplo | Retiro Leche Habitual | Retiro Carne Habitual |
>>>>>>> origin/Jose
| :--- | :--- | :--- | :--- |
| **Antibiótico** | Oxitetraciclina L.A. | 5 a 7 días | 21 a 28 días |
| **Antibiótico** | Penicilina / Estreptomicina | 3 a 4 días | 14 a 21 días |
| **Antiparasitario** | Ivermectina 1% | 28 a 35 días *(No usar en lactancia)* | 28 a 42 días |
| **Antiparasitario** | Albendazol | 3 días | 14 días |
| **Antiinflamatorio** | Flunixin Meglumine | 36 a 48 horas | 4 a 7 días |
<<<<<<< HEAD
| **Vacunas de Ley (INSAI)** | Fiebre Aftosa, Rabia, Brucelosis (Cepa 19 / RB51 en hembras) | 0 días | 0 a 1 día |
| **Pruebas Diagnósticas** | Serología Brucelosis y Prueba de Tuberculina | 0 días | 0 días |
=======
| **Vacunas** | Aftosa, Rabia, Cepa 19 | 0 días | 0 a 1 día |
>>>>>>> origin/Jose

---

## 5. Checklist de Verificación
<<<<<<< HEAD
- [ ] La consulta de animales en retiro por `ID_Numero` debe evaluarse de forma local y offline mediante el reloj del dispositivo.
- [ ] Soporte para asignación de tratamientos individuales y colectivos (ej. vacunación de ley o baño garrapaticida por lote fisiológico: becerros, mautes, novillos o vacas).
=======
- [ ] La consulta de animales en retiro debe evaluarse de forma local y offline mediante el reloj del dispositivo.
- [ ] Soporte para asignación masiva de tratamientos (ej. baño garrapaticida a todo un potrero) generando los eventos sanitarios individuales correspondientes.
>>>>>>> origin/Jose
