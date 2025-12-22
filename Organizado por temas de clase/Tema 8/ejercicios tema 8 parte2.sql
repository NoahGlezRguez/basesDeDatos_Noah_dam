
/* TEMA 8 - ACTIVIDADES - PARTE 1 */
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* EJERCICIO 1.-*/
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
/* EJERCICIO 2.-*/
use empresa2_dam;



/*c) Muestra por cada departamento su nombre, presupuesto, el nombre del departamento del que
depende y el presupuesto de este. Asigna alias a todos los atributos.*/

