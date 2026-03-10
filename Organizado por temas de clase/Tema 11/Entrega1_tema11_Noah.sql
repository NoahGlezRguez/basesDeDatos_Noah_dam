/* Se entrega del 1 al 5 */

/*
A partir de las bases de datos Pedidos y Empresa, cuyos esquemas relaciones se muestran a
continuación:

Pedido (RefPed, FecPed)
LíneaPedido (RefPed, CodArt, CantArt)
Artículo (CodArt, DesArt, PVPArt)

Departamento (NumDep, NomDep, Localidad)
Empleado (NumEmp, NomEmp, Puesto, NumEmpJefe, FecIngreso, Salario, Comision, NumDep)
*/

use pedidos_dam;

/*
	1. Crea un procedimiento que añada un nuevo pedido a la tabla Pedido con datos pasados como
	parámetro. Por tanto, este procedimiento recibirá como parámetros la referencia del pedido y la
	fecha. Muestra al final un mensaje con el texto ‘Se ha añadido un pedido con referencia XXXXX’,
	siendo XXXXX la referencia del nuevo pedido.
*/
	delimiter //
    create procedure agregarPedido(RefPed char(5), fechaPedido date)
    modifies sql data
    begin
    insert into pedido values(RefPed, fechaPedido);
    select concat ('Se ha añadido un pedido con referencia ', refPed, ', siendo ', refPed, ' la referencia del nuevo pedido') Mensaje; 
    -- El enunciado es redundante, dice que muestre dos veces la referencia del nuevo pedido en el mensaje.
    END;//
    
    call agregarPedido('P0010', '2026-03-10');//
    
/*
	2. Escribe un procedimiento que muestre en pantalla la descripción y el precio del artículo más
	barato de la base de datos.
*/
	delimiter //
    create procedure mostrarDatos()
    modifies sql data
    begin
    select DesArt, PVPArt
    from articulo
    where PVPArt = (select min(PVPArt) from articulo);
    end; //
    
    call mostrarDatos();//
    
/*
	3. Crea una función que nos devuelva la descripción del artículo más caro de la base de datos.
*/
 
    delimiter //
    create function productoMasCaro() returns varchar(30)
    reads sql data
    begin
    declare articuloCaro varchar(30);
    select DesArt into articuloCaro
    from articulo
    where PVPArt = (select max(PVPArt) from articulo);
    return articuloCaro;
    end; //
    
    select productoMasCaro() Producto;//
    
/*
	4. Crea un procedimiento que reciba la referencia de un pedido y muestre en pantalla dicha referencia
	y la fecha del pedido y se encargue de eliminarlo de la base de datos. Debe mostrase un mensaje
	con el texto ‘Pedido XXXXX eliminado’.
*/

	delimiter //
    create procedure eliminarPedido(refpedi char(5))
    modifies sql data
    begin
    delete from pedido where refped = refpedi;
    select concat ('Pedido ', refpedi, ' eliminado.') Mensaje;
    end;//

	call eliminarPedido('P0010');//

/*
	5. Crea un procedimiento que reciba el código de un artículo y un número entero positivo o negativo.
	El procedimiento debe modificar el precio del artículo según el porcentaje pasado como parámetro
	y mostrar el precio del artículo antes y después de la modificación. Por ejemplo, si el
	procedimiento recibe como segundo parámetro un 5, deberá subir el precio del artículo un 5%,
	mientras que si recibe un -2, deberá bajar el precio del artículo un 2%.
*/
	
    create procedure cambiarPrecio(codarti char(5), precio int)
    modifies sql data
    begin
    
    declare precioAntes decimal(6,2);
    declare precioAhora decimal(6,2);
    
    select pvpart into precioAntes from articulo where codart = codarti;
    
    update articulo
    set pvpart = ((precio / 100) * pvpart) + pvpart
    where codart = codarti;
    
    select pvpart into precioAhora from articulo where codart = codarti;
    
    select concat ('El precio previo del producto era ', precioAntes, '. El precio del producto ahora es ', precioAhora) Mensaje;
    
    end //
    
    call cambiarPrecio('A0012', 10)//
    
    delimiter ;