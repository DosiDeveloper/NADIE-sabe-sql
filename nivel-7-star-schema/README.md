# Nivel 7 — Star Schema (Desnormalización para OLAP)

El Star Schema desnormaliza datos para hacer consultas analíticas más rápidas. Una **tabla de hechos** en el centro contiene las medidas, rodeada de **tablas de dimensión** con atributos descriptivos.

Este enfoque se usa en Data Warehousing, Business Intelligence y dashboards.

---

## De 3NF a Star Schema

Partimos del esquema normalizado del nivel anterior:

```
estudiantes(id, nombre, apellido, fecha_nacimiento, activo)
profesores(id, nombre, apellido, especialidad)
cursos(id, nombre, creditos, nivel_dificultad)
inscripciones(id, estudiante_id, curso_id, profesor_id, fecha, calificacion, estado)
```

Para convertirlo a estrella:
1. **Dimensiones**: desnormalizamos atributos y agregamos jerarquías (rango_edad, nombre_mes)
2. **Hechos**: la tabla de inscripciones pasa a ser `fact_inscripcion` con FK a cada dimensión

---

## Estructura del Star Schema

```
         ┌──────────────────────────┐
         │    dim_estudiante        │
         │ PK: estudiante_id        │
         │ nombre, apellido         │
         │ email, edad              │
         │ rango_edad, activo       │
         └───────────┬──────────────┘
                     │
┌──────────────┐     │     ┌──────────────────────┐
│  dim_curso   │─────┼─────│  fact_inscripcion    │
│ PK: curso_id │     │     │ PK: inscripcion_id   │
│ nombre       │     │     │ FK estudiante_id     │
│ creditos     │     │     │ FK curso_id          │
│ nivel_dif    │     │     │ FK profesor_id       │
│ ...          │     │     │ FK fecha_id          │
└──────────────┘     │     │ calificacion         │
                     │     │ estado               │
            ┌────────┴─────┴──────────────────────┘
            │  dim_profesor
            │ PK: profesor_id
            │ nombre, apellido
            │ especialidad
            └──────────────────────

            ┌──────────────────────┐
            │     dim_fecha        │
            │ PK: fecha_id         │
            │ fecha, dia, mes      │
            │ nombre_mes           │
            │ trimestre, anio      │
            └──────────────────────┘
```

## Tablas de dimensión

Contienen atributos descriptivos y suelen tener datos **redundantes** (desnormalizados) para evitar JOINs adicionales.

```sql
CREATE TABLE dim_estudiante (
    estudiante_id INTEGER PRIMARY KEY,
    nombre TEXT,
    apellido TEXT,
    email TEXT,
    edad INTEGER,
    rango_edad TEXT,      -- 'menor-20', '20-22', '23-25', 'mayor-25'
    activo INTEGER
);

CREATE TABLE dim_fecha (
    fecha_id INTEGER PRIMARY KEY,
    fecha DATE,
    dia INTEGER,
    mes INTEGER,
    nombre_mes TEXT,      -- 'Enero', 'Febrero', ...
    trimestre INTEGER,    -- 1, 2, 3, 4
    anio INTEGER
);
```

## Tabla de hechos

Contiene las **medidas numéricas** (calificacion) y claves foráneas a cada dimensión.

```sql
CREATE TABLE fact_inscripcion (
    inscripcion_id INTEGER PRIMARY KEY,
    estudiante_id INTEGER REFERENCES dim_estudiante,
    curso_id INTEGER REFERENCES dim_curso,
    profesor_id INTEGER REFERENCES dim_profesor,
    fecha_id INTEGER REFERENCES dim_fecha,
    calificacion REAL,
    estado TEXT
);
```

## Consultas en estrella

Las consultas usan JOINs simples: la tabla de hechos se une a cada dimensión por su PK.

```sql
-- Promedio por rango de edad y nivel de dificultad
SELECT
    e.rango_edad,
    c.nivel_dificultad,
    AVG(f.calificacion) AS promedio
FROM fact_inscripcion f
JOIN dim_estudiante e ON f.estudiante_id = e.estudiante_id
JOIN dim_curso c ON f.curso_id = c.curso_id
GROUP BY e.rango_edad, c.nivel_dificultad;

-- Calificación promedio por mes
SELECT
    d.nombre_mes,
    ROUND(AVG(f.calificacion), 1) AS promedio
FROM fact_inscripcion f
JOIN dim_fecha d ON f.fecha_id = d.fecha_id
WHERE f.calificacion IS NOT NULL
GROUP BY d.nombre_mes
ORDER BY d.mes;
```

## Normalizado vs Desnormalizado

| Aspecto          | 3NF (OLTP)                           | Star Schema (OLAP)              |
|------------------|--------------------------------------|----------------------------------|
| Redundancia      | Mínima                               | Alta (datos repetidos en dims)   |
| Actualización    | Rápida (un solo lugar)               | Lenta (varias filas afectadas)   |
| Consultas        | Muchos JOINs                         | JOINs simples, rápidos           |
| Uso              | Apps transaccionales (CRUD)          | BI, reporting, dashboards        |
| Ejemplo          | Registrar una venta                  | Analizar ventas por región/mes   |

---

## Base de datos de ejemplo

La base `nivel7.db.sqlite3` contiene el star schema poblado:

- **dim_estudiante** (10) — incluye edad calculada y rango_edad
- **dim_profesor** (4) — especialidad
- **dim_curso** (6) — nombre, creditos, nivel_dificultad
- **dim_fecha** (366) — todos los días de 2024
- **fact_inscripcion** (18) — cada inscripción con FK a las 4 dimensiones

## Ejercicios

1. Escribe una consulta que muestre la calificación promedio por cada especialidad de profesor y nivel de dificultad del curso
2. ¿Cuántas inscripciones hay en cada trimestre de 2024?
3. Muestra el nombre del estudiante, el curso y la calificación de todas las inscripciones activas
4. Compara: ¿cuántos JOINs necesitas en 3NF vs Star para obtener "promedio por especialidad del profesor y nivel del curso"?
5. Crea una consulta que cuente cuántos estudiantes hay en cada rango_edad
6. Diseña una dimensión `dim_ubicacion` con país, ciudad y agrégala al esquema
