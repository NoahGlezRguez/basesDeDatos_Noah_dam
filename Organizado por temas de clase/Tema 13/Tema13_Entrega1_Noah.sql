/* Tema 13 | Entrega 1 | Se entrega del 1 al 4 */

/*
Lleva a cabo las siguientes operaciones sobre las bases de datos Empresa y Pedidos, cuyos esquemas
relacionales son los siguientes:

	Departamento (NumDep, NomDep, Localidad)
	Empleado (NumEmp, NomEmp, Puesto, NumEmpJefe, FecIngreso, Salario, Comision, NumDep)

Pedido (RefPed, FecPed)
LíneaPedido (RefPed, CodArt, CantArt)
Artículo (CodArt, DesArt, PVPArt)
*/

/*
1. Crea una tabla dentro de la base de datos Pedidos llamada ArticulosAntiguos. Esta tabla tendrá
los mismos atributos que la tabla Articulo y servirá para contener los datos de los artículos
eliminados de la tabla Articulo. Crea un disparador llamado BorradoArticulos que se ejecute cada
vez que se realice un borrado sobre la tabla Articulo, de manera que el artículo que se borre se
añada a la tabla ArticulosAntiguos.
*/
	
    use pedidos_dam;
	
	create table articulosAntiguos like Articulo; 
    
    create trigger BorradoArticulos before delete
    on articulo for each row
    insert into articulosAntiguos values (old.codart, old.desart, old.pvpart);
    
    -- inserto un nuevo articulo cualquiera para probar:
    insert into articulo values('A9999', 'EjemploDeArticulo', 10.8);
    
    -- lo borro para que salte el trigger:
    delete from articulo
    where codart = 'A9999';
	
    -- compruebo si funcionó:
    select * from articulosAntiguos;
    
/*
2. Crea una tabla llamada AuditoriaPrecios con un solo atributo llamado Linea de tipo varchar(100).
Crea después un disparador llamado AuditarPrecios que dé fe de las modificaciones de precios
sobre los artículos de la base de datos. Cada vez que se incremente o decremente el precio de un
artículo más de un 10% se debe añadir una fila a la tabla AuditoriaPrecios con el texto: “El
articulo xxxx ha cambiado su precio de yy.yy a zz.zz el AAAA-MM-DD”, donde xxxx es la
descripción del artículo; yy.yy, el precio antes de la modificación; zz.zz, el precio después de la
modificación y AAAA-MM-DD, la fecha en la que se ha llevado a cabo la modificación. Para
obtener la fecha actual puedes hacer uso de la función current_date.
*/
	create table AuditoriaPrecios (
    Linea varchar(100)
    );
	
    delimiter //
    create trigger AuditarPrecios
    after update on Articulo for each row
    begin
         if ((new.pvpart > (old.pvpart * 1.10)) OR (new.pvpart < (old.pvpart * 0.9))) then 
			insert into AuditoriaPrecios values(concat('El artículo ', old.codart, ' ha cambiado su precio de ',
												old.pvpart, ' a ', new.pvpart, ' el ', current_date));
        end if;

	end//
    delimiter ;
	
    drop trigger auditarprecios;
    
   update Articulo
   set PVPArt = 1.50
   where CodArt = 'A0078';
    
/*
3. Crea una tabla llamada EmpleadosAntiguos copia de la tabla Empleado y sin datos, pero con dos
atributos adicionales: fecha_baja, de tipo fecha, y finiquito de tipo numeric(7,2). Crea un
disparador llamado BajaEmpleado sobre la tabla Empleado, de manera que cuando se borre a un
empleado de la tabla Empleado, se añada dicho empleado a la nueva tabla EmpleadosAntiguos.
Los datos del empleado en la tabla EmpleadosAntiguos serán los mismos que aparecen en la tabla
Empleado y además al atributo fecha_baja se le asignará la fecha del día en el que se elimina al
empleado y al atributo finiquito se le asignará un valor que se calculará en función de su oficio:
	
     Si el empleado tiene el puesto Gerente o Director, el finiquito se calculará multiplicando el
		salario del empleado y por el número de meses enteros de antigüedad divididos entre 12
		(número de meses de un año).

	 Si el empleado tiene cualquier otro puesto, el finiquito se calculará multiplicando 20 por el
		salario diario del empleado y por el número de meses enteros de antigüedad divididos entre
		12. El salario diario del empleado se calculará dividiendo entre 30 su salario mensual.

NOTA: La antigüedad se debe calcular como el número de meses transcurridos entre la fecha del
		día de hoy y la fecha de ingreso del empleado en la empresa (atributo FecIngreso). Para llevar a
		cabo este cálculo MySQL nos proporciona la función timestampdiff (unidad_tiempo, fecha1,
		fecha2) que recibe como parámetro una unidad de tiempo y dos fechas tal que fecha2 es superior
		o igual a fecha1. Esta función nos devuelve la diferencia entre esas dos fechas en un número entero
		en la unidad de tiempo indicada como primer parámetro.

*/
	
    
    
/*
4. Se desea almacenar dentro de la base de datos Empresa información sobre las modificaciones
salariales de los empleados. Para ello se debe crear la tabla CambiosSalariales con la siguiente
orden SQL:

	create table CambiosSalariales
	(NumEmp int unsigned,
	NomEmp varchar(40) NOT NULL,
	salAnt numeric(6,2) NOT NULL,
	salNue numeric(6,2) NOT NULL,
	porcen numeric(5,2) NOT NULL,
	fecha date,
	PRIMARY KEY (NumEmp, fecha));

Crea un disparador llamado RegistrarCambiosSalariales que cada vez que se efectúe una
modificación en el salario de un empleado, añada un registro a la tabla CambiosSalariales,
almacenando el número del empleado al que se le ha cambiado el salario (valor nuevo de este
campo), su nombre (valor nuevo), el salario antes del cambio, el salario después del cambio, el
porcentaje de modificación del salario redondeados a dos decimales y la fecha en la que se efectúa
el cambio. NOTA: El porcentaje de modificación del salario se calcula mediante la siguiente
fórmula:

Porcentaje = ((nuevoSalario - antiguoSalario) / antiguoSalario) x 100

Escribe una orden de modificación del salario de uno o varios empleados y compruebe que se
almacenado correctamente información en la tabla CambiosSalariales.
*/

