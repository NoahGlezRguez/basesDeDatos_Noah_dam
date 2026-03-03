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
    
    -- como puedo hacer select con este nuevo usuario xd????
    
/*c) Crea un tercer usuario procpedidos que solo se pueda conectar desde el equipo local con la
contraseña que desees y que tenga las siguientes limitaciones: el número máximo de consultas
y actualizaciones que puede hacer por hora son 30 y el número máximo de conexiones
simultáneas de ese usuario son 4. Este usuario debe poder crear y modificar rutinas
almacenadas en la base de datos Pedidos. Comprueba las restricciones asignadas en la tabla
User de la base de datos MySQL.*/
	
/*d) Crea un cuarto usuario llamado modifpedidos con la contraseña que desees, que pueda
consultar la tabla Articulo, insertar nuevas filas en dicha tabla, borrar artículos, modificar los
atributos DesArt y PVPArt de los artículos y crear claves ajenas a la clave primaria de esta
tabla. Una vez asignados estos privilegios, visualiza los permisos de este usuario. Comprueba
que este usuario puede añadir un nuevo artículo y luego modificar el precio de dicho artículo,
pero no modificar su código.*/
	
/*e) Retira los privilegios otorgados al usuario procpedidos y después elimina el usuario.
f) Visualiza los privilegios del usuario consulpedidos. Retira a este usuario la posibilidad de
crear, eliminar tablas y modificar su diseño en la base de datos Pedidos. Visualiza a
continuación sus privilegios.*/
	
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