-- Nivel 5 - Integración: DDL + DML + DQL
-- Ejecutar: sqlite5 nivel5.db.sqlite3 < setup.sql

DROP TABLE IF EXISTS asignaciones;
DROP TABLE IF EXISTS inscripciones;
DROP TABLE IF EXISTS cursos;
DROP TABLE IF EXISTS profesores;
DROP TABLE IF EXISTS estudiantes;

CREATE TABLE estudiantes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    fecha_nacimiento DATE,
    activo INTEGER DEFAULT 1,
    fecha_baja DATE
);

CREATE TABLE profesores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    especialidad TEXT NOT NULL
);

CREATE TABLE cursos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    descripcion TEXT,
    creditos INTEGER NOT NULL CHECK (creditos > 0),
    nivel_dificultad TEXT NOT NULL CHECK (nivel_dificultad IN ('Básico', 'Intermedio', 'Avanzado'))
);

CREATE TABLE inscripciones (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    estudiante_id INTEGER NOT NULL,
    curso_id INTEGER NOT NULL,
    fecha_inscripcion DATE DEFAULT (DATE('now')),
    calificacion REAL CHECK (calificacion IS NULL OR (calificacion >= 0 AND calificacion <= 20)),
    estado TEXT DEFAULT 'activo' CHECK (estado IN ('activo', 'completado', 'cancelado')),
    FOREIGN KEY (estudiante_id) REFERENCES estudiantes(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

CREATE TABLE asignaciones (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    profesor_id INTEGER NOT NULL,
    curso_id INTEGER NOT NULL,
    semestre TEXT NOT NULL CHECK (semestre IN ('1S', '2S')),
    año INTEGER NOT NULL,
    FOREIGN KEY (profesor_id) REFERENCES profesores(id),
    FOREIGN KEY (curso_id) REFERENCES cursos(id)
);

CREATE INDEX idx_estudiantes_email ON estudiantes(email);
CREATE INDEX idx_inscripciones_estudiante ON inscripciones(estudiante_id);
CREATE INDEX idx_inscripciones_curso ON inscripciones(curso_id);

INSERT INTO estudiantes (nombre, apellido, email, fecha_nacimiento, activo, fecha_baja) VALUES
    ('Juan', 'Pérez', 'juan.perez@email.com', '2000-05-15', 1, NULL),
    ('María', 'García', 'maria.garcia@email.com', '1999-08-22', 1, NULL),
    ('Carlos', 'López', 'carlos.lopez@email.com', '2001-01-10', 1, NULL),
    ('Ana', 'Martínez', 'ana.martinez@email.com', '2000-11-03', 1, NULL),
    ('Pedro', 'Rodríguez', 'pedro.rodriguez@email.com', '1998-07-19', 0, '2024-06-15'),
    ('Laura', 'Hernández', 'laura.hernandez@email.com', '2002-03-28', 1, NULL),
    ('Diego', 'Ramírez', 'diego.ramirez@email.com', '1999-12-05', 0, '2024-04-10'),
    ('Sofía', 'Cruz', 'sofia.cruz@email.com', '2001-06-14', 1, NULL),
    ('Miguel', 'Torres', 'miguel.torres@email.com', '2000-09-30', 1, NULL),
    ('Valentina', 'Reyes', 'valentina.reyes@email.com', '1999-04-18', 0, '2024-05-20'),
    ('Fernando', 'Castillo', 'fernando.castillo@email.com', '2001-02-20', 1, NULL),
    ('Gabriela', 'Ortiz', 'gabriela.ortiz@email.com', '1998-10-11', 1, NULL),
    ('Hugo', 'Díaz', 'hugo.diaz@email.com', '2002-07-08', 1, NULL),
    ('Isabel', 'Flores', 'isabel.flores@email.com', '2000-12-25', 1, NULL),
    ('Javier', 'Morales', 'javier.morales@email.com', '2001-04-02', 1, NULL);

INSERT INTO profesores (nombre, apellido, email, especialidad) VALUES
    ('Elena', 'Vargas', 'elena.vargas@email.com', 'Matemáticas'),
    ('Roberto', 'Silva', 'roberto.silva@email.com', 'Programación'),
    ('Sofía', 'Torres', 'sofia.torres@email.com', 'Bases de Datos'),
    ('Andrés', 'Mendoza', 'andres.mendoza@email.com', 'Redes'),
    ('Carmen', 'Rivas', 'carmen.rivas@email.com', 'Inteligencia Artificial'),
    ('Luis', 'Peña', 'luis.pena@email.com', 'Sistemas Operativos');

INSERT INTO cursos (nombre, descripcion, creditos, nivel_dificultad) VALUES
    ('Álgebra Lineal', 'Fundamentos de álgebra lineal', 4, 'Básico'),
    ('Cálculo Diferencial', 'Introducción al cálculo', 5, 'Intermedio'),
    ('Cálculo Integral', 'Continuación del cálculo', 5, 'Avanzado'),
    ('Programación en Python', 'Curso de Python desde cero', 4, 'Básico'),
    ('Estructuras de Datos', 'Listas, pilas, colas y árboles', 4, 'Intermedio'),
    ('Bases de Datos', 'Diseño y consultas SQL', 5, 'Intermedio'),
    ('Redes de Computadoras', 'Fundamentos de redes', 4, 'Básico'),
    ('Machine Learning', 'Introducción al aprendizaje automático', 6, 'Avanzado'),
    ('Deep Learning', 'Redes neuronales profundas', 6, 'Avanzado'),
    ('Estadística Aplicada', 'Estadística para ciencia de datos', 5, 'Intermedio');

INSERT INTO inscripciones (estudiante_id, curso_id, fecha_inscripcion, calificacion, estado) VALUES
    (1, 1, '2024-03-01', 15, 'completado'),
    (1, 3, '2024-03-01', 18, 'completado'),
    (1, 6, '2024-08-15', NULL, 'activo'),
    (2, 2, '2024-03-01', 12, 'completado'),
    (2, 4, '2024-03-01', 16, 'completado'),
    (2, 6, '2024-08-15', 14, 'activo'),
    (2, 10, '2024-08-15', NULL, 'activo'),
    (3, 1, '2024-03-01', 8, 'completado'),
    (3, 4, '2024-03-01', 11, 'completado'),
    (3, 6, '2024-08-15', NULL, 'activo'),
    (4, 3, '2024-03-01', 14, 'completado'),
    (4, 4, '2024-08-15', NULL, 'activo'),
    (4, 8, '2024-08-15', NULL, 'activo'),
    (5, 2, '2024-03-01', 10, 'cancelado'),
    (5, 5, '2024-03-01', 7, 'completado'),
    (5, 6, '2024-03-01', 12, 'cancelado'),
    (6, 1, '2024-08-15', 16, 'activo'),
    (6, 4, '2024-08-15', 19, 'activo'),
    (6, 8, '2024-08-15', NULL, 'activo'),
    (7, 5, '2024-03-01', 13, 'completado'),
    (7, 7, '2024-08-15', NULL, 'activo'),
    (8, 4, '2024-03-01', 20, 'completado'),
    (8, 6, '2024-08-15', 17, 'activo'),
    (8, 9, '2024-08-15', NULL, 'activo'),
    (9, 1, '2024-03-01', 11, 'completado'),
    (9, 3, '2024-08-15', NULL, 'activo'),
    (9, 7, '2024-08-15', NULL, 'activo'),
    (10, 4, '2024-03-01', 9, 'cancelado'),
    (10, 8, '2024-03-01', 6, 'completado'),
    (10, 10, '2024-03-01', 13, 'completado'),
    (11, 5, '2024-08-15', NULL, 'activo'),
    (11, 6, '2024-08-15', NULL, 'activo'),
    (11, 9, '2024-08-15', NULL, 'activo'),
    (12, 2, '2024-03-01', 19, 'completado'),
    (12, 5, '2024-03-01', 18, 'completado'),
    (12, 8, '2024-08-15', NULL, 'activo'),
    (13, 1, '2024-03-01', 14, 'completado'),
    (13, 4, '2024-08-15', NULL, 'activo'),
    (14, 6, '2024-03-01', 12, 'completado'),
    (14, 7, '2024-03-01', 15, 'completado'),
    (14, 9, '2024-08-15', NULL, 'activo'),
    (15, 1, '2024-08-15', NULL, 'activo'),
    (15, 5, '2024-08-15', NULL, 'activo'),
    (15, 8, '2024-08-15', NULL, 'activo'),
    (15, 10, '2024-08-15', NULL, 'activo');

INSERT INTO asignaciones (profesor_id, curso_id, semestre, año) VALUES
    (1, 1, '1S', 2024),
    (1, 2, '1S', 2024),
    (1, 3, '2S', 2024),
    (1, 10, '2S', 2024),
    (2, 4, '1S', 2024),
    (2, 5, '2S', 2024),
    (2, 5, '1S', 2025),
    (3, 6, '1S', 2024),
    (3, 6, '2S', 2024),
    (4, 7, '2S', 2024),
    (4, 7, '1S', 2025),
    (5, 8, '2S', 2024),
    (5, 8, '1S', 2025),
    (5, 9, '2S', 2024),
    (6, 4, '2S', 2024),
    (6, 10, '1S', 2025);

-- Vistas de ejemplo
CREATE VIEW v_estudiantes_activos AS
SELECT id, nombre, apellido, email
FROM estudiantes
WHERE activo = 1;

CREATE VIEW v_cursos_con_inscritos AS
SELECT c.id, c.nombre, COUNT(i.id) AS total_inscritos
FROM cursos c
LEFT JOIN inscripciones i ON c.id = i.curso_id
GROUP BY c.id;

CREATE VIEW v_reporte_notas AS
SELECT
    e.nombre || ' ' || e.apellido AS estudiante,
    c.nombre AS curso,
    i.calificacion,
    CASE WHEN i.calificacion >= 11 THEN 'aprobado' ELSE 'desaprobado' END AS estado_nota
FROM inscripciones i
JOIN estudiantes e ON i.estudiante_id = e.id
JOIN cursos c ON i.curso_id = c.id
WHERE i.calificacion IS NOT NULL;
