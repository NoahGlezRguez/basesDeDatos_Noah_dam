/*ACTIVIDADES DEL TEMA 7 - EJERCICIO 2 (EMPRESA2_DAM)*/

use empresa2_dam;

/*Apartado a
Muestra por cada empleado su código, nombre, salario y el nombre del departamento en el que
trabaja.
*/

select codemp, nomemp, salemp, d.nomdep
from empleado e join departamento d on e.coddep = d.coddep;

/*Apartado b
Muestra por cada departamento su código, nombre y el nombre del empleado que lo dirige.
*/

select d.coddep, nomdep, nomemp
from empleado e join departamento d on e.codemp = d.codempdir;

/*Apartado c
Muestra por cada empleado su nombre y por cada una de las habilidades que posee, el código de
la habilidad, la descripción de la habilidad y el nivel correspondiente.
*/

select e.nomemp, he.codhab, ha.DesHab, he.NivHab
from empleado e join habemp he  join habilidad ha
where e.codemp = he.codemp and he.CodHab = ha.CodHab;


/*Apartado d
Muestra el nombre y salario de todos los empleados con salario superior a 30000 €, así como el
porcentaje que supone su salario sobre el presupuesto de su departamento. Redondea el resultado
de esta última operación a 2 decimales.
*/

select e.nomemp, e.salemp, round((e.salemp / d.preanu) * 100, 2) 'porcentaje salario del presupuesto' 
from empleado e, departamento d
where e.coddep = d.coddep and e.salemp > 30000; 

/*Apartado e1
Muestra por cada empleado nacido después de 1974 su nombre, extensión telefónica, fecha de
nacimiento, nombre del departamento en el que trabaja y nombre del centro en el que este está
ubicado. Ordena el resultado por edad de los empleados del más joven al de mayor edad.
*/

select e.nomemp, e.extelemp, e.fecnaemp, d.nomdep, c.nomcen
from empleado e join departamento d on e.coddep = d.coddep join  centro c on d.codcen = c.codcen
where e.fecnaemp > '1974-12-31'
order by e.fecnaemp desc;


/*Apartado e2
Muestra los nombres y salarios de los empleados que tienen hijos nacidos después del año 2000.
*/

select distinct e.nomemp, e.salemp
from empleado e join  hijo h on e.codemp = h.codemp 
where  h.fecnahi > '2000-12-31';


/*Apartado f
Muestra para todos los centros de trabajo, su nombre y dirección, así como el nombre del empleado
que lo dirige, su extensión telefónica y su salario. Ordena el resultado por nombre de centro.
*/

select c.nomcen, c.dircen, e.nomemp, e.extelemp, e.salemp
from  centro c join empleado e on e.CodEmp = c.CodEmpDir
order by c.NomCen;

/*Apartado g
Muestra para el departamento que no depende de ningún otro departamento, su nombre,
presupuesto, el nombre del centro en el que está ubicado, así como su dirección y el nombre del
empleado que dirige dicho departamento.
*/

select d.nomdep, d.preanu, c.nomcen, c.dircen, e.nomemp
from  departamento d join centro c on d.codcen = c.codcen join empleado e on e.codemp = d.CodEmpDir 
where d.coddepdep is null;
