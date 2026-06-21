# NADIE-sabe-sql

<div align="center">
   <img src="https://img.shields.io/badge/Sqlite-003B57?style=for-the-badge&logo=sqlite&logoColor=white">
   <img src="https://img.shields.io/badge/DBeaver-003B57?style=for-the-badge&logo=dbeaver&logoColor=white">
</div>
Curso interactivo de SQL basado en los módulos de IBM. Made by NADIE.

Este curso esta orientado a los estudiantes de segundo semestre que cursan Computacion II a aprender los conceptos basicos del lenguaje SQL y tambien a aprender a como implementar esos conocimientos para normalizar siguiendo las tres formas normales y desnormalizarla basando en el modelado star schema.

## Estructura

```
modulo-1-ddl/               → CREATE, ALTER, DROP — construye tu esquema
modulo-2-dql-basico/        → SELECT, WHERE, GROUP BY — consulta datos
modulo-3-dql-avanzado/      → JOINs, CTEs, vistas — consultas complejas
modulo-4-dml/               → INSERT, UPDATE, DELETE — manipula datos        
modulo-5-integracion/       → Ejercicios que combinan DDL + DML + DQL
```
**Modulos especiales**
```
modulo-especial-1-estadisticas/  → Ejercicios que combinan DDL + DML + DQL
modulo-especial-2-normalizacion/ → Normalización 1NF → 2NF → 3NF
modulo-especial-3-star-schema/   → Star Schema (desnormalización para OLAP)
```

## Requisitos

Solo necesitas instalado:
- Base de datos [**SQLite**](uso-sqlite3.md#descarga-y-configuración-de-sqlite3) 
```bash
sqlite3 --version
```
- **GUI para las bases de datos** [DBeaver](uso-dbeaver.md#instalación)


## Cómo usar cada nivel

1. Entra a la carpeta del nivel que quieras practicar
2. Lee el `README.md` para ver la teoría y los ejercicios

3. Abre la base de datos SQLite en [DBeaver](uso-dbeaver.md#carga-de-la-base-de-datos)
4. Para recrear el entorno desde cero usando [DBeaver](uso-dbeaver.md#ejecución-de-scripts-sql)
