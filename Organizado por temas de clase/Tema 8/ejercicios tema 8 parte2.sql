
/* TEMA 8 - ACTIVIDADES - PARTE 1 - ej1 f,g */
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* EJERCICIO 1.-*/
use empresa_dam;

/*f) Indica para todos los empleados que trabajan en el departamento de ventas su nombre, salario,
comisión, el nombre de su jefe (columna Jefe), el salario de este (columna Salario jefe) y el
resultado de dividir el salario del jefe entre el del empleado (columna Factor multiplicador)
redondeado a dos decimales.*/
select d.nomdep, e.nomemp 'empleado', e.salario 'salario empleado', e.comision, j.nomemp 'jefe', j.salario 'salario jefe', round(j.salario/e.salario,2) 'Factor multiplicador'
from departamento d join empleado e on d.numdep = e.numdep left join empleado j on e.numempjefe = j.numemp 
where d.nomdep = 'Ventas';


/*g) Indica para todos los empleados que tengan dos o más empleados subordinados, su nombre,
salario, número de subordinados que tiene y el nombre del departamento en el que trabaja.
Ordena el resultado por número de subordinados de mayor a menor.*/

select j.nomemp, j.salario, count(e.numemp) 'nº subordinados', d.nomdep
from  empleado j join empleado e on j.numemp = e.numempjefe join departamento d on j.numdep = d.numdep
group by  j.numemp, j.nomemp, j.salario, d.nomdep
having count(e.numempjefe) >= 2
order by count(e.numemp) desc; 

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* EJERCICIO 2.- de la parte 1 ej 2 c*/ 
use empresa2_dam;



/*c) Muestra por cada departamento su nombre, presupuesto, el nombre del departamento del que
depende y el presupuesto de este. Asigna alias a todos los atributos.*/

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*PARTE 2 */  	/*de la parte 2 ej1 a,b,c,d,e | ej2 a,b,c | ej3 a,b  */

/*Ejercicio 1.*/
use empresa_dam;


/*a. Muestra el nombre, puesto, salario y fecha de ingreso de los empleados que desempeñen el
mismo puesto que Esther Gómez Bilbao o que tengan un salario mayor o igual que el de
Albert Rius García.*/



/*b. Muestra los nombres y puestos de los empleados que tienen el mismo puesto que el
empleado apellidado Jiménez, excluido este.*/



/*c. Visualiza los nombres de los departamentos en los que el salario medio es mayor o igual que
la media de todos los salarios.*/



/*d. Selecciona el nombre de los empleados, puesto y localidad donde trabajan los empleados que
trabajan en los departamentos en los que trabajan los vendedores.*/



/*e. Obtén los nombres de los departamentos en los que trabajen más de tres empleados mediante
una consulta de resumen con combinación de tablas y mediante una consulta con
subconsulta.*/

/*Ejercicio 2.*/
use empresa2_dam;

/*a.  Para todos los departamentos con un presupuesto superior a la media, muestra el código del
departamento, su nombre, su presupuesto, su tipo de director y el nombre de su director.*/


/*b. Para todos los empleados que cobren más que el salario medio de todos los empleados,
muestra el nombre del empleado, su salario, su extensión telefónica, el nombre del
departamento en el que trabaja y el nombre del centro en el que está ubicado su
departamento.*/

/*Ejercicio 3.*/
use geografia_dam;

/*a. Obtén el nombre y número de habitantes de las localidades que tienen más población que la
ciudad de Vitoria.*/


/*Indica para las localidades con más población que toda la provincia de Álava, el nombre de
la localidad, el nombre de la provincia a la que pertenece y la población de la localidad,
ordenando el resultado por población de la ciudad más poblada a la menos poblada. (NOTA.
La población de una provincia se calcula sumando la población de todas sus localidades).*/


