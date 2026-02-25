/*entrega 1 del tema 9*/
use empresa_dam;

/*a) Crea una tabla llamada Departamento2 con el contenido de la tabla Departamento, y otra
llamada Empleado2 con el contenido de la tabla Empleado.*/
	
    /*  esto de aquí no sirve porque solo copia el "esquema" de la table pero no su contenido:  */
    /*create table Departamento2 like Departamento;
	create table Empleado2 like Empleado;*/
    
    create table Departamento2 (
		select * from Departamento
    );
    
    create table Empleado2(
		select * from Empleado
    );

/*b) Añade un nuevo departamento a la tabla Departamento2 con número 50, nombre Producción
y ubicado en Burgos.*/
	insert into Departamento2 values (50, 'Producción', 'Burgos');

/*c) Añade un empleado nuevo a la tabla Empleado2 con número 20, nombre Luis Gómez
Valverde, puesto empleado, dado de alta el día de hoy, con salario 1800 €, comisión 0 € y
número de departamento el 2. Se obtiene la fecha del día de hoy por medio de la función
CURRENT_DATE.*/
	insert into Empleado2 values (20, 'Luis Gómez Valverde', 'empleado', null, CURRENT_DATE, 1800, 0, 2);

/*d) Divide entre 2 la comisión a todos los empleados de la tabla Empleado2 que la cobran.*/


/*e) Asigna el departamento número 1 a todos los directores de la tabla Empleado2.*/


/*f) Elimina de la tabla Empleado2 a los empleados con fecha de ingreso en el año 2016.*/


/*g) Elimina de la tabla Departamento2 los departamentos que no tengan empleados.*/


/*h) Multiplica por 2 la comisión a todos los empleados del departamento de Ventas con una
comisión inferior a 300 €.*/


/*i) El departamento de compras se va a trasladar a Málaga. Refleja esta modificación en la base
de datos.*/


/*j) Añade un nuevo empleado a la tabla Empleado2 con número 21, nombre Pedro Baute Rojo,
fecha de ingreso, la del día de hoy, salario el mismo que el de Luis Gómez Valverde más el
15%, siendo el resto de los datos los mismos que los de Luis Gómez Valverde.*/


/*k) Aumenta un 2,5% el salario y disminuye un 1% la comisión a todos los empleados de la tabla
Empleado2 que trabajen el departamento de Ventas.*/

