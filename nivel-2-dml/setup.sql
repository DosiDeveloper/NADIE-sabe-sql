-- Nivel 2 - DML: Manipulación de datos
-- Ejecutar: sqlite3 nivel2.db.sqlite3 < setup.sql

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
    activo INTEGER DEFAULT 1
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

-- Datos de ejemplo para practicar DML
INSERT INTO estudiantes (nombre, apellido, email, fecha_nacimiento, activo) VALUES
    ('Juan', 'Pérez', 'juan.perez@email.com', '2000-05-15', 1),
    ('María', 'García', 'maria.garcia@email.com', '1999-08-22', 1),
    ('Carlos', 'López', 'carlos.lopez@email.com', '2001-01-10', 1),
    ('Ana', 'Martínez', 'ana.martinez@email.com', '2000-11-03', 1),
    ('Pedro', 'Rodríguez', 'pedro.rodriguez@email.com', '1998-07-19', 0),
    ('Laura', 'Hernández', 'laura.hernandez@email.com', '2002-03-28', 1),
    ('Diego', 'Ramírez', 'diego.ramirez@email.com', '1999-12-05', 0);

INSERT INTO profesores (nombre, apellido, email, especialidad) VALUES
    ('Elena', 'Vargas', 'elena.vargas@email.com', 'Matemáticas'),
    ('Roberto', 'Silva', 'roberto.silva@email.com', 'Programación'),
    ('Sofía', 'Torres', 'sofia.torres@email.com', 'Bases de Datos');

INSERT INTO cursos (nombre, descripcion, creditos, nivel_dificultad) VALUES
    ('Álgebra Lineal', 'Fundamentos de álgebra lineal', 4, 'Básico'),
    ('Cálculo Diferencial', 'Introducción al cálculo', 5, 'Intermedio'),
    ('Programación en Python', 'Curso de Python desde cero', 4, 'Básico'),
    ('Bases de Datos', 'Diseño y consultas SQL', 5, 'Intermedio'),
    ('Machine Learning', 'Introducción al aprendizaje automático', 6, 'Avanzado');

INSERT INTO inscripciones (estudiante_id, curso_id, fecha_inscripcion, calificacion, estado) VALUES
    (1, 1, '2024-03-01', 15, 'completado'),
    (1, 3, '2024-03-01', 18, 'completado'),
    (2, 2, '2024-03-01', 12, 'completado'),
    (2, 4, '2024-08-15', 14, 'activo'),
    (3, 1, '2024-03-01', 8, 'completado'),
    (3, 4, '2024-08-15', NULL, 'activo'),
    (4, 3, '2024-08-15', NULL, 'activo'),
    (4, 5, '2024-08-15', NULL, 'activo'),
    (5, 2, '2024-03-01', 10, 'cancelado'),
    (6, 1, '2024-08-15', 16, 'activo'),
    (6, 5, '2024-08-15', NULL, 'activo');

INSERT INTO asignaciones (profesor_id, curso_id, semestre, año) VALUES
    (1, 1, '1S', 2024),
    (1, 2, '2S', 2024),
    (2, 3, '1S', 2024),
    (3, 4, '2S', 2024),
    (3, 5, '2S', 2024);
