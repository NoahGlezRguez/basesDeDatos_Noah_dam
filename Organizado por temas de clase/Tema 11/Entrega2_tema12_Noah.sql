/*
Se entregan del 6 al 8*
/*

/*
Lleva a cabo las siguientes operaciones sobre las bases de datos Empresa:
*/
	use empresa_dam;

/*
6. Codifica un procedimiento que reciba como parámetros dos números: un salario mínimo y un
salario máximo. Se debe mostrar por cada empleado de la tabla Empleado que cobre un salario
entre los dos pasados como parámetro (ambos incluidos), su nombre, salario, comisión, porcentaje
que supone la comisión con respecto al salario (redondeado a dos decimales) y el nombre del
departamento en el que trabaja.
*/

	delimiter //
	create procedure emplenrango(salmin decimal(6,2), salma decimal(6,2))
	begin
		declare nom varchar(40);
        declare sal decimal(6,2);
		declare com decimal(6,2);
        declare por decimal(6,2);
        declare fin boolean default 0;
		declare c cursor for select nomemp, salario, comision, round(((comision / salario) * 100),2) Porcentaje
							from empleado where salario between salmin and salma;
        declare continue handler for not found set fin = 1;
        open c;
        fetch c into nom, sal, com, por;
        while fin = 0 do
			select concat('Empleado: ', nom, '. Salario: ', sal, '€. Comisión: ', com, '€. Factor com-sal: ', por, '%') Empleado;
			fetch c into nom, sal, com, por;
        end while;
        close c;
	end//
    delimiter ;

	call emplenrango(3000, 9000);

/*
7. Crea un procedimiento que muestre para los dos departamentos con más empleados, su nombre,
número de empleados y salario medio de estos (redondeado a dos decimales).
*/

	delimiter //
	create procedure depfaminfo()
	begin
		
	end//
    delimiter ;

/*
8. Crea un procedimiento que muestre los siguientes datos de empleados: nombre, puesto, salario y
comisión. Solamente se deberán mostrar los datos de los empleados con menor salario. Además,
se deberán mostrar solo los datos de tantos empleados como indique el número recibido como
parámetro.
*/

	delimiter //
	create procedure emplepobres(num int)
	begin
		
	end//
    delimiter ;
