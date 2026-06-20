# Nivel 6 — Normalización (1NF → 2NF → 3NF)

La normalización elimina redundancia y evita anomalías dividiendo los datos en tablas relacionadas. Ideal para bases de datos transaccionales (OLTP).

---

## 1NF — Primera Forma Normal

Cada columna tiene un solo valor atómico y no hay grupos repetidos.

❌ **Mal** (varios valores en una columna):
```
estudiantes_cursos
| id | nombre | cursos                        |
|----|--------|-------------------------------|
| 1  | Juan   | Álgebra, Python, BD           |
```

✅ **Bien** (tabla separada):
```
estudiantes                inscripciones
| id | nombre |      | id | estudiante_id | curso_id |
|----|--------|      |----|---------------|----------|
| 1  | Juan   |      | 1  | 1             | 1        |
                     | 2  | 1             | 2        |
```

### Reglas de 1NF

- Cada celda contiene un único valor
- Todas las filas tienen la misma cantidad de columnas
- Los nombres de columna son únicos
- El orden de filas y columnas no importa

---

## 2NF — Segunda Forma Normal

Está en 1NF y **no hay dependencias parciales**: columnas que dependen solo de parte de la clave primaria compuesta.

❌ **Violación**: tabla con PK compuesta `(estudiante_id, curso_id)`:
```
| estudiante_id | curso_id | nombre_estudiante | calificacion |
|---------------|----------|-------------------|--------------|
| 1             | 1        | Juan              | 15           |
| 1             | 2        | Juan              | 18           |
```

`nombre_estudiante` depende solo de `estudiante_id`, no de toda la PK compuesta.

✅ **Solución**: separar en dos tablas:
```
estudiantes (id PK, nombre)
inscripciones (id PK, estudiante_id FK, curso_id FK, calificacion)
```

---

## 3NF — Tercera Forma Normal

Está en 2NF y **no hay dependencias transitivas**: una columna no clave depende de otra columna no clave.

❌ **Violación**:
```
inscripciones
| id | estudiante_id | curso_id | curso_nombre | curso_creditos | calificacion |
```

`curso_nombre` y `curso_creditos` dependen de `curso_id`, no de la inscripción.

✅ **Solución**: crear tabla `cursos` separada:
```
cursos (id PK, nombre, creditos)
inscripciones (id PK, estudiante_id FK, curso_id FK, calificacion)
```

---

## Esquema 3NF del curso

Las tablas que usamos desde el nivel 1 están en 3NF:

```
estudiantes (id, nombre, apellido, email, fecha_nacimiento, activo)
     │
     │  ┌─────────────────────┐
     ├──│ inscripciones       │
     │  │ (id, estudiante_id,│── cursos (id, nombre, creditos, nivel)
     │  │  curso_id, fecha,   │
     │  │  calificacion,      │
     │  │  estado,            │
     │  │  profesor_id)       │
     │  └─────────┬───────────┘
     │            │
profesores ───────┘
(id, nombre,     asignaciones (profesor_id, curso_id, semestre, año)
 apellido, email,
 especialidad)
```

### Ventajas
- **Sin redundancia**: cada dato se guarda una sola vez
- **Integridad**: actualizar el email de un estudiante se hace en un solo lugar
- **Menos espacio**: no se repite información

### Desventajas
- **Muchos JOINs**: consultar "promedio por especialidad del profesor" requiere unir 3 o 4 tablas
- **Rendimiento en análisis**: las consultas masivas se vuelven lentas

---

## Base de datos de ejemplo

La base `nivel6.db.sqlite3` contiene solo el esquema 3NF poblado:

- `estudiantes`, `profesores`, `cursos`, `inscripciones`, `asignaciones`

## Ejercicios

1. Identifica qué forma normal violaría una tabla con columnas `estudiante_id, nombre, curso1, curso2, curso3`
2. Convierte a 3NF: `ventas(id, producto_nombre, producto_categoria, cliente_nombre, cliente_ciudad, monto)`
3. ¿Qué dependencia parcial existe en `matriculas(estudiante_id, curso_id, nombre_estudiante, fecha_matricula)`?
4. ¿Qué dependencia transitiva existe en `pedidos(id, cliente_id, cliente_direccion, total)`?
5. Normaliza: `libros(id, titulo, autor_nombre, autor_pais, año)` a 3NF
