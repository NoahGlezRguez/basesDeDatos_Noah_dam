/* Se entregan los ejercicios 1 y 2 */

/*
1. Lleva a cabo las siguientes operaciones relacionadas con la gestión de usuarios sobre la base de
datos sobre la base de datos Pedidos:
	
Pedido (RefPed, FecPed)
LíneaPedido (RefPed, CodArt, CantArt)
Artículo (CodArt, DesArt, PVPArt)
*/
	
    use pedidos_dam;
    
/*
a) Crea un usuario llamado adminpedidos con la contraseña que desees y que tenga todos los
privilegios sobre todas las tablas de la base de datos Pedidos. Permite que este usuario pueda
pasar sus privilegios a otros usuarios.*/
	
    create user if not exists 'adminpedidos'@'%'
    identified by '123456789';
    
    grant all
    on pedidos_dam.* 
    to 'adminpedidos' 
    with grant option;
    
    
    
/*b) Crea un segundo usuario llamado consulpedidos con la contraseña que desees, que pueda
consultar el contenido de cualquiera de las tablas de la base de datos Pedidos y que además
pueda crear tablas, eliminar tablas, modificar el diseño de las tablas creadas, crear vistas y
crear y borrar índices, todo ello en la base de datos Pedidos. Comprueba que efectivamente
puede en dicha base de datos consultar tablas, pero que no puede añadir filas a las mismas.*/
	
    create user if not exists 'consulpedidos'@'%'
    identified by '123456789';
    
    grant select, create, drop, alter, create view, index
    on pedidos_dam.*
    to 'consulpedidos'@'%';
    
    -- prueba de select realizada:
    /*
    C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql.exe -u consulpedidos -p
	Enter password: *********
		Welcome to the MySQL monitor.  Commands end with ; or \g.
		Your MySQL connection id is 23
		Server version: 8.0.45 MySQL Community Server - GPL

		Copyright (c) 2000, 2026, Oracle and/or its affiliates.

		Oracle is a registered trademark of Oracle Corporation and/or its
		affiliates. Other names may be trademarks of their respective
		owners.

		Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

		mysql> use pedidos_dam;
		Database changed
		mysql> select * from pedido;
		+--------+------------+
		| RefPed | FecPed     |
		+--------+------------+
		| P0001  | 2025-02-16 |
		| P0002  | 2025-02-18 |
		| P0003  | 2025-02-23 |
		| P0004  | 2025-02-25 |
		+--------+------------+
		4 rows in set (0.00 sec)

    */
    
/*c) Crea un tercer usuario procpedidos que solo se pueda conectar desde el equipo local con la
contraseña que desees y que tenga las siguientes limitaciones: el número máximo de consultas
y actualizaciones que puede hacer por hora son 30 y el número máximo de conexiones
simultáneas de ese usuario son 4. Este usuario debe poder crear y modificar rutinas
almacenadas en la base de datos Pedidos. Comprueba las restricciones asignadas en la tabla
User de la base de datos MySQL.*/
	
    create user if not exists 'procpedidos'@'localhost'
    identified by '123456789'
    with max_queries_per_hour 30 max_updates_per_hour 30 max_user_connections 4;
    
    grant create routine, alter routine
    on pedidos_dam.*
    to 'procpedidos'@'localhost';
    
    -- revision de privilegios realizada:
    /*
    
		C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql.exe -u root -p
		Enter password: *************
		Welcome to the MySQL monitor.  Commands end with ; or \g.
		Your MySQL connection id is 24
		Server version: 8.0.45 MySQL Community Server - GPL

		Copyright (c) 2000, 2026, Oracle and/or its affiliates.

		Oracle is a registered trademark of Oracle Corporation and/or its
		affiliates. Other names may be trademarks of their respective
		owners.

		Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

		mysql> use mysql;
		Database changed
		mysql> select host, user
			-> from user;
		+-----------+------------------+
		| host      | user             |
		+-----------+------------------+
		| %         | consulpedidos    |
		| 127.0.0.1 | DAM_v            |
		| localhost | DAM_v            |
		| localhost | mysql.infoschema |
		| localhost | mysql.session    |
		| localhost | mysql.sys        |
		| localhost | procpedidos      |
		| localhost | root             |
		+-----------+------------------+
		8 rows in set (0.00 sec)

		mysql> select host, user, create_routine_priv, alter_routine_priv from user where user = 'procpedidos';
		+-----------+-------------+---------------------+--------------------+
		| host      | user        | create_routine_priv | alter_routine_priv |
		+-----------+-------------+---------------------+--------------------+
		| localhost | procpedidos | N                   | N                  |
		+-----------+-------------+---------------------+--------------------+
		1 row in set (0.00 sec)

		->>>(( Aquí aparece 'N' porque los permisos para este usuario no eran globale sy aquí solo se muestran los
			privilegios a nivel global.as user )). En el FROM especificaremos el nivel para verlo realmente.
        
        mysql> select host, user, create_routine_priv, alter_routine_priv from mysql.db where user = 'procpedidos';
		+-----------+-------------+---------------------+--------------------+
		| host      | user        | create_routine_priv | alter_routine_priv |
		+-----------+-------------+---------------------+--------------------+
		| localhost | procpedidos | Y                   | Y                  |
		+-----------+-------------+---------------------+--------------------+
		1 row in set (0.00 sec)

    */
    
