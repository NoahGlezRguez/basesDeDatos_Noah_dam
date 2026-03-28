/* Se entregan los ejercicios 3 y 4 */
use empresa_dam;
/*
3. A partir de las tablas Empleado y Departamento de la base de datos Empresa lleva a cabo las
siguientes operaciones relacionadas con vistas:*/

/*
a) Crea una vista llamada VistaEmpleDep que sea el resultado de una combinación entre las
tablas Empleado y Departamento y que contenga por cada empleado su nombre, su salario, su
antigüedad (calculada como la diferencia de años entre la fecha de hoy y la fecha de ingreso
en la empresa) y el nombre del departamento en el que trabaja. Los nombres de los atributos
de la vista deben ser NomEmp, Salario, Antigüedad y NomDep. Ten en cuenta que
current_date nos devuelve la fecha actual y que la función timestampdiff (unidad_tiempo,
fecha1, fecha2) recibe como parámetro una unidad de tiempo (year, month, week, day, etc.) y
dos fechas tal que fecha2 es superior o igual a fecha1, y nos devuelve la diferencia entre esas
dos fechas en la unidad de tiempo indicada. Muestra el contenido de la vista.*/
	
/*
b) Realiza una consulta sobre la vista VistaEmpleDep que muestre por cada departamento, su
nombre y su número de empleados.
*/
	
/*
c) Intenta modificar la antigüedad de Esther Gómez Bilbao a 8 años. ¿Es posible realizar esta
modificación? ¿Por qué?*/
	
/*
d) Intenta modificar el salario de Esther Gómez Bilbao a 2850 €. ¿Es posible realizar esta
modificación? ¿Por qué?*/
	
/*
4. A partir de las tablas Empleado y Departamento de la base de datos Empresa lleva a cabo las
siguientes operaciones relacionadas con vistas:*/
	
/*
a) Crea una vista llamada VistaEmple que contenga por cada empleado su número, nombre, fecha
de ingreso y número de departamento en el que trabaja para todos los empleados con fecha de
alta en el año 2014. Muestra el contenido de la vista.*/
	
/*
b) Intenta añadir un nuevo empleado a través de la vista VistaEmple indicando como número de
empleado el 15, nombre Pablo Fernández Gutiérrez, fecha de alta el día de hoy y número de
departamento el 1. ¿Qué ocurre en la tabla Empleado?*/
	
/*
c) ¿Se puede modificar a través de la vista VistaEmple el departamento en el que trabaja Ana
Ruiz Almeida de manera que sea el número 2? ¿Por qué?*/
	
/*
d) Elimina, si es posible, a la empleada Ana Ruiz Almeida por medio de la vista VistaEmple.*/
	
	