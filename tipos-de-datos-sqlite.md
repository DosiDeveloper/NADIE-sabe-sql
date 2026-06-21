# Tipos de Datos en SQLite3

SQLite3 utiliza un sistema de **tipado dinámico** o _flexible_ (no estático como otros DBMS). Cada valor almacenado tiene un tipo asociado, no la columna en sí. Sin embargo, se recomienda declarar tipos por documentación y compatibilidad.

## Storage Classes (Clases de Almacenamiento)

SQLite3 clasifica los valores en **5 storage classes**:

| Storage Class | Descripción                                               | Restricciones / Notas                                                                                | Ejemplo                                       |
| ------------- | --------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| `NULL`        | Ausencia de valor.                                        | No ocupa espacio significativo.                                                                      | `INSERT INTO t VALUES (NULL);`                |
| `INTEGER`     | Número entero con signo.                                  | Puede almacenarse en 1, 2, 3, 4, 6 u 8 bytes según la magnitud del valor. Rango: `-2^63` a `2^63-1`. | `edad INTEGER` → `25`, `-10`, `9999999999999` |
| `REAL`        | Número en punto flotante de 64 bits (IEEE 754).           | Aproximación decimal. Útil para mediciones, promedios, etc.                                          | `precio REAL` → `19.99`, `3.1416`             |
| `TEXT`        | Cadena de texto codificada en UTF-8, UTF-16BE o UTF-16LE. | Sin límite de longitud (depende de la memoria disponible).                                           | `nombre TEXT` → `'Juan'`, `'Hola mundo'`      |
| `BLOB`        | Datos binarios (imágenes, archivos, etc.).                | Se almacena exactamente como se ingresa (sin codificación de texto).                                 | `foto BLOB` → `x'FFD8FF'`                     |

## Type Affinities (Afinidades de Tipo)

Aunque SQLite3 acepta cualquier nombre de tipo al crear una columna, asigna una **afinidad** que determina cómo se convierten los valores al insertarse. Las 5 afinidades son:

| Afinidad    | Regla de asignación                                                      | Comportamiento                                                 |
| ----------- | ------------------------------------------------------------------------ | -------------------------------------------------------------- |
| **TEXT**    | Tipos que contengan: `CHAR`, `CLOB`, `TEXT`                              | Los valores se convierten a TEXT.                              |
| **NUMERIC** | Tipos que contengan: `NUMERIC`, `DECIMAL`, `BOOLEAN`, `DATE`, `DATETIME` | Intenta almacenar como INTEGER o REAL; si no puede, como TEXT. |
| **INTEGER** | Tipos que contengan: `INT` o `INTEGER`                                   | Intenta almacenar como INTEGER.                                |
| **REAL**    | Tipos que contengan: `REAL`, `FLOAT`, `DOUBLE`                           | Intenta almacenar como REAL.                                   |
| **BLOB**    | Ninguna de las anteriores o se usa `BLOB` explícitamente                 | Sin conversión.                                                |

> **Importante:** Si declaras `INTEGER PRIMARY KEY`, la columna se convierte en _alias del `rowid`_ y auto-incrementa.

## Booleanos

No existe tipo `BOOLEAN`. Se almacenan como `INTEGER` con valores `0` (false) y `1` (true). SQLite3 permite la sintaxis `TRUE` y `FALSE` como constantes que se traducen a `1` y `0`.

```sql
CREATE EXAMPLE booleano_ejemplo (activo BOOLEAN);
INSERT INTO booleano_ejemplo VALUES (TRUE), (FALSE);
-- Internamente: 1, 0
```

## Fechas y Horas

No existe tipo `DATE`, `TIME` ni `DATETIME`. Se almacenan como `TEXT`, `REAL` o `INTEGER` según la función de conveniencia:

| Funcion de almacenamiento | Tipo real | Ejemplo                       |
| ------------------------- | --------- | ----------------------------- |
| `DATE(...)`               | TEXT      | `'2026-06-21'`                |
| `DATETIME(...)`           | TEXT      | `'2026-06-21 10:30:00'`       |
| `JULIANDAY(...)`          | REAL      | `2461234.5` (día juliano)     |
| `strftime('%s', ...)`     | INTEGER   | `1784737800` (Unix timestamp) |

```sql
CREATE TABLE eventos (
    id             INTEGER PRIMARY KEY,
    fecha_creacion TEXT DEFAULT (DATE('now')),
    timestamp_unix INTEGER DEFAULT (strftime('%s', 'now'))
);
```

## Ejemplo completo

```sql
CREATE TABLE productos (
    id          INTEGER PRIMARY KEY,
    nombre      TEXT    NOT NULL,
    precio      REAL    NOT NULL DEFAULT 0.0,
    stock       INTEGER NOT NULL DEFAULT 0,
    descripcion TEXT,
    activo      BOOL    NOT NULL DEFAULT TRUE,      -- booleano
    creado_en   TEXT    DEFAULT (DATETIME('now')),
    foto        BLOB
);

INSERT INTO productos (nombre, precio, stock, descripcion, activo)
VALUES ('Laptop Gamer', 1599.99, 10, 'RTX 5090, 64GB RAM', 1);
```

## Resumen rápido

| ¿Necesitas...?        | Usa                                     |
| --------------------- | --------------------------------------- |
| IDs autoincrementales | `INTEGER PRIMARY KEY`                   |
| Texto corto/largo     | `TEXT`                                  |
| Números sin decimales | `INTEGER`                               |
| Números con decimales | `REAL`                                  |
| Fechas                | `TEXT` con `DATE()` / `DATETIME()`      |
| Booleanos             | `INTEGER` con `0` / `1`                 |
| Archivos binarios     | `BLOB`                                  |
| Valores nulos         | `NULL` (o simplemente omite la columna) |
