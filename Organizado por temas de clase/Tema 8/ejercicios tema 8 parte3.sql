/* Entrega parte 3 del tema 8*/
/*
Tema 8_PARTE II Actividades --> Consultas (Correlacionadas, Unión ,Intersección y diferencia, Creación de Consultas)
Ejercicio 1  entrega Script con consultas  (f, g, h)
Ejercicio 4   entrega Script con consultas  (a, b, c)*/

/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/* del enunciado de la parte 2:
	Ejercicio 1 - apartados f, g, h.*/
use empresa_dam;
/*f) Crea una tabla llamada Vendedores con el número, nombre y salario de los empleados con
tal puesto y el nombre del departamento en el que trabajan y la localidad.*/

	create table Vendedores(
		select e.numemp, e.nomemp, e.salario, d.nomdep, d.localidad
		from empleado e join departamento d on e.numdep = d.numdep
		where puesto = 'vendedor'
	);
	select *
	from vendedores;

/*g) Crea una tabla llamada DeparEmpleado que almacene por cada departamento su número,
nombre y localidad, así como el número de empleados que trabajan en él y su salario medio
redondeado a dos decimales. A estos dos últimos datos nómbralos No empleados y Salario
medio respectivamente.*/

	create table DeparEmpleado(
		select d.numdep, d.nomdep, d.localidad, count(e.nomemp) 'nº empleados',  round(avg(salario),2) 'salario medio'
		from departamento d join empleado e on d.numdep = e.numdep
		group by numdep
		
	);
	select *
	from deparempleado;

/*h) Muestra para los empleados con mayor salario de su departamento, el nombre del empleado,
su salario y el nombre del departamento en el que trabajan.*/

	select e.nomemp, salario, nomdep
	from empleado e natural join departamento d
	where salario in (select max(salario)
						from empleado natural join departamento
						group by nomdep);


/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
/*del enunciado de la parte 2:
	Ejercicio 4 - apartados a, b, c*/
    
use alumnado_dam;

/*4. Se dispone de una base de datos llamada Alumnado con información acerca de los alumnos de un
centro de enseñanza. Concretamente disponemos de 3 tablas, todas ellas con el mismo esquema
relacional:
 Alumnos (DNI, Nombre, Edad, Localidad), con datos de los alumnos actuales del centro.
 Antiguos (DNI, Nombre, Edad, Localidad), con datos de los alumnos antiguos del centro.
 Nuevos (DNI, Nombre, Edad, Localidad), con datos de los alumnos que ya se han
matriculado para el próximo curso.
Lleva a cabo las siguientes consultas empleando el lenguaje SQL:*/

/*a) Obtén los DNI y nombres de todos los alumnos acerca de los cuales disponemos de datos, es
decir, de todos los que aparecen en cualquiera de las tres tablas, sin que aparezcan filas
repetidas en el resultado.*/
	
    select distinct dni, nombre
    from alumnos
		union
    select dni, nombre
    from antiguos
		union 
    select dni, nombre
    from nuevos;

/*b) Obtén de dos maneras distintas los DNI y nombres de todos los alumnos que aparecen
simultáneamente en las tres tablas.*/
	select dni, nombre
    from alumnos
		intersect
    select dni, nombre
    from antiguos
		intersect
    select dni, nombre
    from nuevos;
    
    select dni, nombre
    from alumnos natural join antiguos natural join nuevos;

	select alumnos.dni, alumnos.nombre
    from alumnos inner join antiguos
						on alumnos.dni = antiguos.dni
				inner join nuevos 
						on antiguos.dni = nuevos.dni;
    
/*c) Obtén de tres maneras diferentes los DNI y nombres de todos los alumnos matriculados este
curso, pero que no se matricularon en cursos pasados ni están matriculados para el próximo
curso.*/

/* resultados esperados: 00121212W	LUISA RUDI + 09090909Q	PEDRO SÁNCHEZ + 56831890Y	RAQUEL DEL ROSARIO */	

/* a - (b + c)) */
select dni, nombre
from alumnos
	except 
(select dni, nombre
from antiguos
	union 
select dni, nombre
from nuevos);

/* a - b - c */
select dni, nombre
from alumnos
	except
select dni, nombre
from antiguos
	except
select dni, nombre
from nuevos;

select dni, nombre
from alumnos
where dni not in (select dni from antiguos
					union
                    select dni from nuevos);



