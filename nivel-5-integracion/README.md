# Nivel 5 — Integración (DDL + DML + DQL)

Ejercicios completos que combinan todo lo aprendido.

## Casos prácticos

### Caso 1: Sistema de biblioteca

Diseña e implementa un pequeño sistema para una biblioteca:

1. **DDL**: Crea las tablas `libros` (id, titulo, autor, año, disponible), `usuarios` (id, nombre, email), `prestamos` (id, libro_id FK, usuario_id FK, fecha_prestamo, fecha_devolucion, estado)
2. **DML**: Inserta 5 libros, 3 usuarios y algunos préstamos. Marca un libro como devuelto
3. **DQL**: ¿Qué libros están actualmente prestados? ¿Qué usuario tiene más préstamos? ¿Cuántos libros hay por autor?

### Caso 2: Reporte académico

Genera un reporte usando los datos existentes:

1. Crea una vista `v_reporte_notas` con: nombre del estudiante, curso, calificación, y una columna calculada `estado_nota` ('aprobado' si >= 11, 'desaprobado' si < 11)
2. Muestra cuántos estudiantes aprobaron y desaprobaron por curso
3. Encuentra el estudiante con el promedio más alto

### Caso 3: Limpieza de datos

1. Busca estudiantes con email duplicado
2. Actualiza los registros inactivos: cambia su estado a 'inactivo' y guarda la fecha de baja
3. Elimina todos los prestamos cancelados de hace más de un año

## Mini-proyecto final

Diseña un esquema para un **sistema de gestión de tareas** con:

- `usuarios`: id, nombre, email, rol (admin/regular)
- `proyectos`: id, nombre, descripcion, fecha_creacion, creador_id (FK)
- `tareas`: id, proyecto_id (FK), titulo, descripcion, prioridad (alta/media/baja), estado (pendiente/en_progreso/completada), asignado_a (FK usuarios), fecha_limite

Pobla con datos de ejemplo y escribe consultas que:
1. Muestren las tareas pendientes de un usuario ordenadas por prioridad
2. Cuenten cuántas tareas tiene cada proyecto
3. Muestren los proyectos sin tareas asignadas
4. Calculen el porcentaje de tareas completadas por proyecto

## Base de datos de ejemplo

La base `nivel5.db.sqlite3` contiene datos completos de todas las tablas para resolver los ejercicios.
