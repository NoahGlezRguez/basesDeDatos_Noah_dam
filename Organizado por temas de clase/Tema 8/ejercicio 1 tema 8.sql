use empresa_dam;

/* TEMA 8 - ACTIVIDADES - PARTE 1 */
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* EJERCICIO 1.-*/

/*a) Indica por cada puesto que sea desempeñado por más de dos empleados, el nombre del puesto,
el número de empleados que lo desempeñan, la suma de sus salarios, la suma de sus
comisiones, el salario máximo y el salario mínimo. Asigna alias a todos los datos que se
muestran excepto al puesto. Ordena el resultado por suma salarial en orden descendente.*/
select puesto, count(*) 'Trabajadores por puesto', sum(salario) Total_salarios, sum(comision) 'Total comisiones',
		max(salario) 'Salario más alto', min(salario) 'Salario más bajo'
from empleado
group by puesto
having count(*) > 2
order by sum(salario) desc;

/*b) Indica por cada número de departamento y puesto, el número de empleados que desempeñan
ese puesto en ese departamento, así como su salario mínimo y máximo. Ordena el resultado
por número de departamento y puesto.*/
select D.NumDep, puesto, count(*), min(salario), max(salario)
from empleado E join departamento D on E.numDep = D.NumDep
group by d.numdep, puesto
order by D.numdep, puesto;

/*c) Solo consideraremos a los empleados no directores. Pues bien, indica por cada departamento
con un salario medio de sus empleados no directores superior a 1200 €, el número del
departamento, el número de empleados no directores que tiene y su salario medio (redondeado
a dos decimales), ordenando el resultado por el número de empleados de cada departamento.*/
select numdep, count(*) 'Trabajadores por departamento', puesto, round(avg(salario), 2) 'Salario medio de los empleados'
from empleado 
where puesto not like 'Director'
group by numdep, puesto
having avg(salario) > 1200
order by count(*);


/*d) Indica para los departamentos con salario medio superior a 1800 €, su número, nombre, el
salario medio de sus empleados y el salario máximo y mínimo.*/
select d.numdep, d.nomdep, round(avg(salario),2) 'Salario medio', max(salario) 'Salario más alto', min(salario) 'Salario más bajo'
from departamento d natural join empleado e
group by d.numdep
having avg(salario) > 1800;


/*e) Visualiza el número de vendedores del departamento llamado Ventas.*/
select count(*) 'nº trabajadores de ventas'
from empleado e natural join departamento d
where d.nomdep = 'Ventas';

	-- otra opcion seria:
select count(*) 'nº trabajadores de ventas'
from empleado e natural join departamento d
group by d.nomdep
having d.nomdep = 'Ventas';

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

