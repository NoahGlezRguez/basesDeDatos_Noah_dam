/*Se entrega el 12*/

use empresa_dam;

/*
12. Crea un procedimiento llamado IncrementarComisión que reciba el número de un empleado y
que en función del número de subordinados de ese empleado se le incremente la comisión del
siguiente modo: si el empleado no tiene subordinados, se le incrementará la comisión en 10 €; si
tiene un subordinado, se le incrementará la comisión en 25 €; si tiene 2 subordinados, se le
incrementará la comisión en 60 €; si tiene 3 subordinados, se le incrementará la comisión en 100
€; en cualquier otro caso, se le incrementará la comisión en 200 €. Puedes hacer uso de la función
creada en la actividad 8 para obtener el número de subordinados de un empleado. Muestra al final
un mensaje indicando el incremento de comisión de que ha disfrutado el empleado
*/
	delimiter //
    create procedure IncrementarComision(numemple int)
    begin
		declare numsubs int;
        declare comisi int;
        declare tipocomi int;
        
        select comision into comisi
        from empleado
        where numemp = numemple;
        
        set numsubs = consultarSubordinados(numemple);
        
        case numsubs
        when 0 then
			set comisi = comisi + 10;
            set tipocomi = 10;
        when 1 then
			set comisi = comisi + 25;
            set tipocomi = 25;
        when 2 then
			set comisi = comisi + 60;
            set tipocomi = 60;
		when 3 then
			set comisi = comisi + 100;
            set tipocomi = 100;
        else
			set comisi = comisi + 200;
            set tipocomi = 200;
        end case;
        
        update empleado
        set comision = comisi
        where numemp = numemple;
        
        select concat('El empleado nº ', numemple, ' ahora tiene una comisión de ', comisi, '€, (un incremento de ', tipocomi, '€).') Mensaje;
        
    end //
    delimiter ;
    
    -- pruebo diversas opciones
    select * from empleado; 
    
    select consultarSubordinados(9);
    call IncrementarComision(9);
    
    select consultarSubordinados(2);
    call IncrementarComision(2);
    
    select consultarSubordinados(4);
    call IncrementarComision(4);
    
    select consultarSubordinados(1);
    call IncrementarComision(1);
    