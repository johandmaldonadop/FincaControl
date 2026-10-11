# Notas de débito — Análisis

<small>Bief Team - Software Development</small>  
*20-09-2026 · Análisis canónico `01a` (v0.4 — aportes NC v0.6 · DocFormal · ruta hija · apto propuesta UX / Carta)*

| Campo | Valor |
|--------|--------|
| **Estado** | **Apto Delivery** — Carta aprobada · Fase 0 cerrada · pre-flight F1 GO |
| **Ruta app** | Operaciones › Ventas › Notas de débito → `/movimiento/notas-debito` |
| **Carta** | [[specs/01a_core_comercial/00_incrementos/notas_debito_venta/01_carta\|notas_debito_venta]] — **aprobada** · PO delegado **Sí** |
| **Índice carpeta** | [[specs/01a_core_comercial/01_requerimientos/analisis/gestion_mov/notas_credito_debito/README\|notas_credito_debito/]] |
| **Hermano** | [[specs/01a_core_comercial/01_requerimientos/analisis/gestion_mov/notas_credito_debito/analisis_nota_credito\|analisis_nota_credito]] v0.6 |
| **Factura origen** | [[specs/01a_core_comercial/01_requerimientos/analisis/gestion_mov/ventas/05_perfil_ventas\|05 ventas]] |
| **Insumo histórico** | [[specs/01_core_comercial/01_requerimientos/analisis/gestion_mov/08b_perfil_nota_debito_venta_analisis\|08b ND venta]] · [[specs/01_core_comercial/01_requerimientos/analisis/gestion_mov/08d_perfil_nota_debito_compra_analisis\|08d ND compra]] |
| **Dominio / motor** | [[specs/01_core_comercial/01_requerimientos/analisis/gestion_mov/01_dominio\|01_dominio]] · [[specs/01_core_comercial/01_requerimientos/analisis/gestion_mov/03_endpoints\|03_endpoints]] §5.0 |
| **Retenciones** | Hub acepta ND · flags **false** al emitir · registro posterior · [[specs/01a_core_comercial/01_requerimientos/analisis/retenciones_ventas/gestion_retenciones_ventas\|retenciones ventas]] |
| **Método** | [[specs/06_estandares/03_metodologia_nueva/06_analisis\|06 — Análisis]] · [[specs/06_estandares/03_metodologia_nueva/11_markdown_obsidian\|11 — Markdown Obsidian]] |

Este documento es la **verdad única en `01a`** de notas de débito. Prioriza **ND venta** (primera Carta). Comparte esquema técnico y paridad DocFormal con las NC, pero **no** la lógica de saldo ni modalidades de devolución/descuento.

Cualquier HU, UI spec, API `01a` o Carta posterior debe alinearse aquí o enmendarlo con una decisión Dn.

**No sustituye asesoría legal.** Marco fiscal: **SNAT/2011/00071**.

## Índice

