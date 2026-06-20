# Nivel 4 — DQL Avanzado

Consultas que involucran múltiples tablas y técnicas más complejas.

## Conceptos

### JOINs

```sql
-- INNER JOIN: solo filas que coinciden en ambas tablas
SELECT e.nombre, e.apellido, c.nombre AS curso
FROM estudiantes e
JOIN inscripciones i ON e.id = i.estudiante_id
JOIN cursos c ON i.curso_id = c.id;

-- LEFT JOIN: todas las filas de la izquierda
SELECT e.nombre, e.apellido, i.fecha_inscripcion
FROM estudiantes e
LEFT JOIN inscripciones i ON e.id = i.estudiante_id;

-- CROSS JOIN: producto cartesiano
SELECT e.nombre, c.nombre
FROM estudiantes e
CROSS JOIN cursos c;
```

### Subconsultas

```sql
-- Subconsulta escalar (devuelve un solo valor)
SELECT nombre, apellido FROM estudiantes
WHERE id = (SELECT estudiante_id FROM inscripciones WHERE calificacion = (SELECT MAX(calificacion) FROM inscripciones));

-- Subconsulta de tabla
SELECT * FROM cursos
WHERE id IN (SELECT curso_id FROM inscripciones WHERE estado = 'activo');

-- Subconsulta correlacionada
SELECT e.nombre, e.apellido,
    (SELECT COUNT(*) FROM inscripciones i WHERE i.estudiante_id = e.id) AS total_cursos
FROM estudiantes e;
```

### UNION

```sql
SELECT nombre, apellido, 'Estudiante' AS rol FROM estudiantes
UNION
SELECT nombre, apellido, 'Profesor' AS rol FROM profesores
ORDER BY nombre;
```

### CREATE VIEW

```sql
CREATE VIEW v_estudiantes_activos AS
SELECT id, nombre, apellido, email
FROM estudiantes
WHERE activo = 1;
```

### Índices

```sql
CREATE INDEX idx_estudiantes_email ON estudiantes(email);
```

## Base de datos de ejemplo

La base `nivel4.db.sqlite3` tiene datos más extensos para practicar consultas complejas.

## Ejercicios

1. Lista cada estudiante con el nombre del curso en el que está inscrito y su calificación
2. Muestra los estudiantes que NO están inscritos en ningún curso (usa LEFT JOIN)
3. Encuentra el curso con más estudiantes inscritos
4. Muestra el nombre del profesor y los cursos que enseña, incluyendo profesores sin cursos asignados
5. Crea una vista `v_resumen_estudiantes` que muestre: nombre del estudiante, cantidad de cursos, promedio de calificaciones
6. Usa una subconsulta para encontrar estudiantes con calificación superior al promedio general
