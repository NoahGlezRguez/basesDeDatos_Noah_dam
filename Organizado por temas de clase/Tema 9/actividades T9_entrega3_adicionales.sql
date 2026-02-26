use empresa2_dam;
/*ejercicio 1 los partados del 1 al 7*/

/*1. Inserta una nueva habilidad en la base de datos con código OFIMA y descripción Ofimática. Asigna
dicha habilidad a los empleados con códigos 1 y 2, asignándoles un 5 y un 8 como nivel de habilidad
respectivamente.*/
	
    insert into Habilidad
    values ('OFIMA', 'Ofimática');
    
    insert into habemp
    values ('OFIMA', 1, 5),
			('OFIMA', 2, 8);
    
/*2. Incrementa en un 5% el salario de los empleados que trabajen en departamentos de la zona Sur. Ten
en cuenta que los departamentos de la zona Sur son aquellos en cuyo nombre aparece la cadena ‘Zona
Sur’.*/
	
    update empleado
    set salemp = salemp * 1.05
    where coddep in (select coddep from departamento where nomdep like '%Zona Sur%');
    
/*3. Asigna a los departamentos que no tienen asignado centro, el único centro que está ubicado en
Murcia.*/
	
    update departamento
    set codcen = (select codcen
					from centro
                    where pobcen = 'Murcia')
    where codcen is null;
    
/*4. Decrementa en un 2,5% el salario a los empleados que trabajen en el departamento que no depende
de ningún otro departamento:*/
	
    update empleado
    set salemp = salemp * 0.975
    where coddep in (select coddep
						from departamento
                        where coddepdep is null);
    
/*5. A todos los empleados del departamento Ventas Zona Sur se les ha asignado el departamento
Producción Zona Sur. Refleja esta modificación en la base de datos.*/
	
    update empleado
    set coddep = (select coddep
					from departamento
                    where nomdep = 'Producción Zona Sur')
	where coddep = (select coddep
					from departamento
                    where nomdep = 'Ventas Zona Sur');
    
/*6. Los empleados que trabajan en el departamento con código PROZS han incrementado su nivel en la
habilidad con descripción Márketing en 1 punto. Refleja esta modificación en la base de datos.*/
	
    update habemp
    set nivhab = nivhab + 1
    where codhab = (select codhab from habilidad where deshab = 'Márketing')
			and codemp in (select codemp from empleado where coddep = 'PROZS');
    
/*7. Elimina todas las filas de la tabla HabEmp que hagan referencia a la habilidad con descripción
Ofimática. A continuación, modifica la descripción de esta habilidad, de manera que su nueva
descripción sea Oficina informática.*/
	
    delete from habemp
    where codhab = (select codhab from habilidad where deshab = 'Ofimática');
    
    update habilidad
    set deshab = 'Oficina informática'
    where deshab = 'Ofimática';
    