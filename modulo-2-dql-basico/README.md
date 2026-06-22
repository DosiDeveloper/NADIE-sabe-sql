# Nivel 3 — DQL Básico (Data Query Language)

El DQL permite consultar y obtener datos almacenados en la base de datos.

## Conceptos

### SELECT básico

```sql
-- Seleccionar columnas específicas
SELECT nombre, apellido FROM estudiantes;

-- Todas las columnas
SELECT * FROM estudiantes;

-- Alias con AS
SELECT nombre AS "Nombre", apellido AS "Apellido" FROM estudiantes;
```

### WHERE

```sql
-- Operadores de comparación
SELECT * FROM estudiantes WHERE activo = 1;
SELECT * FROM estudiantes WHERE fecha_nacimiento > '2000-01-01';
SELECT * FROM estudiantes WHERE nombre LIKE 'A%';

-- Operadores lógicos
SELECT * FROM estudiantes
WHERE activo = 1 AND fecha_nacimiento > '2000-01-01';

SELECT * FROM estudiantes
WHERE activo = 0 OR email LIKE '%gmail.com';
```

### ORDER BY

```sql
SELECT nombre, apellido, fecha_nacimiento
FROM estudiantes
ORDER BY fecha_nacimiento DESC, apellido ASC;
```

### LIMIT y OFFSET

```sql
SELECT * FROM estudiantes LIMIT 5;
SELECT * FROM estudiantes LIMIT 5 OFFSET 10;  -- Página 3 (saltando 10)
```

### Funciones de agregación

```sql
SELECT COUNT(*) AS total_estudiantes FROM estudiantes;
SELECT AVG(calificacion) AS promedio FROM inscripciones;
SELECT MAX(calificacion) AS nota_max FROM inscripciones;
SELECT MIN(calificacion) AS nota_min FROM inscripciones;
SELECT SUM(creditos) AS total_creditos FROM cursos;
```

### GROUP BY y HAVING

```sql
-- Agrupar y contar
SELECT curso_id, COUNT(*) AS inscritos
FROM inscripciones
GROUP BY curso_id;

-- Filtrar grupos con HAVING
SELECT curso_id, AVG(calificacion) AS promedio
FROM inscripciones
GROUP BY curso_id
HAVING AVG(calificacion) >= 15;
```

### DISTINCT

```sql
SELECT DISTINCT estado FROM inscripciones;
```

## Base de datos de ejemplo

La base `nivel3.db.sqlite3` contiene datos poblados para practicar consultas.

## Ejercicios

1. Muestra todos los estudiantes ordenados por apellido alfabéticamente
2. ¿Cuántos estudiantes hay activos?
3. Lista los cursos con más de 3 créditos y nivel de dificultad 'Avanzado'
4. ¿Cuál es el promedio de calificaciones por curso? Muestra solo cursos con promedio >= 14
5. Muestra los 3 estudiantes con mayor calificación en cualquier curso
6. ¿Cuántas inscripciones hay por cada estado ('activo', 'completado', 'cancelado')?
