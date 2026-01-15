use pedidos_dam;

UPDATE Articulo
SET PVPArt = PVPArt + PVPArt*5/100
WHERE PVPArt < 1;