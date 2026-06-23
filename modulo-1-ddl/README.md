# Nivel 1 — DDL (Data Definition Language)

El DDL permite definir la estructura de la base de datos: tablas, columnas, tipos de datos y restricciones.

## Conceptos

### CREATE TABLE

Este comando nos permite crear entidades para almacenar, modificar o eliminar registros. Estas entidades tienes sus atributos que se definen en la creacion del mismo.

> Haciendo una analogia sería crear la caja en donde guardaremos cosas con sus respectivos divisiones, tipo caja de bombones.

Sintaxis del comando CREATE TABLE

```sql
CREATE TABLE nombre_tabla (
    nombre_atributo tipo restricciones,
    nombre_atributo tipo restricciones,
    nombre_atributo tipo restricciones,
    -- ...
)
```

> [!NOTE]
> En el caso de los tipos de datos se recomienda leer la [guia de referencia de tipos de datos](../tipos-de-datos-sqlite.md#tipos-de-datos-en-sqlite3).
> 
> En el caso de las restricciones de los campos ver esta [guia de referencia](../restricciones-sqlite.md).

Por los momentos nos quedaremos en la creacion de tablas mas adelante se explicara que otros objetos utiles puedemos crear con este comando

Un ejemplo de uso de este comando seria el siguiente:

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

### ALTER TABLE

Este comando nos permite modificar tanto el nombre de una entidad como los atributo. En el caso de los atributos podemos añadir, eliminar o modificar los ya existentes

> Otra analogia sería, esta caja no se va a llamar caja si no "**_box_**", o un ejemplo de este estilo para los atributos seria, esta caja puede almacenar zapatos de la marca "**_Nike_**" pues ahora quiero que almacene zapatos de la marca "**_Reebok_**"

Sintaxis del comando ALTER TABLE

- **Para agregar una nueva columna**.

  Sintaxis del comando

  ```sql
  ALTER TABLE nombre_tabla
  ADD nombre_columna tipo_dato;
  ```

  Un ejemplo de esto seria el siguiente:

  ```sql
  ALTER TABLE estudiantes ADD COLUMN telefono TEXT;
  ```

- **Para renombrar una columna**

  Sintaxis del comando

  ```sql
  ALTER TABLE nombre_tabla
  RENAME COLUMN old_column_name TO new_column_name;
  ```

  Un ejemplo:

  ```sql
  ALTER TABLE profesor
  RENAME COLUMN catedra TO materia;
  ```

- **Para renombrar una tabla**

  Sintaxis del comando

  ```sql
  ALTER TABLE nombre_tabla
  RENAME TO nuevo_nombre_tabla
  ```

  Un ejemplo de uso:

  ```sql
  -- Renombrar tabla
  ALTER TABLE estudiantes RENAME TO alumnos;
  ```

  > [!NOTE]
  > Para eliminar una columna, Sqlite no tiene un comando para hacerlo, pero si existe con comandos que veremos en los siguientes modulos

### DROP TABLE

Este comando nos permite **ELIMINAR** entidades, esto incluye sus registros e indices.

> [!CAUTION]
> Este es un comando que hay que usar con precaución dada su naturaleza

Sintaxis del comando

```sql
DROP TABLE IF EXISTS estudiantes;
```

## Base de datos de ejemplo

La base `modulo1.db.sqlite3` contiene las tablas vacías listas para que practiques DDL.

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