1. [[#1. Objetivo y alcance|Objetivo y alcance]]
2. [[#2. Marco fiscal y mejores prácticas|Marco fiscal]]
3. [[#3. Modo ndImpresion · DocFormal · navegación|Modo · DocFormal · navegación]]
4. [[#4. Camino feliz|Camino feliz]]
5. [[#5. Caminos alternativos|Caminos alternativos]]
6. [[#6. Contexto técnico|Contexto técnico]]
7. [[#7. Propuesta de implementación|Propuesta de implementación]]
8. [[#8. Decisiones D1–Dn|Decisiones D1–Dn]]
9. [[#9. Artefactos a–e|Artefactos a–e]]
10. [[#10. Interrogantes que quedan|Interrogantes que quedan]]
11. [[#11. Cierre pre-Carta (PO 20-09-2026)|Cierre pre-Carta]]

---

## 1. Objetivo y alcance

[[#Índice|↑ Volver al índice]]

### En una frase

Una **nota de débito de venta** documenta un **cargo o ajuste al alza** sobre una factura de venta ya emitida: la emite la organización hacia el cliente, con número propio (sistema o manual según modo), y **aumenta** lo que el cliente debe. El vínculo a la factura es **documental**: no consume ni topea el saldo de esa factura.

### Planteamiento de producto (cerrado PO)

| # | Afirmación | Lectura de análisis |
|---|------------|---------------------|
| 1 | Existen ND sobre facturas de **venta** y de **compra** | Primera Carta: **solo ND venta**. Compra después |
| 2 | ND venta: **emitida** por la org. hacia el cliente | Documento **generado** o número manual según `ndImpresion` |
| 3 | ND compra: **recibida** del proveedor | Fuera de la primera Carta |
| 4 | ND venta **siempre** asociada a una factura de venta | `DocNota.idDocAfectado` obligatorio |
| 5 | La factura es **contexto y vínculo**; el importe **no** se limita al total ni al saldo | Sin tope duro · sin motor `saldoDoc` |
| 6 | **No** hay productos / inventario / devolución de ítems | Solo conceptos del tipo de movimiento |
| 7 | Conceptos contables = configuración del **tipo de movimiento administrativo** | `ConfAsiento` existente del tipo ND venta — **sin** semillas nuevas en Carta |
| 8 | Único flag de modo: **`ndImpresion`** | [[#3. Modo ndImpresion · DocFormal · navegación\|§3]] |
| 9 | `ndImpresion = false`: usuario ingresa **nº ND**, **control** y **serie** | Solo registro |
| 10 | `ndImpresion = true`: **nº ND** del sistema; control al **marcar impresa** | Formas libres = facturas de venta |
| 11 | Carta **separada** de la NC | Id propio en `00_incrementos` |
| 12 | Retenciones IVA **aceptan ND**; al emitir flags **false**; registro **después** si el cliente retiene | Espejo NC D32 |
| 13 | Baja espejo NC | Eliminar última / anular / no si `declarada` |
| 14 | `DocFormal` a **paridad** con factura formal | [[#3.1c DocFormal — paridad con factura formal\|§3.1c]] |
| 15 | Alta: campos formales **bloqueados** desde la factura | Usuario edita conceptos/montos/descripción (+ nº en M1) |
| 16 | Paso 2a: **ruta hija formal** (no T-B) | Espejo `/movimiento/ventas/nueva` |
| 17 | Entrada v1 solo **Operaciones** (+ botón factura) | Sin menú Comercial |
| 18 | Sin `ndVenta` en período activo → bloqueo + mensaje fijo | Copy §3 |
| 19 | Diseño según SENIAT + práctica de mercado | §2 |

### Efecto contable (resumen)

| | ND venta | ND compra — fuera v1 |
|--|----------|----------------------|
| Quién emite | Organización → cliente | Proveedor → organización |
| Numeración | Sistema o manual (`ndImpresion`) | Número del tercero |
| Factura afectada | Venta (tipo básico **2**) | Compra (tipo básico **1**) |
| Efecto | ↑ Cuenta por **cobrar** | ↑ Cuenta por **pagar** |
| Tipo conf (org 1) | `idConfTipoMov` **24** · `idTipoMovBasico` **24** (`TipoMov` 13) | **23** · `idTipoMovBasico` **23** (`TipoMov` 14) — ver [[specs/01a_core_comercial/01_requerimientos/analisis/gestion_mov/notas_credito_debito/analisis_notas_compra\|analisis_notas_compra]] |
| Tipo conf (org 2) | `idConfTipoMov` **63** | — |

### NC vs ND

| Aspecto | NC venta | ND venta |
|---------|----------|----------|
| Efecto CxC | ↓ | **↑** |
| Tope / disponible vs factura | Sí | **No** |
| Productos / kardex | Según modos NC | **No** |
| Contador (impresión ON) | `proximaNotaCredito` | **`proximaNotaDebito`** |
| Libro IVA | Resta | **Suma** |
| Anticipo recibido (NC > CxC) | Sí (NC) | **No aplica** (ND siempre incrementa CxC) |

Detalle NC: [[specs/01a_core_comercial/01_requerimientos/analisis/gestion_mov/notas_credito_debito/analisis_nota_credito\|analisis_nota_credito]].

### Alcance de la primera Carta (ND venta)

- Listado + alta/consulta en **ruta hija formal**; impresión según `ndImpresion`.
- Entrada: Operaciones › Ventas › Notas de débito + botón desde factura.
- Esquema **4**: `Doc` + `DocFormal` **completo** + `DocNota` + `Registro`.
- Conceptos / asiento desde `ConfAsiento` **ya existente** (tipo 24 / 63).
- Retenciones: flags false al emitir; hub acepta ND después.

### Fuera de alcance

- NC (Carta propia) · ND compra · inventario/kardex · motivos descuento/devolución NC · carpeta `05a` comercial.

### Supuestos

- Token org + período activo.
- Factura venta no anulada.
- `ConfAsiento` del tipo ND venta ya en `05_datos_confTipoMov.sql` (sin semillas nuevas).
- `ndVenta` en período fiscal activo.
- Transversal: [[specs/01_core_comercial/01_requerimientos/analisis/gestion_mov/02_reglas_transversales\|02_reglas_transversales]].

[[#Índice|↑ Volver al índice]]

---

## 2. Marco fiscal y mejores prácticas

[[#Índice|↑ Volver al índice]]

Referencia: **SNAT/2011/00071** (Arts. 22–24).

| Requisito | Implicación ND venta |
|-----------|----------------------|
| Ajuste al alza con factura previa | Emitir ND; no editar factura impresa |
| Denominación «Nota de Débito» | Impresión / PDF / título |
| Numeración propia consecutiva | `ndImpresion = true` → `proximaNotaDebito` |
| Ref. fecha, número y monto factura | Cabecera + `DocNota` + impresión |
| Descripción y valor del ajuste | Conceptos tipo mov. + bases/IVA |
| Discriminar base e IVA | `DocFormal` completo · libro (**suma**) |

**Retenciones:** al emitir ND, `requiereRet*` / `tieneRet*` = **false**. Si el cliente retiene, se registra después en el hub (elegibilidad extendida a ND). Perfil [[specs/01_core_comercial/01_requerimientos/analisis/gestion_mov/07d_perfil_retencion_iva_venta\|07d]].

[[#Índice|↑ Volver al índice]]

---

## 3. Modo ndImpresion · DocFormal · navegación

[[#Índice|↑ Volver al índice]]

### 3.1 Configuración (período fiscal — espejo NC D31)

```json
{
  "fiscal": {
    "documentos": {
      "ndVenta": {
        "ndImpresion": true
      }
    }
  }
}
```

| Ubicación | Rol |
|-----------|-----|
| `PeriodoFiscal.configPeriodoFiscal.fiscal.documentos.ndVenta` | Gate + modo del período activo |
| `OrganizacionConfi.configuracionDefault.fiscal.documentos.ndVenta` | Plantilla al **crear** período |

| Flag | Significado |
|------|-------------|
| `ndImpresion` | Único modo (no hay `ndComercial`) |

**Gate:** si el período activo **no** tiene `ndVenta` → bloqueo con:

> El módulo de notas de débito no está configurado para este período fiscal

### 3.2 Modos

| Modo | `ndImpresion` | Numeración / control / serie | Formas libres |
|------|---------------|------------------------------|---------------|
| Solo registro | **false** | Usuario tipa **nº ND**, **control** y **serie** | No |
| Con impresión | **true** | **Nº ND** sistema (`proximaNotaDebito` + `largoNotasCreditoDebito`); control/serie **no** tipados en alta — control al **marcar impresa** | Sí (mismas que facturas venta) |

### 3.1c DocFormal — paridad con factura formal

La ND de **venta** es documento formal SENIAT. El bloque **`DocFormal`** (y cabecera/asiento del movimiento) maneja **todas** las partes del tipo — no un subconjunto simplificado.

**Espejo de producto:**

| Pantalla | Ruta |
|----------|------|
| Nueva venta (formal) | `/movimiento/ventas/nueva` |
| Nueva compra (formal) | `/movimiento/compras/nueva` |

Componente: `MovimientoBasicoForm` · payload `DocFormalAgregar`.

#### Partes DocFormal + Doc (mínimo = factura formal)

| Parte | Persistencia |
|-------|--------------|
| Cliente | `Doc.idPersona` (desde factura; **locked**) |
| Fecha documento / aplica | `Doc.FechaDoc` · `fechaAplica` (locked desde factura salvo regla transversal) |
| Descripción | `Doc.descripcion` (editable; puede complementar texto sistema) |
| Moneda / tasa | `Doc.idMonedaAplica` · `tasaCambio` (locked desde factura) |
| Indicador servicio | `DocFormal.esDeServicio` (heredado) |
| Conceptos / líneas | `Registro` (+ `idImpuesto`) — plantilla tipo movimiento |
| Desglose IVA | `baseImponible1..3` · `alicuota1..3` |
| Totales | `exento` · `baseImponible` · `impuesto` · `Doc.montoBase` |
| Libro / impuesto | `aplicaLibro` · `aplicaImpuesto` |
| Retenciones | `requiereRet*` · `tieneRet*` = **false** al emitir |
| Nº / serie / control | Según `ndImpresion` |
| Cuadre | Debe — Haber — Diferencia |

#### Partes propias de ND

| Parte | Rol |
|-------|-----|
| `DocNota` | Vínculo a factura afectada (obligatorio) |
| Conceptos | Solo los del tipo de movimiento (sin grilla producto) |

**Regla dura Delivery:** mismo contrato `DocFormalAgregar` y misma acumulación bases/IVA que factura formal. No inventar `DocFormal` parcial.

### 3.3 Alta — campos locked (espejo NC D26)

Casi todo **bloqueado desde la factura**. El usuario edita:

- Conceptos / montos (plantilla tipo mov.)
- Descripción
- Con `ndImpresion = false`: nº ND, control, serie

### 3.4 Conceptos (cerrado PO)

Siempre los del **tipo de movimiento administrativo** (`ConfAsiento` del tipo ND venta). **No** semillas nuevas en Carta — revisar existente (§11).

### 3.5 Navegación y perfil UI (espejo NC D33–D34)

- Entrada v1: solo **Operaciones › Ventas › Notas de débito** + botón en listado/consulta factura venta Operaciones.
- **Sin** ítem de menú Comercial.
- Paso 2a: **ruta hija formal** (listado + alta/consulta hijas), **no** panel T-B.
- Carpetas: solo **`01a`** (admin / Operaciones / DocFormal). Sin fase `05a` (no comercial/kardex).

[[#Índice|↑ Volver al índice]]

---

## 4. Camino feliz

[[#Índice|↑ Volver al índice]]

### Historia — ND venta (`ndImpresion = true`)

1. Seleccionar factura (menú o botón).
2. Formulario formal precargado/locked; conceptos del tipo; montos → bases → IVA.
3. Guardar → correlativo sistema → ↑ CxC · flags retención false.
4. Imprimir forma libre → registrar control → `impresa`.

### Historia — ND venta (`ndImpresion = false`)

1. Igual selección y conceptos.
2. Usuario tipa nº ND, control, serie.
3. Guardar → admin → ↑ CxC.

### Historia — Eliminar ND

Solo si no declarada, no impresa (o M1), y es la **última** ND emitida → **elimina** y **libera correlativo**.

### Historia — Retención

Cliente retiene sobre ND → hub retenciones ventas elige ND elegible → comprobante (después de emitir).

| Id | Funcionalidad |
|----|---------------|
| F1 | Listar ND venta |
| F2 | Alta ND venta (DocFormal completo · locked) |
| F3 | Enlace desde factura |
| F4 | Consultar / imprimir (control al marcar impresa) |
| F5 | Modificar si aún se permite |
| F6 | Baja: eliminar última / anular |
| F7 | Retención IVA sobre ND (hub) |

### F1 — a … e

[[#Índice|↑ Volver al índice]]

Listado (`idConfTipoMov` 24 / 63). Columnas: nº ND, control/serie, factura, cliente, fechas, total, impresa/anulada. `vwNotas`.

### F2 — a … e

[[#Índice|↑ Volver al índice]]

Alta formal: DocFormal paridad; conceptos tipo; numeración según modo; `DocNota` obligatorio; POST esquema 4; ↑ CxC; `requiereRet*`/`tieneRet*` = false. Descripción sistema + editable.

Vacío: *«No existen facturas de ventas registradas en el período fiscal \<nombre período\>»*.

### F3 — a … e

[[#Índice|↑ Volver al índice]]

Desde factura: ND ligadas + emitir (precarga). Misma validación que menú.

### F4 — a … e

[[#Índice|↑ Volver al índice]]

Consulta + impresión si `ndImpresion = true`. Al marcar impresa: registrar control/serie de la forma libre.

### F5 — a … e

[[#Índice|↑ Volver al índice]]

PUT análogo. **No** si `impresa`. En solo registro: espejo NC M1.

### F6 — a … e

[[#Índice|↑ Volver al índice]]

| Situación | Acción |
|-----------|--------|
| No impresa / solo registro, no declarada, **es la última** | **Eliminar** · **libera correlativo** |
| No es la última | **No** eliminar |
| Impresa, no `declarada` | **Anular** (conservar doc/nº/control; reverso CxC; Art. 32) |
| `declarada = 1` | No anular / no eliminar |

### F7 — a … e

[[#Índice|↑ Volver al índice]]

Hub retenciones ventas **acepta ND** elegible (impuesto, flags). Extender 07d / hub más allá de factura tipo 2.

[[#Índice|↑ Volver al índice]]

---

## 5. Caminos alternativos

[[#Índice|↑ Volver al índice]]

| Id | Situación | Comportamiento |
|----|-----------|----------------|
| A1 | Alta desde factura o menú | Misma validación; precarga |
| A2 | Importe ND &gt; saldo o total factura | **Permitido** |
| A3 | Sin factura afectada | **Rechazo** |
| A4 | PUT si impresa | **Rechazo** |
| A5 | `ndImpresion = false` sin nº/control/serie | **Rechazo** |
| A6 | Período sin `ndVenta` | **Bloqueo** + copy §3 |
| A7 | Varias ND misma factura | **Permitido** |
| A8 | UI confundida con NC | Evitar |
| A9 | Retención sobre ND | **Permitido** si elegible (F7) |
| A10 | Eliminar si no es la última | **Rechazo** |
| A11 | Anular/eliminar si `declarada` | **Rechazo** |
| A12 | Control longitud inválida | **Rechazo** (M1 alta / al marcar impresa) |

[[#Índice|↑ Volver al índice]]

---

## 6. Contexto técnico

[[#Índice|↑ Volver al índice]]

| Ítem | Valor |
|------|--------|
| **Esquema** | **4** (Notas) |
| **Tipo org 1** | `idConfTipoMov` **24** · `idTipoMovBasico` **24** |
| **Tipo org 2** | `idConfTipoMov` **63** |
| **Vistas** | `vwNotas` · `vwComprasVentas` (factura **2**) |
| **DocFormal** | Paridad factura formal · `DocFormalAgregar` |
| **UI referencia** | `/movimiento/ventas/nueva` · `MovimientoBasicoForm` |
| **Perfil UI** | **Ruta hija formal** (Paso 2a) |
| **Conceptos** | `ConfAsiento` existente · ↑ CxC |
| **Número ON** | `proximaNotaDebito` + `largoNotasCreditoDebito` |
| **Control ON** | Al **marcar impresa** |
| **Config** | `configPeriodoFiscal.fiscal.documentos.ndVenta` |
| **Carta** | Separada de NC · solo carpeta **`01a`** |
| **Libros** | ND **suma** · [[specs/01a_core_comercial/01_requerimientos/analisis/impuestos/declarar_iva/libros_compras_ventas/declaracion_iva\|declaracion_iva]] |

### Persistencia

```text
Doc + DocFormal (completo) + DocNota + Registro
         ↑
   idDocAfectado = factura venta (sin tope)
   conceptos = ConfAsiento tipo 24 / 63
```

[[#Índice|↑ Volver al índice]]

---

## 7. Propuesta de implementación

[[#Índice|↑ Volver al índice]]

**Una Carta** (id propio, distinta de NC), fases; carpeta **`01a`** únicamente.

| Fase | Alcance |
|------|---------|
| **F0** | Carta · Paso 2a ruta hija · config `ndVenta` período · **sin** semillas ConfAsiento |
| **F1** | Gate · `ndImpresion=false` · DocFormal locked · conceptos tipo · ↑ CxC · eliminar última |
| **F2** | `ndImpresion=true` · correlativo · forma libre · control al marcar impresa |
| **F3** | Anular si `declarada=0` (impresa ok) · conservar documento |
| **F4** | Hub retenciones: elegibilidad ND |
| **—** | ND compra = **otra** Carta |

```text
Operaciones › ND ──POST──► Doc (esquema 4) + DocFormal completo
ndImpresion true:  + correlativo + forma libre + control al imprimir
Retención:         hub ──elige ND──► comprobante (flags false al emitir ND)
```

[[#Índice|↑ Volver al índice]]

---

## 8. Decisiones D1–Dn

[[#Índice|↑ Volver al índice]]

| Id | Decisión | Pendiente PO |
|----|----------|--------------|
| D1–D11 | Cerradas v0.2–v0.3 | **No** |
| D12 | DocFormal **paridad** factura formal | **No** |
| D13 | Alta: campos formales **locked** desde factura | **No** |
| D14 | Paso 2a: **ruta hija formal** (no T-B) | **No** |
| D15 | Entrada v1 solo Operaciones | **No** |
| D16 | Al emitir: `requiereRet*`/`tieneRet*` = **false**; retención después en hub | **No** |
| D17 | **Sin** semillas ConfAsiento nuevas; usar tipo 24/63 existente | **No** |
| D18 | Eliminar última **libera correlativo** | **No** |
| D19 | Copy gate alineado a NC (§3) | **No** |
| D20 | Carta por fases F0–F4; solo `01a` | **No** |
| D21 | ND compra fuera de esta Carta | **No** |

[[#Índice|↑ Volver al índice]]

---

## 9. Artefactos a–e

[[#Índice|↑ Volver al índice]]

| Bloque | Estado |
|--------|--------|
| **a** | Este documento |
| **b** | Paso 2a = ruta hija formal — redactar al abrir Carta / propuesta UX |
| **c** | Este documento · SENIAT · espejo NC DocFormal/impresión |
| **d** | API admin `01a` + elegibilidad retención |
| **e** | Pendiente HU con Carta |

[[#Índice|↑ Volver al índice]]

---

## 10. Interrogantes que quedan

[[#Índice|↑ Volver al índice]]

**Ninguna de negocio bloqueante.**

Siguiente: **propuesta UX** (breve) + **Carta** en `00_incrementos`.

Delivery (no bloquea): detalle elegibilidad 07d/hub sobre ND; cuentas piloto si hace falta ajuste manual en gestor de tipos (no sembrar en Carta).

[[#Índice|↑ Volver al índice]]

---

## 11. Cierre pre-Carta (PO 20-09-2026)

[[#Índice|↑ Volver al índice]]

| # | Tema | Cierre |
|---|------|--------|
| 1 | Alcance | Carta **separada** de NC · solo ND venta · fases F0–F4 |
| 2 | Modo | Solo `ndImpresion` |
| 3 | Conceptos | Tipo de movimiento · **sin** semillas ConfAsiento |
| 4 | DocFormal | Paridad factura formal |
| 5 | Formulario | Locked desde factura |
| 6 | UI | Ruta hija formal · solo Operaciones |
| 7 | Control | Al marcar impresa (`ndImpresion=true`) |
| 8 | Baja | Última elimina + libera correlativo · anular si impresa no declarada |
| 9 | Config | Período fiscal `ndVenta` |
| 10 | Retenciones | Flags false al emitir · hub acepta ND después |
| 11 | Copy gate | *El módulo de notas de débito no está configurado para este período fiscal* |

### ConfAsiento existente — Nota de Débito Venta

**No crear semillas** (espejo NC). Usar `05_datos_confTipoMov.sql`.

| Org | `idConfTipoMov` | `idTipoMovBasico` | Esquema |
|-----|-----------------|-------------------|---------|
| 1 (empresa) | **24** | **13** | 4 |
| 2 (condominio) | **63** | **13** | 4 |

**Org 1 — líneas `ConfAsiento` (ids 679–681):** Debe cuenta **14** (var. motor) · Haber cuenta **189** (concepto variable) · Haber cuenta **131** (var. **3** `impuesto`). Detalle de nombres de cuenta: gestor / script; no redefinir en Carta.

[[#Índice|↑ Volver al índice]]

---

## Historial

| Versión | Fecha | Cambio |
|---------|-------|--------|
| 0.1 | 20-09-2026 | Primera versión `01a`: reescritura 08b + 08d |
| 0.2 | 20-09-2026 | ND venta priorizada; `ndImpresion`; Carta separada; retenciones aceptan ND |
| 0.3 | 20-09-2026 | Baja espejo NC; control al marcar impresa; gate período |
| 0.4 | 20-09-2026 | Aportes NC v0.6: DocFormal paridad; locked; ruta hija; flags ret false; sin semillas; fases F0–F4; copy gate; cierre §11 |
