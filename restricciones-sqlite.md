# Restricciones (Constraints) en SQLite3

Las restricciones permiten definir reglas sobre los datos que puede almacenar una columna o tabla. SQLite3 soporta la mayoría de constraints del estándar SQL.

## Tipos de Restricciones

| Constraint      | Nivel      | Descripción                                                   |
| --------------- | ---------- | ------------------------------------------------------------- |
| `NOT NULL`      | Columna    | La columna no puede almacenar `NULL`.                         |
| `UNIQUE`        | Columna/Tabla | Cada valor en la columna debe ser único.                    |
| `PRIMARY KEY`   | Columna/Tabla | Combina `NOT NULL` + `UNIQUE`. Identifica cada fila.        |
| `FOREIGN KEY`   | Tabla      | Garantiza integridad referencial entre tablas.                |
| `CHECK`         | Columna/Tabla | Valida que se cumpla una expresión booleana.                |
| `DEFAULT`       | Columna    | Asigna un valor por defecto si no se provee uno.              |

## `NOT NULL`

```sql
CREATE TABLE usuarios (
    id    INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL,
    email TEXT NOT NULL
);

INSERT INTO usuarios (nombre) VALUES ('Ana');
-- Error: NOT NULL constraint failed: usuarios.email
```

## `UNIQUE`

```sql
CREATE TABLE usuarios (
    id     INTEGER PRIMARY KEY,
    email  TEXT NOT NULL UNIQUE,
    cedula TEXT UNIQUE
);

INSERT INTO usuarios (email) VALUES ('a@a.com');
INSERT INTO usuarios (email) VALUES ('a@a.com');
-- Error: UNIQUE constraint failed: usuarios.email
```

> `NULL` sí se permiten en una columna `UNIQUE` (a menos que tenga `NOT NULL`). Múltiples `NULL` no violan `UNIQUE`.

## `PRIMARY KEY`

```sql
CREATE TABLE productos (
    id    INTEGER PRIMARY KEY,  -- alias de rowid, auto-incremento implícito
    nombre TEXT NOT NULL
);
```

- `INTEGER PRIMARY KEY` convierte la columna en alias del `rowid`, dando auto-incremento gratis, sin burocracia de `AUTOINCREMENT` (que evita reusar IDs).
- Se puede definir `PRIMARY KEY` compuesta a nivel de tabla:

```sql
CREATE TABLE matricula (
    id_estudiante INTEGER NOT NULL,
    id_curso      INTEGER NOT NULL,
    anio          INTEGER NOT NULL DEFAULT 2026,
    PRIMARY KEY (id_estudiante, id_curso, anio)
);
```

## `FOREIGN KEY`

Debe activarse el soporte con `PRAGMA foreign_keys = ON;` (por defecto está apagado en SQLite3).

```sql
PRAGMA foreign_keys = ON;

CREATE TABLE departamentos (
    id   INTEGER PRIMARY KEY,
    nombre TEXT NOT NULL
);

CREATE TABLE empleados (
    id              INTEGER PRIMARY KEY,
    nombre          TEXT NOT NULL,
    id_departamento INTEGER NOT NULL,
    FOREIGN KEY (id_departamento)
        REFERENCES departamentos(id)
        ON DELETE CASCADE
        ON UPDATE SET NULL
);
```

### Cláusulas referenciales

| Cláusula       | Comportamiento                                           |
| -------------- | -------------------------------------------------------- |
| `ON DELETE NO ACTION` | No hace nada (predeterminado).                    |
| `ON DELETE RESTRICT`  | Impide borrar si hay referencias (no soportado, usa NO ACTION). |
| `ON DELETE SET NULL`  | Pone `NULL` en las referencias al borrar.                |
| `ON DELETE SET DEFAULT`| Pone el `DEFAULT` en las referencias al borrar.         |
| `ON DELETE CASCADE`   | Borra en cascada todas las referencias.                  |
| `ON UPDATE ...`       | Mismo comportamiento pero al actualizar la clave padre.  |

## `CHECK`

Evalúa una expresión booleana al insertar o actualizar:

```sql
CREATE TABLE empleados (
    id     INTEGER PRIMARY KEY,
    salario REAL NOT NULL CHECK (salario > 0),
    edad    INTEGER CHECK (edad >= 18 AND edad <= 100)
);

INSERT INTO empleados (salario, edad) VALUES (-100, 20);
-- Error: CHECK constraint failed: salario > 0
```

También se puede definir a nivel de tabla para validar entre columnas:

```sql
CREATE TABLE pedidos (
    id           INTEGER PRIMARY KEY,
    fecha_inicio TEXT NOT NULL,
    fecha_fin    TEXT NOT NULL,
    CHECK (fecha_fin > fecha_inicio)
);
```

## `DEFAULT`

```sql
CREATE TABLE articulos (
    id        INTEGER PRIMARY KEY,
    nombre    TEXT NOT NULL,
    creado_en TEXT DEFAULT (DATE('now')),
    stock     INTEGER NOT NULL DEFAULT 0,
    activo    INTEGER NOT NULL DEFAULT 1
);

INSERT INTO articulos (nombre) VALUES ('Teclado');
-- creado_en → '2026-06-22', stock → 0, activo → 1
```

> Se usa `(expresión)` con paréntesis para funciones como `DATE('now')`. Sin paréntesis solo acepta literales.

## Combinación de restricciones

```sql
CREATE TABLE facturas (
    id         INTEGER PRIMARY KEY,
    codigo     TEXT NOT NULL UNIQUE,
    total      REAL NOT NULL CHECK (total >= 0) DEFAULT 0,
    pagada     INTEGER NOT NULL DEFAULT 0 CHECK (pagada IN (0,1)),
    cliente_id INTEGER NOT NULL,
    creada_en  TEXT DEFAULT (DATETIME('now')),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);
```

## Tips para la vida real

1. **`PRAGMA foreign_keys = ON;` debe ejecutarse en cada conexión.** SQLite3 no lo activa por defecto. En DBeaver se configura en propiedades de conexión.

2. **Evita `AUTOINCREMENT` a menos que necesites IDs irrepetibles.** `INTEGER PRIMARY KEY` reusa IDs de filas eliminadas, pero es más rápido y eficiente. `AUTOINCREMENT` garantiza IDs siempre crecientes a costa de rendimiento.

3. **`CHECK` es frágil al migrar.** Si cambias reglas de negocio, necesitas recrear la tabla. Para validaciones complejas que cambian seguido, mejor controlalas en la aplicación.

4. **Los `NULL`s y `UNIQUE` conviven.** Una columna `UNIQUE` permite múltiples `NULL`s (el estándar SQL lo define así). Si necesitas que `NULL` tampoco se repita, agrégale `NOT NULL`.

5. **Nombra tus constraints** para tener errores más claros (solo en `CHECK` y `UNIQUE` de tabla):

```sql
CREATE TABLE empleados (
    id INTEGER PRIMARY KEY,
    salario REAL NOT NULL
        CONSTRAINT salario_positivo CHECK (salario > 0)
);
```

6. **`FOREIGN KEY` sin índice es lento.** Si haces joins frecuentes por la FK, crea un índice explícito:

```sql
CREATE INDEX idx_empleados_departamento
    ON empleados(id_departamento);
```

7. **`ON DELETE CASCADE` con cuidado.** Un borrado accidental en la tabla padre puede arrasar datos en tablas hijas sin advertencia. Evalúa usar `SET NULL` o `RESTRICT` (restringir en la app) si los datos son sensibles.

8. **Diseña desde el día 1 con restricciones.** Agregar `NOT NULL` o `UNIQUE` a una tabla con datos existentes puede fallar si hay violaciones. Define las reglas antes de poblar.

## Resumen rápido

| Quieres...                     | Usa                         |
| ------------------------------ | --------------------------- |
| Campo obligatorio              | `NOT NULL`                  |
| Sin duplicados                 | `UNIQUE`                    |
| Identificador único por fila   | `PRIMARY KEY`               |
| Integridad entre tablas        | `FOREIGN KEY` + `PRAGMA foreign_keys = ON` |
| Validar valor al insertar      | `CHECK`                     |
| Valor automático si no se pasa | `DEFAULT`                   |
