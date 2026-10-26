-- ============================================================================
-- PROYECTO: FincaControl
-- DESCRIPCIÓN: Esquema Unificado de Base de Datos para SQLite Local y SQLite Cloud
-- EQUIPO: Johan Maldonado – José Chacón
-- ARQUITECTURA: Offline-First (Flutter + SQLite Local <-> SQLite Cloud)
-- ============================================================================

PRAGMA foreign_keys = ON;

-- ----------------------------------------------------------------------------
-- 1. TABLA: CONFIGURACION_FINCA (Parámetros Globales del Hato)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CONFIGURACION_FINCA (
    id INTEGER PRIMARY KEY CHECK (id = 1),
    nombre_finca TEXT NOT NULL,
    hierro_oficial_defecto TEXT NOT NULL,
    proposito_principal TEXT NOT NULL CHECK (proposito_principal IN ('Doble Propósito', 'Leche', 'Carne')),
    ubicacion TEXT,
    precio_leche_defecto REAL NOT NULL DEFAULT 0.45,
    precio_carne_defecto REAL NOT NULL DEFAULT 1.85,
    capacidad_tanque_defecto REAL NOT NULL DEFAULT 2000.0,
    dias_gestacion_promedio INTEGER NOT NULL DEFAULT 283,
    dias_alerta_secado INTEGER NOT NULL DEFAULT 60,
    updated_at INTEGER NOT NULL
);

