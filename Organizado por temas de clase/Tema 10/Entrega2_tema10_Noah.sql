/* Se entregan los ejercicios 3 y 4 */
use empresa2_dam;
/*
3. A partir de las tablas Empleado y Departamento de la base de datos Empresa lleva a cabo las
siguientes operaciones relacionadas con vistas:*/

/*
a) Crea una vista llamada VistaEmpleDep que sea el resultado de una combinación entre las
tablas Empleado y Departamento y que contenga por cada empleado su nombre, su salario, su
antigüedad (calculada como la diferencia de años entre la fecha de hoy y la fecha de ingreso
en la empresa) y el nombre del departamento en el que trabaja. Los nombres de los atributos
de la vista deben ser NomEmp, Salario, Antigüedad y NomDep.
Ten en cuenta que:
current_date nos devuelve la fecha actual y que la función timestampdiff (unidad_tiempo,
fecha1, fecha2) recibe como parámetro una unidad de tiempo (year, month, week, day, etc.) y
dos fechas tal que fecha2 es superior o igual a fecha1, y nos devuelve la diferencia entre esas
dos fechas en la unidad de tiempo indicada. Muestra el contenido de la vista.*/
	
    create or replace
    view VistaEmpleDep (NomEmp, Salario, Antigüedad, NomDep)
    as Select e.nomemp, e.salemp, timestampdiff(year, e.fecinemp, current_date), d.nomdep
		from empleado e join departamento d on e.coddep = d.coddep;
    
    select * from vistaempledep;
    
/*
b) Realiza una consulta sobre la vista VistaEmpleDep que muestre por cada departamento, su
nombre y su número de empleados.
*/
	
    select nomdep, count(*) as 'Nº de empleados'
    from vistaempledep
    group by nomdep;
    
/*
c) Intenta modificar la antigüedad de Esther Gómez Bilbao a 8 años. ¿Es posible realizar esta
modificación? ¿Por qué?*/
	
    update vistaempledep
    set Antigüedad = 8
    where nomemp = 'Esther Gómez Bilbao';
    
	/*
    Ejecuto eso desde línea de comando y este es el output:
		mysql> update vistaempledep
			-> set Antigüedad = 8
			-> where nomemp = 'Esther Gómez Bilbao';
		ERROR 1348 (HY000): Column 'Antigüedad' is not updatable
		mysql>
    */
    
    -- No es posible. Es porque este atributo es resultado de una operacion que usa una funcion.
    -- Se tendría que modificar las tablas implicadas en lugar de la vista.
/*
d) Intenta modificar el salario de Esther Gómez Bilbao a 2850 €. ¿Es posible realizar esta
modificación? ¿Por qué?*/
	
    update vistaempledep
    set salario = 2850
    where nomemp = 'Esther Gómez Bilbao';

	/*
    Query OK, 0 rows affected (0.00 sec)
	Rows matched: 0  Changed: 0  Warnings: 0
	mysql>
    */
    
    /*
    Sí sería posible dado que este atributo es modificable PERO si nos fijamos aparece
    0 rows affected. Esto me da a entender que en la vista no había tal tupla. Si no aparece
    en la vista, no se modificará.
    */
    
/*
4. A partir de las tablas Empleado y Departamento de la base de datos Empresa lleva a cabo las
siguientes operaciones relacionadas con vistas:*/
	
    use empresa_dam;
    
/*
a) Crea una vista llamada VistaEmple que contenga por cada empleado su número, nombre, fecha
de ingreso y número de departamento en el que trabaja para todos los empleados con fecha de
alta en el año 2014. Muestra el contenido de la vista.*/
	
    create or replace
    view VistaEmple (NumEmple, NomEmple, FechaIngreso, NumDepart)
    as select e.numemp, e.nomemp, e.fecingreso, e.numdep
    from empleado e left join departamento d on e.numdep = d.numdep
    where year(e.fecingreso) = 2014;
    
    select * from vistaemple;
    
/*
b) Intenta añadir un nuevo empleado a través de la vista VistaEmple indicando como número de
empleado el 15, nombre Pablo Fernández Gutiérrez, fecha de alta el día de hoy y número de
departamento el 1. ¿Qué ocurre en la tabla Empleado?*/
	
    insert into vistaemple values (15, 'Pablo Fernández Gutiérrez', current_date, 1);
    
    /*
		mysql>  insert into vistaemple values (15, 'Pablo Fernández Gutiérrez', current_date, 1);
		ERROR 1471 (HY000): The target table vistaemple of the INSERT is not insertable-into
		mysql>
    */
    
    /*
    Para la vista usé left join para asegurarme de mostrar a todos los empleados, incluyendo los
    posibles casos en los que no tengan asignado departamento.
    Para probar este insert, con la vista creadá así no es posible insertar datos.
    Pero voy a probar creado otra vista sin usar join, usando solo la tabla empleado... :
    
		create or replace
		view VistaEmple2 (NumEmple, NomEmple, FechaIngreso, NumDepart)
		as select e.numemp, e.nomemp, e.fecingreso, e.numdep
		from empleado e 
		where year(e.fecingreso) = 2014;
        
        mysql> insert into vistaemple2 values (15, 'Pablo Fernández Gutiérrez', current_date, 1);
		ERROR 1423 (HY000): Field of view 'empresa_dam.vistaemple2' underlying table doesn't have a default value
		mysql>
        
        En este enunciado no se indican más valores para realizar el insert y el sistema no permite hacer
        ningún insert a una tabla si no se le da valores a aquellos atributos que son not-null.
        Falta puesto, salario...
    */
    
    
/*
c) ¿Se puede modificar a través de la vista VistaEmple el departamento en el que trabaja Ana
Ruiz Almeida de manera que sea el número 2? ¿Por qué?*/
	
    update vistaemple
    set numdep = 2
    where nomemp = 'Ana Ruiz Almeida';
    
    /*
    ERROR 1288 (HY000): The target table vistaemple of the UPDATE is not updatable
	mysql>
    */
    
    /*
    Pruebo con vistaemple2:
    mysql> update vistaemple2
		-> set numdep = 2
		-> where nomemp = 'Ana Ruiz Almeida';
	Query OK, 1 row affected (0.00 sec)
	Rows matched: 1  Changed: 1  Warnings: 0

	Si se pudo modificar dicho atributo, ya que solo implica una tabla y la vista vistaemple2 no usa join. 
    */
    
    
/*
d) Elimina, si es posible, a la empleada Ana Ruiz Almeida por medio de la vista VistaEmple.*/
	
    delete from vistaemple
    where nomemp = 'Ana Ruiz Almeida';
    
     /*
    ERROR 1288 (HY000): The target table vistaemple of the UPDATE is not updatable
	mysql>
    */
    
    -- Pruebo, de nuevo, con vistaemple2:
	/*
    mysql> delete from vistaemple2
		-> where nomemp = 'Ana Ruiz Almeida';
	Query OK, 1 row affected (0.00 sec)

	mysql> */
    /*
    
	-- Con esta vista sí fue posible.