
use empresa_dam;

/*--------------------------------------------------------------------------------*/

/* ACTIVIDADES ADICIONALES 1 TABLA TEMA 7: */

/* Ejercicio 1.a
Muestra para todos los empleados que cobran comisión, su nombre y la suma del salario más
la comisión (alias Sueldo).
*/

select nomEmp, salario + comision 'Sueldo'
from empleado
where comision > 0;

/* Ejercicio 1.b
Muestra el número, nombre y salario de todos los empleados del departamento no 3 cuyo
salario esté entre 1500 y 2000 €.
*/

select numEmp, nomEmp, salario
from empleado
where numDep = 3 and salario between 1500 and 2000;

/* Ejercicio 1.c
Muestra todos los datos de los departamentos ubicados en localidades cuyo nombre acabe por
la letra ‘a’.
*/

select *
from departamento
where localidad like '%a';

/* Ejercicio 1.d
Muestra el nombre, puesto y salario de los empleados que hayan ingresado en la empresa en
el año 2018. Puedes hacer uso de la función year, que dada una fecha nos devuelve su año.
Los datos deben aparecer ordenados por salario de mayor a menor.
*/

select nomEmp, puesto, salario
from empleado
where year(FecIngreso) = 2018
order by salario desc;

/* Ejercicio 1.e
Muestra el nombre, salario y comisión de todos los empleados cuya comisión suponga más
del 20% de su salario.
*/

select nomEmp, salario, comision
from empleado
where comision > (salario * 0.2);

/* Ejercicio 1.f
Muestra el número, nombre y salario de los empleados que trabajen en el departamento no 1 o
en el 2. Ordena el resultado por nombre en orden alfabético.
*/

select numEmp, nomEmp, salario
from empleado
where numDep in(1, 2)
order by nomEmp;

/* Ejercicio 1.g
Muestra para el o los empleados que no tenga/n jefe o director, su número, nombre, puesto y
salario.
*/

select numEmp, nomEmp, puesto, salario
from empleado
where NumEmpJefe is null;

/* Ejercicio 1.h
Muestra para todos los empleados que cobran comisión, su nombre, salario, comisión y el
porcentaje que supone la comisión en relación con el salario (alias Porcentaje comisión).
Ordena el resultado por este último dato, que debe estar redondeado a dos decimales.
*/

select nomEmp, salario, comision, round((comision / salario) * 100, 2) 'PorcentajeComisión' /*debo quitarle el espacio para que funcione*/
from empleado
where comision > 0
order by PorcentajeComisión;

/* Ejercicio 1.i
Muestra para todos los empleados que no sean ni vendedores ni directores, su nombre, puesto
y salario.
*/

select nomEmp, puesto, salario
from empleado
where puesto not in('vendedor', 'director');
