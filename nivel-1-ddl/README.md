# Nivel 1 — DDL (Data Definition Language)

El DDL permite definir la estructura de la base de datos: tablas, columnas, tipos de datos y restricciones.

## Conceptos

### CREATE TABLE

```sql
CREATE TABLE estudiantes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    apellido TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    fecha_nacimiento DATE,
    activo INTEGER DEFAULT 1
);
```

### Tipos de datos en SQLite

| Tipo     | Descripción                  |
|----------|------------------------------|
| INTEGER  | Número entero                |
| REAL     | Número decimal               |
| TEXT     | Cadena de texto              |
| BLOB     | Datos binarios               |
| DATE     | Fecha (se almacena como TEXT)|

### Constraints

| Constraint    | Descripción                         |
|---------------|-------------------------------------|
| PRIMARY KEY   | Identificador único de la fila      |
| NOT NULL      | No permite valores nulos            |
| UNIQUE        | Valor único en toda la columna      |
| DEFAULT       | Valor por defecto                   |
| CHECK         | Valida una condición lógica         |
| FOREIGN KEY   | Relación con otra tabla             |

### ALTER TABLE

```sql
-- Agregar columna
ALTER TABLE estudiantes ADD COLUMN telefono TEXT;

-- Renombrar tabla
ALTER TABLE estudiantes RENAME TO alumnos;
```

### DROP TABLE

```sql
DROP TABLE IF EXISTS estudiantes;
```

## Base de datos de ejemplo

La base `nivel1.db.sqlite3` contiene las tablas vacías listas para que practiques DDL.

### Esquema

- **estudiantes**: id, nombre, apellido, email, fecha_nacimiento, activo
- **profesores**: id, nombre, apellido, email, especialidad
- **cursos**: id, nombre, descripcion, creditos, nivel_dificultad
- **inscripciones**: id, estudiante_id (FK), curso_id (FK), fecha_inscripcion, calificacion, estado
- **asignaciones**: id, profesor_id (FK), curso_id (FK), semestre, año

## Ejercicios

1. Crea una tabla `categorias` con id (PK), nombre (UNIQUE, NOT NULL) y descripcion
2. Agrega una columna `fecha_creacion` a la tabla `cursos`
3. Crea un índice sobre el campo `email` de la tabla `estudiantes`
4. Elimina la tabla `asignaciones`
5. Crea una tabla `evaluaciones` con id, inscripcion_id (FK), nota (REAL), fecha (DEFAULT CURRENT_DATE), CHECK (nota >= 0 AND nota <= 20)
