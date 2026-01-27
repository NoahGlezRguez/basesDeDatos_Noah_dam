/*
	Entrega Actividades Adicionales Parte 1:
		BBDD Empresa: a, b, c ,d, e
		BBDD Empresa2 : a, b, c, d, e, f, g
*/
/*EJERCICIO 1.-*/
use empresa_dam;

/*a) Indica por cada departamento su nombre y localidad, así como el número de empleados que
trabajan en él y su salario medio redondeado a dos decimales, ordenando el resultado por
salario medio.*/
	select d.nomdep, d.localidad, count(*) 'empleados', round(avg(salario), 2) 'salario medio'
    from departamento d join empleado e on d.numdep = e.numdep
    group by d.numdep
    order by round(avg(salario), 2);
    
	

/*b) Indica por cada departamento y puesto, el nombre del departamento y el puesto así como el
salario medio y la comisión media de los empleados que desempeñan ese puesto en ese
departamento. Ordena el resultado por salario medio de mayor a menor.*/
	select d.nomdep, e.puesto, round(avg(salario), 2) SalarioMedio, round(avg(comision), 2) 'Comisión media'
    from departamento d join empleado e on d.numdep = e.numdep
    group by d.numdep, e.puesto
    order by SalarioMedio desc;
    
/*c) Visualiza por cada puesto de los empleados del departamento de Ventas, el nombre del puesto
y la suma de salarios de los empleados con dicho puesto.*/
	select e.puesto, sum(salario)
    from empleado e join departamento d on e.numdep = d.numdep
    where d.nomdep = 'Ventas'
    group by e.puesto;
    
/*d) Visualiza el número de empleados de cada departamento cuyo oficio sea empleado, indicando
el nombre del departamento y el número de empleados.*/
	select d.nomdep, count(*)
    from departamento d join empleado e on d.numdep = e.numdep
    where e.puesto = 'Empleado'
    group by d.numdep;
    
/*e) Muestra para todos los departamentos su nombre y localidad y además el número de
empleados que trabajan en él. Si en un departamento no trabaja ningún empleado, deberá
ponerse un 0 en el número de empleados.*/
	select d.nomdep, d.localidad, count(nomemp) 'Nº de empleados'
    from departamento d left join empleado e on d.numdep = e.numdep
    group by d.nomdep;
    
    
    
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*EJERCICIO 2.-*/
use empresa2_dam;


/*a) Muestra por cada departamento de la empresa con más de dos empleados, el nombre del
departamento, el nombre del centro al que pertenece, su número de empleados y el salario
medio de sus empleados con dos decimales. Ordena el resultado por número de empleados de
cada departamento de mayor a menor.*/
	select d.nomdep, c.nomcen, count(e.nomemp) NumEmpleados, round(avg(e.salemp), 2) SalarioMedio
    from centro c join departamento d on c.codcen = d.codcen join empleado e on d.coddep = e.coddep 
    group by d.coddep
    having NumEmpleados > 2
    order by NumEmpleados desc;
    
    
/*b) Muestra para todos los departamentos con presupuesto inferior a 100.000 €, su nombre y
presupuesto y en caso de que figure en la base de datos, el nombre del centro al que pertenece
y la población del centro. Si no figura el centro en el que está ubicado un departamento, los
datos del centro deben aparecer en blanco. Ordena el resultado por presupuesto de mayor a
menor.*/
	

/*c) Lista el nombre de cada departamento y el nombre del departamento del que depende (sólo
para los departamentos dependientes).*/

/*d) Lista el nombre de todos los empleados, así como todos los códigos de las habilidades que
poseen y los niveles de habilidad correspondientes, en el caso de que las posean. (Si un
empleado no posee ninguna habilidad sólo deberá aparecer su nombre; en el caso de que posea
alguna, además de su nombre deberá aparecer por cada una de ellas el código de la habilidad
y el nivel correspondiente).*/

/*e) Muestra por cada departamento jefe, su código, nombre y el número de departamentos que
dependen de él.*/

/*f) Muestra el nombre y presupuesto de los departamentos en los que la suma de los salarios de
sus empleados sea igual o superior al 25% de su presupuesto.*/

/*g) Muestra por cada departamento con al menos 2 empleados y ubicado en un centro de
Cartagena, su código, nombre y el salario mínimo, máximo y medio de sus empleados. Ordena
el resultado por salario medio de mayor a menor.*/

