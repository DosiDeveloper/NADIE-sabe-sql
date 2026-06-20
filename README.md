# NADIE-sabe-sql

Curso interactivo de SQL basado en los módulos de IBM. Made by NADIE.

Este curso esta orientada a aprender los conceptos basicos del lenguaje SQL y tambien a aprender a como implementar esos conocimientos para normalizar siguiendo las tres formas normales y desnormalizarla basando en el modelado star schema

## Estructura

```
nivel-1-ddl/               → CREATE, ALTER, DROP — construye tu esquema
nivel-2-dml/               → INSERT, UPDATE, DELETE — manipula datos
nivel-3-dql-basico/        → SELECT, WHERE, GROUP BY — consulta datos
nivel-4-dql-avanzado/      → JOINs, subconsultas, vistas — consultas complejas
nivel-5-integracion/       → Ejercicios que combinan DDL + DML + DQL
nivel-6-normalizacion/     → Normalización 1NF → 2NF → 3NF
nivel-7-star-schema/       → Star Schema (desnormalización para OLAP)
```

## Requisitos

Solo necesitas **SQLite** instalado:

```bash
sqlite3 --version
```

## Cómo usar cada nivel

1. Entra a la carpeta del nivel que quieras practicar
2. Lee el `README.md` para ver la teoría y los ejercicios
3. Abre la base de datos SQLite:
   ```bash
   sqlite3 nivelX.db.sqlite3
   ```
4. Para recrear el entorno desde cero:
   ```bash
   sqlite3 nivelX.db.sqlite3 < setup.sql
   ```
