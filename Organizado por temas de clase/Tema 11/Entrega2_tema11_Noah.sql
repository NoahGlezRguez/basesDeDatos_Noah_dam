/* Se entrega del 6 al 11*/
	use empresa_dam;
/* 6. Crea una función que reciba el número de un departamento y devuelva un número real que indique
el porcentaje que supone la suma de los salarios de los empleados de ese departamento en relación
con la suma salarial de todos los empleados de la empresa.
*/
	delimiter //
	create function porcenSalarial(numDepa int) returns decimal(6,2)
    reads sql data
    begin
		declare salarioDep decimal(6,2);
        declare salarioEmp decimal(6,2);
        declare factor decimal(6,2);
        
        select count(salario) into salarioDep
        from empleado
        where numdep = numdepa;
        
        select count(salario) into salarioEmp
        from empleado;
        
        set factor = (salarioDep / salarioEmp) * 100;
        
        return factor;
    end //
    delimiter ;
    
    -- para ver qué números de departamento hay
    select numdep
    from departamento;
    
    -- prueba de la llamada a la función
    select porcenSalarial(1);

/*
7. Crea un procedimiento que reciba el nombre de un departamento y su localidad. Se debe insertar
ese departamento en la tabla Departamento asignándole como número el que resulte de sumar 1
al número más alto de los departamentos de la empresa. Escribe el final un mensaje con el formato
‘Departamento no xx añadido’, siendo xx el número asignado al nuevo departamento.
*/
    delimiter //
    create procedure insertarDep (nomDepa varchar(40), localiDepa varchar(40))
    modifies sql data
    begin
		declare numDepa int;
        
        select max(numdep) into numdepa
        from departamento;
        
        set numDepa = numDepa + 1;
        
        insert into departamento values (numDepa, nomdepa, localiDepa);
        
    end //
    delimiter ;
    
    -- ver los departamentos antes de llamar al procedimiento
    select *
    from departamento;
    
    -- llamar al procedimiento
    call insertarDep('Asuntos Internos', 'Canarias');
    
    -- ver los departamentos despues de llamar al procedimiento
	select *
    from departamento;
    
/*
8. Escribe una función que reciba el número de un empleado de la tabla Empleado y que devuelva
el número de subordinados que tiene ese empleado, o lo que es lo mismo, el número de empleados
de los cuales es director o jefe directo. Recuerda que el atributo NumEmpJefe de la tabla Empleado
indica el número del empleado director o jefe directo. Escribe un ejemplo de llamada a la función.
*/
	
    delimiter //
    create function consultarSubordinados(numEmple int) returns int
    reads sql data
    begin
		declare totalSub int;
        
        select count(numEmp) into totalSub
        from empleado
        where numEmpJefe = numEmple;
        
        return totalSub;
    end //
    delimiter ;
    
    -- ver los codigos de los jefes existentes
	select numemp
    from empleado
    where numemp in (select NumEmpJefe from empleado);
    
    -- llamada a la funcion
    select consultarSubordinados(1);
/*
9. Crea un procedimiento llamado ModificarSalariosDep que reciba el número de un departamento
y un número real con dos decimales. El procedimiento, en primer lugar, obtendrá el número de
empleados que trabajan en el departamento cuyo número se ha recibido como primer parámetro.
En caso de que no trabaje ningún empleado en dicho departamento, se mostrará el mensaje “En
el dpto. no xxx no trabaja ningún empleado”. En caso contrario, se deberá modificar el salario de
los empleados del departamento cuyo número se ha pasado como primer parámetro en base al
porcentaje recibido como segundo parámetro, después de lo cual se mostrará el mensaje “Se ha
modificado el salario de todos los empleados del dpto. no xx en un yyy,yy%”.
*/
	
    delimiter //
    create procedure ModificarSalariosDep(numdepa int, porcentaje decimal(6,2))
    modifies sql data
    begin
		declare numEmpDep int;
        
        select count(numEmp) into numEmpDep
        from empleado
        where numDep = numdepa;
        
        if (numEmpDep = 0) then
			select concat ('En el departamento ', numdepa, ' no trabaja ningún empleado') Mensaje;
        else 
			update empleado
            set salario = (salario * (porcentaje / 100)) + salario
            where numdep = numdepa;
            
            select concat ('Se ha modificado el salario de todos los empleados del departamento ', numdepa, ' en un ', porcentaje, '%') Mensaje;
		end if;
    end //
    delimiter ;
    
    -- ver salarios dep 1 antes de aplicar funcion
    select salario
    from empleado
    where numdep = 1;
    
    -- llamar al procedimiento
    call ModificarSalariosDep(1, 10.0);
    
/*
10. Crea un procedimiento llamado AsignarComision que reciba un número de empleado y
compruebe su salario en la tabla Empleado. Si el salario del empleado es menor que 1500 €, se le
debe asignar una comisión que será el 5% del salario; en caso de que su salario sea superior o
igual a 1500 €, pero inferior a 2500 €, se le deberá asignar una comisión igual al 2,5% del salario;
en caso de que cobre 2500 € o más, se le pondrá a 0 € la comisión. Muestra un mensaje como el
siguiente: “Al empleado no XXXX se le ha asignado una comisión de YY.YY €”.
*/
	delimiter //
    create procedure AsignarComision(numEmple int)
    modifies sql data
    begin
		declare salarioEmp decimal(6,2);
        
        select salario into salarioEmp
        from empleado
        where numemp = numEmple;
        
        if salarioEmp < 1500 then
			update empleado
            set comision = (salarioemp * 0.05)
            where numemp = numemple;
		else if salarioEmp between 1500 and 2500 then
			update empleado
            set comision = (salarioemp * 0.025)
            where numemp = numemple;
        else
			update empleado
            set comision = 0
            where numemp = numemple;
		end if;
    end //
    delimiter ;
/*
11. Crea una función llamada SalarioJefe que reciba el nombre de un empleado y que devuelva un
número real que tome el valor del salario del empleado dividido entre el número de empleados
subordinados que tenga. En caso de que el empleado no tenga subordinados, la función deberá
devolver el valor -1.
*/
	

	