/*
ACTIVIDADES ADICIONALES TEMA 11
Se entregan todos los apartados, del 1 al 9.
*/

/*
Sobre la base de datos Pedidos lleva a cabo las siguientes operaciones:

Pedido (RefPed, FecPed)
LíneaPedido (RefPed, CodArt, CantArt)
Artículo (CodArt, DesArt, PVPArt)
*/
use pedidos_dam;

/*
1. Crea una función que reciba el código de un artículo y que devuelva un número entero que
indique en cuántos pedidos diferentes ha sido solicitado dicho artículo.
*/

	delimiter //
    create function numPedidos(arti char(5)) returns int
    reads sql data
    begin
		declare numpe int;
        
        select count(refped) into numpe
        from lineapedido
        where codart = arti;
        
        return numpe;
    end //
    delimiter ;
    
    -- pruebo
    select codart from lineapedido;
    
    select numPedidos('A0043') Resultado;
    

/*
2. Escribe un procedimiento que reciba dos parámetros: el código de un artículo y un importe.
Este procedimiento debe modificar el precio del artículo cuyo código se pasa como primer
parámetro, incrementándolo con el importe pasado como segundo parámetro. Muestra tras
la modificación el siguiente mensaje: “El nuevo precio del artículo con código XXXXX es
YYYY.YY euros”.
*/

	delimiter //
    create procedure subirPrecio(arti char(5), subida decimal(6,2))
    begin
		declare precio decimal(6,2);
        
        select pvpart into precio
        from articulo
        where codart = arti;
        
        update articulo
        set pvpart = precio + subida
        where codart = arti;
        
        select concat('El nuevo precio del artículo con código ', arti, ' es ', precio + subida, ' euros') Mensaje;
    end //
    delimiter ;

	-- ver precio antes
	select pvpart
    from articulo
    where codart = 'A0043';
    
    -- probar a subir un centimo
    call subirPrecio('A0043', 0.01);
    

/*
3. Crea un procedimiento que reciba el código de un artículo y una descripción. El
procedimiento se debe encargar de añadir dicho artículo a la tabla Articulo, asignándole
como precio el precio mayor de los artículos de la tabla Articulo. El procedimiento, tras
realizar la inserción, mostrará el mensaje: “Se ha añado un artículo con código XXXX y
precio YYYY.YY euros.”
*/

	delimiter //
    create procedure nuevoArti(arti char(5), des varchar(30))
    begin
		declare precio decimal(6,2);
        
        select max(pvpart) into precio
        from articulo;
        
        insert into articulo values (arti, des, precio);
        
        select concat('Se ha añadido un artículo con código ', arti, ' y precio ', precio, ' euros.') Mensaje;
        
    end //
    delimiter ;

	call nuevoArti('X0061', 'Subrayador');

/*
4. Crea una función que reciba la referencia de un pedido y que devuelva el número total de
unidades de artículos que han sido solicitadas en dicho pedido.
*/

	delimiter //
	create function numarti(refe char(5)) returns int
    reads sql data
    begin
		declare numart int;
        
        select count(codart) into numart
        from lineapedido
        where refped = refe;
        
        return numart;
    end //
	delimiter ;

	select numarti('P0001') Resultado; -- pruebo con un pedido

/*
Para la base de datos Empresa2, lleva a cabo las siguientes operaciones:
Centro (CodCen, CodEmpDir, NomCen, DirCen, PobCen)
Departamento (CodDep, CodEmpDir, CodDepDep, CodCen, NomDep, PreAnu, TiDir)
Empleado (CodEmp, CodDep, ExTelEmp, FecInEmp, FecNaEmp, NIFEmp, NomEmp, NumHi, SalEmp)
Hijo (CodEmp, NumHij, FecNaHi, NomHi)
HabEmp (CodHab, CodEmp, NivHab)
Habilidad (CodHab, DesHab)
*/

	use empresa2_dam;