/* d) Crea un cuarto usuario llamado modifpedidos con la contraseña que desees, que pueda
consultar la tabla Articulo, insertar nuevas filas en dicha tabla, borrar artículos, modificar los
atributos DesArt y PVPArt de los artículos y crear claves ajenas a la clave primaria de esta
tabla. Una vez asignados estos privilegios, visualiza los permisos de este usuario. Comprueba
que este usuario puede añadir un nuevo artículo y luego modificar el precio de dicho artículo,
pero no modificar su código. */
	
    create user if not exists 'modifpedidos'@'%'
    identified by '123456789';
    
    grant select, insert, delete, references, update (DesArt, PVPArt)
    on pedidos_dam.articulo
    to 'modifpedidos'@'%';
    
    -- revision de privilegios realizada:
    
    /*
    La sesión continua iniciada en root. Aquí pruebo otra forma, esta vez más directa, de ver los permisos de un usuario:
    
    mysql> show grants for 'modifpedidos';
	+-------------------------------------------------------------------------------------------------------------------------+
	| Grants for modifpedidos@%                                                                                               |
	+-------------------------------------------------------------------------------------------------------------------------+
	| GRANT USAGE ON *.* TO `modifpedidos`@`%`                                                                                |
	| GRANT SELECT, INSERT, UPDATE (`DesArt`, `PVPArt`), DELETE, REFERENCES ON `pedidos_dam`.`articulo` TO `modifpedidos`@`%` |
	+-------------------------------------------------------------------------------------------------------------------------+
	2 rows in set (0.00 sec)

	----> Para poner a prueba dichos privilegios me conecto con ese usuario y pruebo a realizar dichas operaciones:
    
    mysql> exit
	Bye

	C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql.exe -u modifpedidos -p
	Enter password: *********
	Welcome to the MySQL monitor.  Commands end with ; or \g.
	Your MySQL connection id is 25
	Server version: 8.0.45 MySQL Community Server - GPL

	Copyright (c) 2000, 2026, Oracle and/or its affiliates.

	Oracle is a registered trademark of Oracle Corporation and/or its
	affiliates. Other names may be trademarks of their respective
	owners.

	Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
	
    mysql> use pedidos_dam;
	Database changed
	mysql> select * from articulo;
	+--------+-----------------------+--------+
	| CodArt | DesArt                | PVPArt |
	+--------+-----------------------+--------+
	| A0012  | Goma de borrar        |   0.15 |
	| A0043  | Bolígrafo azul        |   0.78 |
	| A0075  | Lápiz 2B              |   0.55 |
	| A0078  | Bolígrafo rojo normal |   1.05 |
	| A0089  | Sacapuntas            |   0.25 |
	+--------+-----------------------+--------+
	5 rows in set (0.00 sec)
	
    mysql> insert into articulo values ('A9999', 'Articulo de prueba', 3.5);
	Query OK, 1 row affected (0.56 sec)

	mysql> select * from articulo;
	+--------+-----------------------+--------+
	| CodArt | DesArt                | PVPArt |
	+--------+-----------------------+--------+
	| A0012  | Goma de borrar        |   0.15 |
	| A0043  | Bolígrafo azul        |   0.78 |
	| A0075  | Lápiz 2B              |   0.55 |
	| A0078  | Bolígrafo rojo normal |   1.05 |
	| A0089  | Sacapuntas            |   0.25 |
	| A9999  | Articulo de prueba    |   3.50 |
	+--------+-----------------------+--------+
	6 rows in set (0.00 sec)
	
    mysql> update articulo
    -> set pvpart = 1.99
    -> where codart = 'A9999';
	Query OK, 1 row affected (0.00 sec)
	Rows matched: 1  Changed: 1  Warnings: 0

	mysql> select * from articulo;
	+--------+-----------------------+--------+
	| CodArt | DesArt                | PVPArt |
	+--------+-----------------------+--------+
	| A0012  | Goma de borrar        |   0.15 |
	| A0043  | Bolígrafo azul        |   0.78 |
	| A0075  | Lápiz 2B              |   0.55 |
	| A0078  | Bolígrafo rojo normal |   1.05 |
	| A0089  | Sacapuntas            |   0.25 |
	| A9999  | Articulo de prueba    |   1.99 |
	+--------+-----------------------+--------+
	6 rows in set (0.00 sec)
    
    --->>> Codigo igual, precio cambia.
    
    mysql> update articulo
    -> set codart = 'A7894'
    -> where codart = 'A9999';
	ERROR 1143 (42000): UPDATE command denied to user 'modifpedidos'@'localhost' for column 'codart' in table 'articulo'
	mysql>
    
    */
    
