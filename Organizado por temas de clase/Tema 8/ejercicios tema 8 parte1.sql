
/* TEMA 8 - ACTIVIDADES - PARTE 1 -  ej1 a,b,c,d,e | ej2 a,b | ej3 a,b  */
/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* EJERCICIO 1.-*/

use empresa_dam;

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


-- los otros apartados van en otra entrega

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* EJERCICIO 2.-*/
use empresa2_dam;

/*a) Muestra por cada centro de trabajo, su nombre y dirección, así como el número de
departamentos en que se divide y el presupuesto máximo y mínimo de sus departamentos.*/

select c.nomcen, c.dircen, count(d.coddep) 'nº de departamentos del centro', max(d.preanu) 'presupuesto maximo departamento', min(d.preanu) 'presupuesto minimo departamento'
from centro c left join departamento d on c.codcen = d.codcen
group by c.nomcen, c.dircen;

/*b) Muestra por cada habilidad su código y descripción, el número de empleados que la poseen y
el nivel medio de dicha habilidad redondeado a un decimal.*/

select ha.codhab, ha.deshab, count(e.codemp) 'empleados con la habilidad', round(avg(he.nivhab), 2) 'nivel medio de habilidad'
from habilidad ha join habemp he on ha.codhab = he.CodHab join empleado e on he.Codemp = e.Codemp
group by ha.CodHab, ha.DesHab;

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* EJERCICIO 3.-*/
use geografia_dam;

/*a) Obtén los nombres de las comunidades autónomas uniprovinciales, es decir, las formadas por
una sola provincia.*/

select c.nombre
from  comunidades c join provincias p on c.id_comunidad = p.id_comunidad
group by c.id_comunidad, c.nombre
having count(p.n_provincia) = 1;

/*b) Muestra por cada provincia, su nombre, su superficie, su población y su densidad poblacional
redondeada a 2 decimales (columna Densidad poblacional). Este último dato se calcula
dividiendo la población de la provincia entre su superficie. Ordena los datos por provincias
desde la menos densamente poblada hasta la más densamente poblada.*/

select p.nombre Provincia,  p.superficie Km2, sum(l.poblacion) as Población, round(sum(l.poblacion / p.superficie), 2) 'Densidad poblacional'
from provincias p join localidades l on p.n_provincia = l.n_provincia
group by p.nombre
order by sum(l.poblacion) / p.superficie;
	