/*
5. Crea una función llamada ObtenerEdad que reciba el NIF de un empleado y nos devuelva
su edad. Para calcular la edad se podrá hacer uso de la función timestampdiff.
*/

	delimiter //
    create function ObtenerEdad(nif char(9)) returns int
    reads sql data
    begin
		declare edad int;
        declare nacim date;
        select fecnaemp into nacim
        from empleado
        where nifemp = nif;
        
        set edad = timestampdiff(year, nacim, curdate());
		
		return edad;
    end //
    delimiter ;
    
    select obteneredad('21451451V') Edad; -- probando con el primer empleado que aparece

/*
6. Crea un procedimiento llamado SubirSalarioDepar que reciba el nombre de un
departamento y que en función del salario medio de los empleados de ese departamento
haga lo siguiente: si el salario medio es superior a 35.000 €, debe subir el salario a todos sus
empleados un 2%; en caso contrario, les subirá el salario a todos sus empleados un 4%.
Mostrar un mensaje como el siguiente: ‘El salario de los empleados del dpto. XXXX se ha
subido un Y%’.
*/

	delimiter //
    create procedure SubirSalarioDepar(nombre varchar(40))
    begin
		declare codigo char(5);
        declare salme decimal(7,2);
        declare subida decimal(7,2);
        
        select coddep into codigo
        from DEPARTAMENTO
        where nomdep = nombre;
        
        select avg(salemp) into salme
        from EMPLEADO
        where coddep = codigo;
		
        if salme > 35000 then
			set subida = 0.02;
		else
			set subida = 0.04;
		end if;
        
        update EMPLEADO
        set salemp = salemp + (salemp * subida)
        where coddep = codigo;
        
        set subida = subida * 100;
        
        select concat('El salario del departamento ', nombre, ' ha subido un ', subida, '%.') as Mensaje;
    end//
    delimiter ;
    
    call SubirSalarioDepar('Ventas');
    
    drop procedure SubirSalarioDepar;

/*
7. Crea una función llamada NumDptosDependientes que reciba el código de un departamento
y que nos indique cuántos departamentos dependen directamente de él. Ten en cuenta que
el atributo CodDepDep de la tabla Departamento indica por cada departamento cuál es el
departamento del que depende, o lo que es lo mismo, su departamento jefe.
*/

	delimiter //
    create function NumDptosDependientes(cod char(5)) returns char(5)
    reads sql data
    begin
		declare depedepe char(5);
        
        select count(*) into depedepe
        from departamento
        where coddepdep = cod;
        
        return depedepe;
    end//
    delimiter ;
    
    select NumDptosDependientes('JEFZS') Resultado;
    
    drop function NumDptosDependientes;

/*
Sobre la base de datos geografia realiza las siguientes operaciones:
Localidades (id_localidad, nombre, poblacion, n_provincia)

Provincias (n_provincia, nombre, superficie, id_capital, id_comunidad)

Comunidades (id_comunidad, nombre, id_capital)
*/

	use geografia_dam;

/*
8. Crea un procedimiento que reciba el nombre de una comunidad autónoma y que muestre el
número de provincias y el número de localidades de que consta dicha comunidad autónoma.
Si no consta ninguna provincia para dicha comunidad autónoma en la base de datos, se
deberá mostrar el mensaje: “La comunidad autónoma llamada XXXX no está en la base de
datos”.
*/

	delimiter //
    create procedure mostrarInfoCA(codca int)
    begin
		declare numpro int;
        declare numloca int;
        declare nomca varchar(30);
        
        select nombre into nomca
        from Comunidades
        where id_comunidad = codca;
        
        select count(distinct p.n_provincia), count(l.id_localidad) into numpro, numloca
        from Comunidades c left join Provincias p on c.id_comunidad = p.id_comunidad
							left join localidades l on p.n_provincia = l.n_provincia
		where c.id_comunidad = codca;
        
        if numpro = 0 then
			select concat('La comunidad autónoma ', codca, ' no está en la base de datos.') Error;
        else
			select concat('La comunidad ', nomca, ' tiene ', numpro, ' provincias y ', numloca, ' localidades.') Resultado;
		end if;
    end//
    delimiter ;
	
    call mostrarInfoCA(7);
    
    drop procedure mostrarInfoCA;
    
/*
9. Crea una función que reciba el nombre de una comunidad autónoma y devuelva el nombre
de la provincia con mayor superficie de la misma.
*/

	delimiter //
    
    delimiter ;
    
