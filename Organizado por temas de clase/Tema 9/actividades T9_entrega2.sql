/*2. */
use empresa2_dam;

/*a) Crea la tabla EmpDep (CodEmp, NomEmp, SalEmp, NomDep) cuyas columnas tienen el
mismo tipo y tamaño que las homónimas de otras tablas existentes en la base de datos. Inserta
en dicha tabla el código, nombre y salario de los empleados que trabajen en centros ubicados
en Murcia, así como el nombre del departamento en el que trabajan.*/
	
    create table EmpDep as
		select codemp, nomemp, salemp, nomdep
        from empleado e join departamento d on e.coddep = d.coddep; 

	delete from empdep;
	
    insert into EmpDep
		select e.codemp, e.nomemp, e.salemp, d.nomdep
        from empleado e join departamento d on e.coddep = d.coddep join centro c on d.codcen = c.codcen
		where c.pobcen = 'Murcia';
		
/*b) Incrementa en la tabla EmpDep en un 8 % el sueldo de los empleados que trabajen en el
departamento llamado Dirección General.*/
	
    update empdep
    set salemp = salemp * 1.08
    where nomdep = 'Dirección General';
    
/*c) Inserta en la tabla EmpDep un empleado con código 99, nombre Pérez Ruiz, María, salario
15000 € y departamento Ventas Zona Sur,*/
	
    insert into empdep
    values (99, 'Pérez Ruiz, María', 15000, 'Ventas Zona Sur');
    
    
/*d) Borra de la tabla EmpDep a los empleados que cobren más de 20000 € y que trabajen en el
departamento con código INYDI.*/
	
    delete from empdep
    where salemp > 20000 and nomdep = (select nomdep
										from departamento
                                        where coddep = 'INYDI');
    
/*e) Asigna en la tabla EmpDep al empleado que trabaja en el departamento con código DIRGE,
el salario máximo de los empleados de la tabla Empleado que trabajan en el departamento con
código VENZS.*/
	
    update empdep
    set salemp = (select max(salemp)
					from empleado e join departamento d on e.coddep = d.coddep
                    where d.coddep = 'VENZS')
	where nomdep = (select nomdep
						from departamento
                        where coddep = 'DIRGE');
    