/*e) Retira los privilegios otorgados al usuario procpedidos y después elimina el usuario.*/
	
    show grants for 'procpedidos'@'localhost';
    
    revoke create routine, alter routine
    on pedidos_dam.*
    from 'procpedidos'@'localhost';
    
	show grants for 'procpedidos'@'localhost';
    
    drop user 'procpedidos'@'localhost';

/*f) Visualiza los privilegios del usuario consulpedidos. Retira a este usuario la posibilidad de
crear, eliminar tablas y modificar su diseño en la base de datos Pedidos. Visualiza a
continuación sus privilegios.*/
	
    show grants for 'consulpedidos'@'%';
    
    revoke create, drop, alter
    on pedidos_dam.*
    from 'consulpedidos'@'%';
    
    show grants for 'consulpedidos'@'%';
    
/*
2. Lleva a cabo las siguientes operaciones relacionadas con la gestión de usuarios sobre la base de
datos Empresa:
	
Departamento (NumDep, NomDep, Localidad)
Empleado (NumEmp, NomEmp, Puesto, NumEmpJefe, FecIngreso, Salario, Comision, NumDep)
*/
	
/*
a) Crea un rol llamado RolRRHH que tenga otorgados los privilegios necesarios para consultar
las tablas Empleado y Departamento, crear, alterar y eliminar tablas en la base de datos
Empresa y además añadir nuevos empleados a la tabla Empleado y modificar los atributos
Puesto, NumEmpJefe, Salario, Comision y NumDep de dicha tabla.*/
	
/*b) Crea tres usuarios llamados rrhh1, rrhh2 y rrhh3 con la contraseña que desees, la cual deberá
expirar en 30 días. Estos usuarios tendrán como rol por defecto el rol RolRRHH.*/
	
/*c) Entra al sistema con el usuario rrhh2 y comprueba que puede consultar la tabla Departamento
y cambiar el salario de un empleado en la tabla Empleado, pero que no puede crear nuevos
departamentos. Visualiza los privilegios que tiene otorgados el usuario rrhh2.*/