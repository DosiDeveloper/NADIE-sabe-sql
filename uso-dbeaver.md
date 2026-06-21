# Guia de uso DBeaver

Segun la pagina oficial de DBeaver.

> DBeaver Community es una herramienta gratuita de gestión de bases de datos de código abierto, recomendada para proyectos personales. Gestiona y explora bases de datos SQL como MySQL, MariaDB, PostgreSQL, SQLite, Apache Family y muchas más.

En este caso particular lo usaremos con Sqlite3.

## Instalación

1. Ve a la pagina oficial de DBeaver y diríjase a la sección de [descargas](https://dbeaver.io/download/).
2. Al inicio de pagina se le mostrara una sección que contiene un boton que dice **_Download_**, dele click a ese boton.
   ![alt text](assets/guia%20dbeaver/image-download.png) 
   > En este caso se muestra el instalador para Windows dado que la pagina detecta automaticamente el Sistema Operativo del usuario.
3. Luego de descargar, inicie el instalador. Siga los pasos que le indique y luego inicie el programa.

## Carga de la Base de Datos

Para la carga de las base de datos en DBeaver los ejercicios siga los siguientes pasos:
> Debe tener el programa abierto
1. Diríjase a la esquina superior izquierda, donde esta señalado con en un circulo rojo, y dele click.
   ![carga db](assets/guia%20dbeaver/carga-db-1.png)

2. Luego de presionar el boton anterior, se le aparecera la siguiente ventana, en la cual le dará click en donde dice SQlite.
   ![carga db 2](assets/guia%20dbeaver/carga-db-2.png) > En caso de que no aparezca a apenas abrir el modal, puede buscarlo en la barra de busqueda justo en la parte superior de donde esta señalado en color rojo.

3. Despues le aparecera la siguiente pantalla para configurar la conexión al archivo sqlite3. Haga click al boton "**_Open_**".
   ![carga db 3](assets/guia%20dbeaver/carga-db-3.png)
   Luego busque el archivo que quiera abrir.
   ![carga db 4](assets/guia%20dbeaver/carga-db-4.png)  
    Dele click en "**_Finalizar_**".
   ![carga db 5](assets/guia%20dbeaver/carga-db-5.png)
   Ya aparecera la conexión configurada en la barra de la izquierda de la pantalla
   ![carga db 6](assets/guia%20dbeaver/carga-db-6.png) 
    > Para que aparezca como en la imagen haga click en la conexion que acaba de configurar para desplegar.


## Ejecución de scripts SQL

Con la conexiòn configurada previamente, ahora podremos hacer queries a la base de datos con los siguientes pasos:

1. En la pantalla principal, haga click en boton que dice "**_SQL_**" en la parte superior izquierda
![ejecucion sql](<assets/guia%20dbeaver/ejecucion-sql-1.png>) 
2. Le aparecera la siguente pantalla en la cual podra escribir las queries SQL.
![ejecucion sql 2](assets/guia%20dbeaver/ejecucion-sql-2.png)
Y para ejecutar la query seleccionada pulse las teclas <kbd>Ctrl</kbd> + <kbd>ENTER</kbd>. 
Para ejecutar todas las queries pulse las teclas <kbd>Alt</kbd> + <kbd>X</kbd>
3. Los resultados se observaran en la parte inferior.
![ejecucion sql 3](assets/guia%20dbeaver/ejecucion-sql-3.png)

## Preparacion del entorno de practica

Dado que cada ejercicio requiere una inicializacion, siga los siguientes pasos para recrear el entorno de practicas o en su defecto dejarlo como estaba antes de la practica.

1. Dirijase a la seccion de "**_Archivos_**" y luego a "**_Buscar archivo denominado_**" para buscar el archivo **_setup.sql_** que se encuentra en cada modulo
![recreacion entorno 1](assets/guia%20dbeaver/recreacion-entorno-1.png)
![recreacion entorno 2](assets/guia%20dbeaver/recreacion-entorno-2.png)
![recreacion entorno 3](assets/guia%20dbeaver/recreacion-entorno-3.png)

2. Luego de cargado el archivo, se tiene que establecer que base de datos va a ejecutar el script cargado anteriormente entonces en la seccion que dice "**_N/A_**" le da click y aparecera la ventana que esta a la derecha para luego proceder a seleccionar la base de datos que va a leer el script, despues haga click en seleccionar.
![recreacion entorno 4](assets/guia%20dbeaver/recreacion-entorno-4.png)

3. Ya puede ejecutar el script cargado a la base de datos seleccionada. Se recomienda usar el atajo de teclado <kbd>Ctrl</kbd> + <kbd>x</kbd> para ejecutar el script completo.
