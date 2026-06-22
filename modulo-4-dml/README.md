# Nivel 2 — DML (Data Manipulation Language)

El DML permite insertar, actualizar y eliminar datos dentro de las tablas.

## Conceptos

### INSERT

```sql
-- Insertar una fila
INSERT INTO estudiantes (nombre, apellido, email, fecha_nacimiento)
VALUES ('Juan', 'Pérez', 'juan@email.com', '2000-05-15');

-- Insertar múltiples filas
INSERT INTO estudiantes (nombre, apellido, email) VALUES
    ('Ana', 'García', 'ana@email.com'),
    ('Luis', 'Martínez', 'luis@email.com');

-- Insertar desde otra tabla
INSERT INTO estudiantes_activos (id, nombre, apellido, email)
SELECT id, nombre, apellido, email FROM estudiantes WHERE activo = 1;
```

### UPDATE

```sql
-- Actualizar una fila
UPDATE estudiantes SET activo = 0 WHERE id = 1;

-- Actualizar múltiples columnas
UPDATE estudiantes
SET activo = 1, email = 'juan.nuevo@email.com'
WHERE id = 1;
```

### DELETE

```sql
-- Eliminar una fila
DELETE FROM estudiantes WHERE id = 1;

-- Eliminar todas las filas (mantiene la tabla)
DELETE FROM estudiantes;
```

### Transacciones

Las transacciones agrupan operaciones que se ejecutan como una sola unidad.

```sql
BEGIN TRANSACTION;

UPDATE cuentas SET saldo = saldo - 100 WHERE id = 1;
UPDATE cuentas SET saldo = saldo + 100 WHERE id = 2;

COMMIT;  -- Confirma los cambios
-- ROLLBACK;  -- Deshace los cambios
```

## Base de datos de ejemplo

La base `nivel2.db.sqlite3` tiene las tablas con datos de ejemplo para practicar DML.

## Ejercicios

1. Inserta un nuevo profesor llamado "María López" con especialidad en "Matemáticas"
2. Actualiza la calificación a 18 de todas las inscripciones del curso con id = 3
3. Elimina todos los estudiantes que tengan `activo = 0`
4. Crea una transacción que inscriba a un estudiante en un curso (INSERT en inscripciones) y actualice el contador de estudiantes del curso. Si algo falla, haz ROLLBACK
5. Inserta 3 nuevos cursos usando una sola sentencia INSERT
