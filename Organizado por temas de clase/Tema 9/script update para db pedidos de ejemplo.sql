use pedidos_dam;

UPDATE Articulo
SET PVPArt = PVPArt + PVPArt*5/100
WHERE PVPArt < 1;

UPDATE Pedido
SET FecPed = CURRENT_DATE
WHERE RefPed IN (SELECT RefPed FROM LineaPedido);

select * from pedido;

update pedido
set fecped = '2025-02-08'
where refped = 'P0001';

insert into pedido values ('P0005', '2025-08-11');

select * from pedido order by fecped;