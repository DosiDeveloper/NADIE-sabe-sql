-- Nivel 7 - Star Schema: desnormalización para OLAP
-- Ejecutar: sqlite3 nivel7.db.sqlite3 < setup.sql

DROP TABLE IF EXISTS fact_inscripcion;
DROP TABLE IF EXISTS dim_fecha;
DROP TABLE IF EXISTS dim_curso;
DROP TABLE IF EXISTS dim_profesor;
DROP TABLE IF EXISTS dim_estudiante;

CREATE TABLE dim_estudiante (
    estudiante_id INTEGER PRIMARY KEY,
    nombre TEXT,
    apellido TEXT,
    email TEXT,
    edad INTEGER,
    rango_edad TEXT,
    activo INTEGER
);

CREATE TABLE dim_profesor (
    profesor_id INTEGER PRIMARY KEY,
    nombre TEXT,
    apellido TEXT,
    email TEXT,
    especialidad TEXT
);

CREATE TABLE dim_curso (
    curso_id INTEGER PRIMARY KEY,
    nombre TEXT,
    creditos INTEGER,
    nivel_dificultad TEXT
);

CREATE TABLE dim_fecha (
    fecha_id INTEGER PRIMARY KEY,
    fecha DATE,
    dia INTEGER,
    mes INTEGER,
    nombre_mes TEXT,
    trimestre INTEGER,
    anio INTEGER
);

CREATE TABLE fact_inscripcion (
    inscripcion_id INTEGER PRIMARY KEY,
    estudiante_id INTEGER REFERENCES dim_estudiante(estudiante_id),
    curso_id INTEGER REFERENCES dim_curso(curso_id),
    profesor_id INTEGER REFERENCES dim_profesor(profesor_id),
    fecha_id INTEGER REFERENCES dim_fecha(fecha_id),
    calificacion REAL,
    estado TEXT
);

-- ============================================================
-- DIMENSIONES
-- ============================================================

INSERT INTO dim_estudiante (estudiante_id, nombre, apellido, email, edad, rango_edad, activo) VALUES
    (1, 'Juan', 'Pérez', 'juan@email.com', 26, 'mayor-25', 1),
    (2, 'María', 'García', 'maria@email.com', 27, 'mayor-25', 1),
    (3, 'Carlos', 'López', 'carlos@email.com', 25, '23-25', 1),
    (4, 'Ana', 'Martínez', 'ana@email.com', 26, 'mayor-25', 1),
    (5, 'Laura', 'Hernández', 'laura@email.com', 24, '23-25', 1),
    (6, 'Pedro', 'Rodríguez', 'pedro@email.com', 28, 'mayor-25', 0),
    (7, 'Sofía', 'Cruz', 'sofia@email.com', 25, '23-25', 1),
    (8, 'Miguel', 'Torres', 'miguel@email.com', 26, 'mayor-25', 1),
    (9, 'Valentina', 'Reyes', 'valentina@email.com', 27, 'mayor-25', 0),
    (10, 'Diego', 'Ramírez', 'diego@email.com', 27, 'mayor-25', 1);

INSERT INTO dim_profesor (profesor_id, nombre, apellido, email, especialidad) VALUES
    (1, 'Elena', 'Vargas', 'elena@email.com', 'Matemáticas'),
    (2, 'Roberto', 'Silva', 'roberto@email.com', 'Programación'),
    (3, 'Sofía', 'Torres', 'sofia.t@email.com', 'Bases de Datos'),
    (4, 'Andrés', 'Mendoza', 'andres@email.com', 'Redes');

INSERT INTO dim_curso (curso_id, nombre, creditos, nivel_dificultad) VALUES
    (1, 'Álgebra Lineal', 4, 'Básico'),
    (2, 'Cálculo Diferencial', 5, 'Intermedio'),
    (3, 'Programación Python', 4, 'Básico'),
    (4, 'Bases de Datos', 5, 'Intermedio'),
    (5, 'Machine Learning', 6, 'Avanzado'),
    (6, 'Redes', 4, 'Básico');

-- dim_fecha: todos los días de 2024
INSERT INTO dim_fecha (fecha_id, fecha, dia, mes, nombre_mes, trimestre, anio)
WITH RECURSIVE dates(fecha) AS (
    SELECT '2024-01-01'
    UNION ALL
    SELECT DATE(fecha, '+1 day') FROM dates WHERE fecha < '2024-12-31'
)
SELECT
    CAST(STRFTIME('%Y%m%d', fecha) AS INTEGER) AS fecha_id,
    fecha,
    CAST(STRFTIME('%d', fecha) AS INTEGER) AS dia,
    CAST(STRFTIME('%m', fecha) AS INTEGER) AS mes,
    CASE CAST(STRFTIME('%m', fecha) AS INTEGER)
        WHEN 1 THEN 'Enero' WHEN 2 THEN 'Febrero' WHEN 3 THEN 'Marzo'
        WHEN 4 THEN 'Abril' WHEN 5 THEN 'Mayo' WHEN 6 THEN 'Junio'
        WHEN 7 THEN 'Julio' WHEN 8 THEN 'Agosto' WHEN 9 THEN 'Setiembre'
        WHEN 10 THEN 'Octubre' WHEN 11 THEN 'Noviembre' WHEN 12 THEN 'Diciembre'
    END AS nombre_mes,
    ((CAST(STRFTIME('%m', fecha) AS INTEGER) - 1) / 3) + 1 AS trimestre,
    CAST(STRFTIME('%Y', fecha) AS INTEGER) AS anio
FROM dates;

-- ============================================================
-- TABLA DE HECHOS
-- ============================================================

INSERT INTO fact_inscripcion (inscripcion_id, estudiante_id, curso_id, profesor_id, fecha_id, calificacion, estado) VALUES
    (1,  1, 1, 1, 20240301, 15.0, 'completado'),
    (2,  1, 3, 2, 20240301, 18.0, 'completado'),
    (3,  2, 2, 1, 20240301, 12.0, 'completado'),
    (4,  2, 4, 3, 20240815, 14.0, 'activo'),
    (5,  3, 1, 1, 20240301, 8.0,  'completado'),
    (6,  3, 4, 3, 20240815, NULL, 'activo'),
    (7,  4, 3, 2, 20240301, 14.0, 'completado'),
    (8,  4, 5, 3, 20240815, NULL, 'activo'),
    (9,  5, 1, 1, 20240815, 16.0, 'activo'),
    (10, 5, 4, 3, 20240815, 19.0, 'activo'),
    (11, 5, 6, 4, 20240815, NULL, 'activo'),
    (12, 6, 2, 1, 20240301, 10.0, 'cancelado'),
    (13, 7, 4, 2, 20240301, 20.0, 'completado'),
    (14, 7, 4, 3, 20240815, 17.0, 'activo'),
    (15, 8, 1, 1, 20240301, 11.0, 'completado'),
    (16, 9, 4, 2, 20240301, 9.0,  'cancelado'),
    (17, 9, 5, 3, 20240301, 6.0,  'completado'),
    (18, 10, 5, 3, 20240815, NULL, 'activo');

-- ============================================================
-- ÍNDICES
-- ============================================================

CREATE INDEX idx_fact_estudiante ON fact_inscripcion(estudiante_id);
CREATE INDEX idx_fact_curso ON fact_inscripcion(curso_id);
CREATE INDEX idx_fact_profesor ON fact_inscripcion(profesor_id);
CREATE INDEX idx_fact_fecha ON fact_inscripcion(fecha_id);
