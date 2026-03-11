/* Se entregan el 1, 2 y 3. */

/*
ACTIVIDADES ADICIONALES TEMA 10

Se va a trabajar con una base de datos llamada Centros que contiene información sobre los centros de trabajo de que consta una empresa y los departamentos ubicados en cada centro. Hay establecida
una jerarquía entre los departamentos, de manera que por cada departamento se almacena el departamento del que depende (CodDepJefe).
Tabla CENTRO

Atributo Tipo de dato Significado
CodCen int Código del centro de trabajo
NomCen varchar(40) Nombre del centro de trabajo
DirCen Varchar(40) Dirección del centro de trabajo
Tabla DEPARTAMENTO

Atributo Tipo de dato Significado
CodDep char(5) Código del departamento
NomDep varchar(40) Nombre del departamento
PreAnu float Presupuesto anual del departamento
CodCen int Código del centro al que pertenece el departamento
CodDepJefe char(5) Código del departamento jefe

Departamento (CodDep, NomDep, PreAnu, CodCen, CodDepJefe)
Centro (CodCen, NomCen, DirCen)

Se muestran los datos contenidos en las tablas:

CENTRO
+--------+---------+----------------------------+
| CodCen | NomCen 	| DirCen |
+--------+---------+----------------------------+
| 1 	| General 	| Gran Vía, 80, Bilbao 
| 2 	| Centro 	| La Castellana, 175, Madrid 
| 3 	| Sur 		| La Cartuja, s/n, Sevilla 
+--------+---------+----------------------------+
DEPARTAMENTO
+--------+--------------------------+--------+--------+------------+
| CodDep | NomDep 			|     PreAnu |CodCen| CodDepJefe 
+--------+--------------------------+--------+--------+------------+
| CALID | Calidad 				| 180000 |  2 	|  DIRGE 
| DIRGE | Dirección general		| 500000 |  1 	|  NULL  
| IN+DI | Investigación y diseño| 350000 |  3 	|  CALID 
| INNOV | Innovación 			| 400000 |  3 	|  CALID 
| NOMIN | Nóminas 				| 400000 |  2 	|  RECHH 
| PRODU | Producción 			| 240000 |  1 	|  DIRGE 
| RECHH | Recursos humanos 		| 350000 |  1 	|  DIRGE 
| VENTA | Ventas 				| 380000 |  2 	|  DIRGE 
+--------+--------------------------+--------+--------+------------+
*/

/*
	1. Crea un rol llamado rolexa1 y haz que los usuarios con este rol puedan crear y eliminar
	procedimientos y funciones en la BD Centros, así como crear vistas en dicha base de datos. Además,
	los usuarios con este rol deben poder crear usuarios y realizar consultas sobre cualquier tabla del
	servidor. También deben poder realizar inserciones y borrados sobre la tabla Departamento y
	modificar el presupuesto y el nombre de cualquier departamento.
	Escribe todos los comandos necesarios para conseguir todo lo solicitado.
*/
	
    create role if not exists 'rolexa1';
    
    grant create routine, alter routine, execute, create view
    on Centros.*
    to rolexa1;
    
    grant create user, select
    on *.*
    to rolexa1;
    
    grant insert, delete, update (NomDep, PreAnu)
    on Centros.Departamento
    to rolexa1;

/*
	2. Crea un usuario llamado usuexa1 con contraseña ‘asgbd’ con el rol rolexa1. Limita el número de
	conexiones por hora que puede realizar a 10 y establece que su contraseña expire en 100 días.
    
    Escribe	la consulta que hay que ejecutar para visualizar el usuario, equipo desde el que se puede conectar y
	la limitación que le hemos impuesto en una tabla del diccionario de datos.
    Se muestra cuál debe ser el resultado de la consulta.
    
    Escribe el comando para visualizar los privilegios concretos (con el rol no	es suficiente) que tiene asignados
    el usuario usuexa1
    
	+------+---------+-----------------+
	| host |   user	 | max_connections |
	+------+---------+-----------------+
	| %    | usuexa1 |   10 		   |
	+------+---------+-----------------+
*/

	create user 'usuexa1'@'%' identified by 'asgbd'
    default role 'rolexa1'
    with max_connections_per_hour 10
    password expire interval 100 day;    
    
    select host, user, max_connections
    from mysql.user
    where user = 'usuexa1';
    
    show grants for 'usuexa1'@'%'; 
    
    show grants for 'usuexa1'@'%' using 'rolexa1';

/*
3. Crea un usuario llamado usuexa2 con contraseña ‘asgbd’. Limita el número de consultas que puede
realizar por hora a 50 y el número de conexiones simultáneas a 4. Establece que su contraseña expire
en 90 días. Escribe el comando necesario para conseguir todo lo indicado. ¿En qué tabla de qué base
de datos del diccionario de datos se almacena información al crear este usuario?
*/

	create user 'usuexa2'@'%' identified by 'asgbd'
    with max_queries_per_hour 50 max_user_connections 4
    password expire interval 90 day;


	select user from mysql.user where user = 'usuexa2';