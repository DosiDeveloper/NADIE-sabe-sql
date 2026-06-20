-- Nivel 1 - DDL: Creación de esquema
-- Ejecutar: sqlite3 nivel1.db.sqlite3 < setup.sql

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
