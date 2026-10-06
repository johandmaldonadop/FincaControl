---
name: fincacontrol-finanzas-costos-directos
description: >-
  Use this skill when developing financial records, cash flow tracking, operational
  cost allocation, cost-per-liter calculation, and profit margin analysis for FincaControl.
---

# FincaControl - Control Financiero Operativo y Costos Directos

Esta guía establece las directrices contables operativas, la categorización de ingresos y egresos, y el cálculo de márgenes brutos para fincas ganaderas de doble propósito.

---

## 1. Alcance Financiero Operativo vs. Contabilidad Fiscal

FincaControl **no** es un software tributario ni de facturación fiscal electrónica. Su propósito es brindar al productor una radiografía real de su flujo de caja y la rentabilidad unitaria de su leche y su carne.

### Categorización Estándar de Transacciones (`TransaccionFinanciera`)

| Tipo | Categoría | Conceptos Habituales |
| :--- | :--- | :--- |
| **Ingreso** | Venta de Leche | Pagos quincenales/mensuales de quesera o planta procesadora. |
| **Ingreso** | Venta de Animales | Venta de novillos gordos, toros de descarte o terneros destetados. |
| **Ingreso** | Subproductos | Venta de queso artesanal, cuajada, estiércol o pasto. |
| **Egreso** | Alimentación y Suplementos | Concentrados, melaza, sal mineralizada, urea, silos o heno. |
| **Egreso** | Sanidad y Medicamentos | Antibióticos, desparasitantes, vacunas, jeringas, vitaminas. |
| **Egreso** | Mano de Obra Operativa | Jornales de ordeño, vaquería, peones y limpieza de potreros. |
| **Egreso** | Mantenimiento de Finca | Alambre de púas, grapas, postes, combustible para plantas/tractores. |

---

## 2. Indicadores Financieros Clave y Fórmulas

### Costo Directo por Litro de Leche Producido
Permite evaluar si el precio pagado por el centro de acopio supera el costo operativo:

$$\text{Costo Unitario por Litro} = \frac{\sum \text{Egresos Atribuidos a Lechería en el Período}}{\text{Total Litros de Leche Producidos en el Período}}$$

### Margen Operativo del Negocio
$$\text{Utilidad Operativa} = \text{Total Ingresos Operativos} - \text{Total Egresos Operativos}$$

$$\text{Margen Operativo (\%)} = \left( \frac{\text{Utilidad Operativa}}{\text{Total Ingresos}} \right) \times 100$$

---

## 3. Seguridad y Privacidad de la Información
* **Control RBAC Estricto:** La pantalla de transacciones financieras, resúmenes de rentabilidad y precios de venta deben estar ocultas o inaccesibles para el rol de `Operador`.
* **Cifrado en Dispositivo:** Almacenar los montos y balances protegidos para evitar filtraciones en caso de extravío del dispositivo móvil en campo.

---

## 4. Checklist de Implementación
- [ ] Validar que cada transacción financiera esté vinculada al `ID_Usuario` que la registró.
- [ ] Exportación de balances semanales o mensuales en formato CSV o PDF local.
- [ ] Soporte para registrar la unidad de medida y precio unitario (ej. Litros x Precio/Litro).
