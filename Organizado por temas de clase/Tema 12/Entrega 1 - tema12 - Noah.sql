/*Se entregan del 1 al 5*/

use empresa_dam;

/*1. Crea un procedimiento que reciba un número de departamento y muestre su nombre y localidad.
Si no existe ningún departamento con el número pasado como parámetro, se generará un mensaje
de error que informe de tal circunstancia.
*/

	delimiter //
    create procedure verDepartamento(num int)
    begin
		declare noExiste boolean default 0;
        declare continue handler for not found set noExiste = 1;
        select nomdep, localidad
        from departamento
        where numdep = num;
        if noExiste = 1 then
			select concat('El departamento nº ', num, ' no existe.') Error;
		end if;
    end //
    delimiter ;
	
    call verDepartamento(1);
    
/*
2. Crea un procedimiento que reciba un número de departamento, nombre y localidad. Este
procedimiento se ha de encargar de añadir un nuevo departamento a la tabla Departamento con
los datos recibidos como parámetros. En caso de que ya exista un departamento con el número
recibido como parámetro, se deberá mostrar un mensaje de error significativo.
*/

	delimiter //
    create procedure agregarDep(numdepa int, nomdepa varchar(40), locali varchar(40))
    begin
		declare duplicado boolean default 0;
        declare continue handler for 1062 set duplicado = 1;
        insert into departamento values(numdepa, nomdepa, locali);
        if duplicado = 1 then
			select concat('Este departamento ya existe') Error;
		else
			select concat('Departamento agregado adecuadamente.') Mensaje;
		end if;
    end //
    delimiter ;
	
    call agregarDep(11, 'Mantenimiento técnico', 'Canarias'); -- primera llamada (no existía antes)
    call agregarDep(11, 'Mantenimiento técnico', 'Canarias'); -- segunda llamada (duplicado)

/*
3. Crea un procedimiento que reciba el número de un departamento y un nombre de departamento.
El objetivo es asignar al departamento con el número recibido como primer parámetro el nuevo
nombre recibido como segundo parámetro. El procedimiento deberá encargarse de realizar tal
modificación, informando de si se ha podido llevar a cabo. Hay dos motivos por los cuales puede
no ser posible llevarla a cabo: 1) porque no exista ningún departamento con el número recibido
como parámetro, 2) porque no se le puede asignar el nuevo nombre debido a que ya hay otro
departamento con ese mismo nombre (ten en cuenta que el nombre de los departamentos es único).
Si se produce cualquiera de estas dos situaciones, se deberá mostrar un mensaje de error
significativo.
*/

	delimiter //
    create procedure cambiarNomDep(num int, nombre varchar(40))
    begin
		declare resultado int;
		declare noExiste boolean default 0;
        declare duplicado boolean default 0;
		declare continue handler for not found set noExiste = 1;
        declare continue handler for 1062 set duplicado = 1;
        
        select numdep into resultado
        from departamento
        where numdep = num;
        
        update departamento
        set nomdep = nombre
        where numdep = num;
        
        if noExiste = 1 then
			select concat('No existe el departamento nº ', num, '.') Error;
		elseif duplicado = 1 then
			select concat('Ya existe un departamento con el nombre ', nombre, '.') Error;
		else
			select concat('Se ha cambiado el nombre del departamento adecuadamente.') Mensaje;
        end if;
    end //
    delimiter ;
    
    call cambiarNomDep(11, 'Mantenimiento informático'); -- funciona bien
    call cambiarNomDep(500, 'Limpieza'); -- no existe
    call cambiarNomDep(11, 'Compras'); -- duplicado

/*##################################################################################################*/
use geografia_dam; /*para el apartado 4 y 5*/
/*##################################################################################################*/
/*
4. Crea un procedimiento que reciba el número de un departamento y se encargue de eliminarlo. En
tal caso, se mostrará un mensaje que informe de la eliminación. No obstante, puede ocurrir que
no sea posible eliminar el departamento por dos motivos: 1) porque no exista ningún departamento
con el número pasado como parámetro, 2) porque no sea posible eliminarlo si hay algún empleado
trabajando en él. En cualquiera de estos dos casos, se deberá mostrar un mensaje de error
significativo.

Lleva a cabo las siguientes operaciones sobre la base de datos Geografia:

Localidades (id_localidad, nombre, poblacion, n_provincia)

Provincias (n_provincia, nombre, superficie, id_capital, id_comunidad)

Comunidades (id_comunidad, nombre, id_capital)
*/

	

/*
5. Crea un procedimiento que añada nuevas localidades a la base de datos. Este procedimiento
recibirá cuatro parámetros: el identificativo de la localidad, su nombre, su población y el número
de la provincia a la que pertenece. El procedimiento intentará añadir dicha localidad a la base de
datos. Sin embargo se pueden dar dos posibles situaciones de error: 1) que ya haya una localidad
con el número pasado como parámetro, en cuyo caso se mostrará el mensaje “Ya hay una localidad
con el número XXXX”; 2) que el número de la provincia que se pasa al procedimiento sea erróneo,
en cuyo caso se mostrará el mensaje “No hay ninguna provincia con el número XX”. Si se puede
añadir la localidad a la base de datos, se mostrará el mensaje: “Se ha añadido una localidad con el
número XXXX llamada YYYYYYYY”.*/

	