-- ----------------------------------------------------------------------------
-- 2. TABLAS: SEGURIDAD Y CONTROL DE ACCESO (ROLES Y USUARIOS)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ROLES (
    id_rol TEXT PRIMARY KEY,
    nombre_rol TEXT NOT NULL,
    nivel_acceso TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS USUARIOS (
    uuid TEXT PRIMARY KEY,
    id_rol TEXT NOT NULL,
    nombre_completo TEXT NOT NULL,
    correo TEXT NOT NULL UNIQUE,
    contrasena_hash TEXT NOT NULL,
    estado_activo INTEGER NOT NULL DEFAULT 1 CHECK (estado_activo IN (0, 1)),
    created_at INTEGER NOT NULL,
    FOREIGN KEY (id_rol) REFERENCES ROLES(id_rol) ON UPDATE CASCADE
);

-- ----------------------------------------------------------------------------
-- 3. TABLA: CATALOGO_RAZAS (Extensible con Cruces Locales)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CATALOGO_RAZAS (
    id TEXT PRIMARY KEY,
    nombre_raza TEXT NOT NULL UNIQUE,
    es_personalizada INTEGER NOT NULL DEFAULT 0 CHECK (es_personalizada IN (0, 1)),
    created_at INTEGER NOT NULL
);

-- ----------------------------------------------------------------------------
-- 4. TABLA: ANIMALES (Censo Central del Rebaño)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ANIMALES (
    uuid TEXT PRIMARY KEY,
    id_numero TEXT NOT NULL,
    hierro TEXT NOT NULL,
    nombre_alias TEXT NOT NULL,
    sexo TEXT NOT NULL CHECK (sexo IN ('Hembra', 'Macho')),
    raza_id TEXT NOT NULL,
    proposito TEXT NOT NULL CHECK (proposito IN ('Doble Propósito', 'Leche', 'Carne / Ceba')),
    condicion_fisiologica TEXT NOT NULL CHECK (
        condicion_fisiologica IN (
            'Becerro', 'Becerra', 
            'Maute', 'Mauta', 
            'Novillo', 'Novilla', 
            'Toro Reproductor', 
            'Vaca parida', 'Vaca escotera', 'Vaca seca'
        )
    ),
    esta_prenada INTEGER NOT NULL DEFAULT 0 CHECK (esta_prenada IN (0, 1)),
    madre_uuid TEXT,
    padre_uuid TEXT,
    peso_actual_kg REAL NOT NULL,
    estado_actual TEXT NOT NULL DEFAULT 'Activo' CHECK (
        estado_actual IN ('Activo', 'Desincorporado / Canal', 'Muerto', 'Vendido Vivo')
    ),
    created_at INTEGER NOT NULL,
    updated_at INTEGER NOT NULL,
    FOREIGN KEY (raza_id) REFERENCES CATALOGO_RAZAS(nombre_raza) ON UPDATE CASCADE,
    FOREIGN KEY (madre_uuid) REFERENCES ANIMALES(uuid) ON DELETE SET NULL,
    FOREIGN KEY (padre_uuid) REFERENCES ANIMALES(uuid) ON DELETE SET NULL
);

-- Índice único condicional: garantiza que el id_numero sea único solo entre animales activos
-- Al desincorporar un animal por canal o venta, su id_numero queda liberado para nuevas crías.
CREATE UNIQUE INDEX IF NOT EXISTS uq_id_numero_activo 
ON ANIMALES(id_numero) 
WHERE estado_actual = 'Activo';

-- ----------------------------------------------------------------------------
-- 5. TABLAS: LÍNEA DE PRODUCCIÓN DE LECHE
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TANQUE_LECHE (
    uuid TEXT PRIMARY KEY,
    capacidad_maxima_litros REAL NOT NULL,
    litros_disponibles REAL NOT NULL DEFAULT 0.0,
    temperatura_celsius REAL NOT NULL DEFAULT 4.0,
    ultima_actualizacion INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS REGISTROS_ORDENO (
    uuid TEXT PRIMARY KEY,
    animal_uuid TEXT NOT NULL,
    fecha_hora TEXT NOT NULL,
    jornada TEXT NOT NULL CHECK (jornada IN ('Mañana', 'Tarde')),
    cantidad_litros REAL NOT NULL CHECK (cantidad_litros > 0),
    es_descarte INTEGER NOT NULL DEFAULT 0 CHECK (es_descarte IN (0, 1)),
    tanque_uuid TEXT,
    created_at INTEGER NOT NULL,
    FOREIGN KEY (animal_uuid) REFERENCES ANIMALES(uuid) ON DELETE CASCADE,
    FOREIGN KEY (tanque_uuid) REFERENCES TANQUE_LECHE(uuid) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 6. TABLA: TRANSACCIONES_FINANCIERAS (Flujo de Caja Operativo)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS TRANSACCIONES_FINANCIERAS (
    uuid TEXT PRIMARY KEY,
    usuario_uuid TEXT NOT NULL,
    tipo TEXT NOT NULL CHECK (tipo IN ('Ingreso', 'Egreso')),
    categoria TEXT NOT NULL,
    monto REAL NOT NULL CHECK (monto > 0),
    fecha TEXT NOT NULL,
    descripcion TEXT NOT NULL,
    created_at INTEGER NOT NULL,
    FOREIGN KEY (usuario_uuid) REFERENCES USUARIOS(uuid)
);

CREATE TABLE IF NOT EXISTS VENTAS_LECHE (
    uuid TEXT PRIMARY KEY,
    tanque_uuid TEXT NOT NULL,
    transaccion_uuid TEXT NOT NULL UNIQUE,
    fecha_despacho TEXT NOT NULL,
    litros_vendidos REAL NOT NULL CHECK (litros_vendidos > 0),
    precio_unitario_litro REAL NOT NULL CHECK (precio_unitario_litro > 0),
    monto_total REAL NOT NULL CHECK (monto_total > 0),
    comprador_destino TEXT NOT NULL,
    created_at INTEGER NOT NULL,
    FOREIGN KEY (tanque_uuid) REFERENCES TANQUE_LECHE(uuid),
    FOREIGN KEY (transaccion_uuid) REFERENCES TRANSACCIONES_FINANCIERAS(uuid)
);

-- ----------------------------------------------------------------------------
-- 7. TABLAS: LÍNEA DE PRODUCCIÓN DE CARNE Y BENEFICIO
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS REGISTROS_PESAJE (
    uuid TEXT PRIMARY KEY,
    animal_uuid TEXT NOT NULL,
    fecha_pesaje TEXT NOT NULL,
    peso_kg REAL NOT NULL CHECK (peso_kg > 0),
    peso_previo_kg REAL NOT NULL DEFAULT 0,
    dias_transcurridos INTEGER NOT NULL DEFAULT 0,
    gdp_kg_dia REAL NOT NULL DEFAULT 0.0,
    desempeno TEXT NOT NULL CHECK (desempeno IN ('Excelente', 'Normal', 'Estancado', 'Inicial')),
    created_at INTEGER NOT NULL,
    FOREIGN KEY (animal_uuid) REFERENCES ANIMALES(uuid) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS VENTAS_CANAL (
    uuid TEXT PRIMARY KEY,
    animal_uuid TEXT NOT NULL UNIQUE,
    transaccion_uuid TEXT NOT NULL UNIQUE,
    id_numero_liberado TEXT NOT NULL,
    fecha_beneficio TEXT NOT NULL,
    peso_vivo_kg REAL NOT NULL CHECK (peso_vivo_kg > 0),
    rendimiento_canal_pct REAL NOT NULL CHECK (rendimiento_canal_pct > 0 AND rendimiento_canal_pct <= 100),
    peso_canal_kg REAL NOT NULL CHECK (peso_canal_kg > 0),
    precio_kg REAL NOT NULL CHECK (precio_kg > 0),
    monto_total REAL NOT NULL CHECK (monto_total > 0),
    comprador_matadero TEXT NOT NULL,
    created_at INTEGER NOT NULL,
    FOREIGN KEY (animal_uuid) REFERENCES ANIMALES(uuid),
    FOREIGN KEY (transaccion_uuid) REFERENCES TRANSACCIONES_FINANCIERAS(uuid)
);

-- ----------------------------------------------------------------------------
-- 8. TABLAS: SANIDAD Y TIEMPOS DE RETIRO
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EVENTOS_SANITARIOS (
    uuid TEXT PRIMARY KEY,
    tipo_evento TEXT NOT NULL,
    producto_usado TEXT NOT NULL,
    dias_retiro_leche INTEGER NOT NULL DEFAULT 0,
    dias_retiro_carne INTEGER NOT NULL DEFAULT 0,
    fecha_aplicacion TEXT NOT NULL,
    fecha_fin_retiro_leche TEXT NOT NULL,
    fecha_fin_retiro_carne TEXT NOT NULL,
    dosis_via TEXT,
    responsable TEXT,
    created_at INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS ANIMAL_EVENTOS_SANITARIOS (
    id TEXT PRIMARY KEY,
    animal_uuid TEXT NOT NULL,
    evento_sanitario_uuid TEXT NOT NULL,
    retiro_vigente INTEGER NOT NULL DEFAULT 1 CHECK (retiro_vigente IN (0, 1)),
    FOREIGN KEY (animal_uuid) REFERENCES ANIMALES(uuid) ON DELETE CASCADE,
    FOREIGN KEY (evento_sanitario_uuid) REFERENCES EVENTOS_SANITARIOS(uuid) ON DELETE CASCADE
);

-- ----------------------------------------------------------------------------
-- 9. TABLA: MANEJO REPRODUCTIVO
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS EVENTOS_REPRODUCTIVOS (
    uuid TEXT PRIMARY KEY,
    hembra_uuid TEXT NOT NULL,
    tipo_evento TEXT NOT NULL CHECK (
        tipo_evento IN ('Celo', 'Inseminación / Monta', 'Diagnóstico Preñez', 'Secado', 'Parto', 'Aborto')
    ),
    macho_uuid TEXT,
    fecha_evento TEXT NOT NULL,
    resultado TEXT NOT NULL,
    fecha_estimada_parto TEXT,
    fecha_alerta_secado TEXT,
    cria_resultante_uuid TEXT,
    observaciones TEXT,
    created_at INTEGER NOT NULL,
    FOREIGN KEY (hembra_uuid) REFERENCES ANIMALES(uuid) ON DELETE CASCADE,
    FOREIGN KEY (macho_uuid) REFERENCES ANIMALES(uuid) ON DELETE SET NULL,
    FOREIGN KEY (cria_resultante_uuid) REFERENCES ANIMALES(uuid) ON DELETE SET NULL
);

-- ----------------------------------------------------------------------------
-- 10. TABLA: INFRAESTRUCTURA OFFLINE-FIRST (SYNC QUEUE)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS SYNC_QUEUE (
    id TEXT PRIMARY KEY,
    entity_name TEXT NOT NULL,
    entity_id TEXT NOT NULL,
    operation_type TEXT NOT NULL CHECK (operation_type IN ('INSERT', 'UPDATE', 'DELETE')),
    payload_json TEXT NOT NULL,
    created_at INTEGER NOT NULL,
    status TEXT NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'SYNCING', 'SYNCED', 'CONFLICT', 'FAILED')),
    retry_count INTEGER NOT NULL DEFAULT 0,
    last_error TEXT
);

CREATE INDEX IF NOT EXISTS idx_sync_queue_status_time ON SYNC_QUEUE(status, created_at ASC);

-- ----------------------------------------------------------------------------
-- 11. TRIGGERS OPERATIVOS AUTOMÁTICOS
-- ----------------------------------------------------------------------------

-- Aumentar stock del tanque cuando se registra ordeño apto
CREATE TRIGGER IF NOT EXISTS trg_acumular_leche_tanque
AFTER INSERT ON REGISTROS_ORDENO
FOR EACH ROW
WHEN NEW.es_descarte = 0 AND NEW.tanque_uuid IS NOT NULL
BEGIN
    UPDATE TANQUE_LECHE 
    SET litros_disponibles = litros_disponibles + NEW.cantidad_litros,
        ultima_actualizacion = NEW.created_at
    WHERE uuid = NEW.tanque_uuid;
END;

-- Disminuir stock del tanque cuando se efectúa una venta de leche
CREATE TRIGGER IF NOT EXISTS trg_descontar_leche_tanque
AFTER INSERT ON VENTAS_LECHE
FOR EACH ROW
BEGIN
    UPDATE TANQUE_LECHE 
    SET litros_disponibles = MAX(0.0, litros_disponibles - NEW.litros_vendidos),
        ultima_actualizacion = NEW.created_at
    WHERE uuid = NEW.tanque_uuid;
END;

-- Desincorporar al animal y registrar peso en pesaje al pasar a canal
CREATE TRIGGER IF NOT EXISTS trg_desincorporar_animal_canal
AFTER INSERT ON VENTAS_CANAL
FOR EACH ROW
BEGIN
    UPDATE ANIMALES 
    SET estado_actual = 'Desincorporado / Canal',
        updated_at = NEW.created_at
    WHERE uuid = NEW.animal_uuid;
END;

-- ----------------------------------------------------------------------------
-- 12. DATOS SEMILLA (SEED DATA)
-- ----------------------------------------------------------------------------
INSERT OR IGNORE INTO CONFIGURACION_FINCA (
    id, nombre_finca, hierro_oficial_defecto, proposito_principal, ubicacion, 
    precio_leche_defecto, precio_carne_defecto, capacidad_tanque_defecto, 
    dias_gestacion_promedio, dias_alerta_secado, updated_at
) VALUES (
    1, 'Hacienda La Esperanza', 'Hda. La Esperanza - Iniciales HE', 'Doble Propósito', 
    'Zulia, Venezuela', 0.45, 1.85, 2000.0, 283, 60, 1729900000000
);

INSERT OR IGNORE INTO ROLES (id_rol, nombre_rol, nivel_acceso) VALUES 
('ADMIN', 'Administrador de Finca', 'FULL_ACCESS'),
('OPERADOR', 'Operador de Vaquera / Campo', 'FIELD_OPERATIONS');

INSERT OR IGNORE INTO CATALOGO_RAZAS (id, nombre_raza, es_personalizada, created_at) VALUES 
('carora', 'Carora', 0, 1729900000000),
('gyr-mestizo', 'Gyr Mestizo', 0, 1729900000000),
('brahman', 'Brahman', 0, 1729900000000),
('pardo-suizo', 'Pardo Suizo', 0, 1729900000000),
('mosaico-criollo', 'Mosaico Criollo', 0, 1729900000000),
('guzera', 'Guzerá', 0, 1729900000000),
('girolando-f1', 'Girolando F1', 0, 1729900000000);

INSERT OR IGNORE INTO TANQUE_LECHE (uuid, capacidad_maxima_litros, litros_disponibles, temperatura_celsius, ultima_actualizacion) VALUES 
('tanque-principal-01', 2000.0, 0.0, 4.0, 1729900000000);
