/* Actividades del Tema 7 sobre la base de datos empresa_dam */

/* Ejercicio 1. Para la base de datos Empresa crea las siguientes consultas: */
use empresa_dam;
/*show tables;*/

/* Ejercicio 1.a
Muestra todos los datos de los empleados del departamento no 1 ordenados por nombre de la
A a la Z.
*/
select *
from empleado
where NumDep = 1
order by NomEmp;

/* Ejercicio 1.b
Muestra el nombre, fecha de ingreso y salario de los empleados del departamento no 3 cuyo
puesto sea vendedor.
*/
select NomEmp, FecIngreso, Salario
from empleado
where NumDep = 3 AND Puesto like 'vendedor';

/* Ejercicio 1.c
Muestra el número y nombre de todos los departamentos.
*/
select NumDep, NomDep
from departamento;

/* Ejercicio 1.d
Muestra el número, nombre y puesto de todos los empleados cuyo nombre comience por la
letra A.
*/
select NumEmp, NomEmp, Puesto
from empleado
where NomEmp like 'A%';

/* Ejercicio 1.e
Muestra todos los datos de los empleados que tengan como primero o segundo apellido Ruiz.
*/
select *
from empleado
where NomEmp like '%Ruiz%';

/* Ejercicio 1.f
Muestra los nombres y puestos de los empleados cuyo puesto sea gerente, director o empleado,
ordenando el resultado por puesto y por nombre.
*/
select NomEmp, Puesto
from empleado
where Puesto in('gerente', 'director', 'empleado')
order by Puesto, NomEmp;

/* Ejercicio 1.g
Muestra el nombre, salario y comisión de todos los empleados que cobran más de 2000 € de
salario o más de 300 € de comisión.
*/
select NomEmp, Salario, Comision
from empleado
where Salario > 2000 or Comision > 300;

/* Ejercicio 1.h
Visualiza todos los datos de los empleados que cobran más de 2000 € de salario y más de 300
€ de comisión.
*/
select *
from empleado
where Salario > 2000 and Comision > 300;

/* Ejercicio 1.i
Muestra para todos los empleados que cobren más de 2000 €, su nombre, salario, puesto y
comisión, así como el nombre y la localidad del departamento en el que trabaja.
*/
select nomEmp, Salario, Puesto, Comision, NomDep, Localidad
from empleado, departamento;

/* Ejercicio 1.j
Indica para todos los empleados que cobran comisión, su nombre, el nombre del departamento
en el que trabajan, la comisión que cobran, su salario y el porcentaje que supone la comisión
con respecto al salario (alias Porcentaje comisión). Redondea este último dato a 2 decimales,
para lo que puedes hacer uso de la función round, que recibe como primer parámetro el número
que se desea redondear y como segundo el número de decimales que se desean en el resultado.
------HACER CON TODOS LOS TIPOS DE JOIN -------
*/

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ NATURAL JOIN ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
select NomEmp, Nomdep, Comision, Salario, round((Comision / Salario) * 100, 2) 'Porcentaje comisión' 
from empleado natural join departamento
where comision > 0;

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ INNER JOIN ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
select NomEmp, Nomdep, Comision, Salario, round((Comision / Salario) * 100, 2) 'Porcentaje comisión' 
from empleado e inner join departamento d on e.numDep = d.numDep
where comision > 0;

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ JOIN USING ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
select NomEmp, Nomdep, Comision, Salario, round((Comision / Salario) * 100, 2) 'Porcentaje comisión' 
from empleado join departamento using (numDep)
where comision > 0;

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ LEFT OUTTER JOIN ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
select NomEmp, Nomdep, Comision, Salario, round((Comision / Salario) * 100, 2) 'Porcentaje comisión' 
from empleado e left join departamento d on e.numDep = d.numDep
where comision > 0;

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ RIGHT OUTTER JOIN ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
select NomEmp, Nomdep, Comision, Salario, round((Comision / Salario) * 100, 2) 'Porcentaje comisión' 
from empleado e right join departamento d on e.numDep = d.numDep
where comision > 0;


/* Ejercicio 1.k
Indica para el empleado que no tiene jefe o director su nombre, puesto, nombre del
departamento y la localidad donde trabaja.
*/
select NomEmp, Puesto, NomDep, localidad
from empleado natural join departamento
where NumEmpJefe is null;

/* Ejercicio 1.l
Añade un nuevo departamento a la tabla Departamento, con número 4, nombre Calidad y
ubicado en Santander. Para ello emplea la siguiente orden:
insert into Departamento VALUES (4, 'Calidad', 'Santander');
Muestra a continuación para los departamentos con número superior o igual a 3, su nombre y
localidad y, en caso de que trabaje en él algún empleado, su nombre, salario y comisión.
Aunque no trabaja ningún empleado en dicho departamento, se deben mostrar sus datos.
*/
insert into Departamento VALUES (4, 'Calidad', 'Santander');

select nomDep, localidad, nomEmp, salario, comision 
from departamento d left outer join empleado e on d.numDep = e.numDep
where d.numDep >= 3;

/*--------------------------------------------------------------------------------*/

/* Ejercicio 2.

*/
/* Ejercicio 2.a

*/
/* Ejercicio 2.b

*/
/* Ejercicio 2.c

*/
/* Ejercicio 2.d

*/
/* Ejercicio 2.e

*/
/* Ejercicio 2.f

*/
/* Ejercicio 2.g

*/

