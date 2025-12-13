use padronmunicipal_dam_v;

create table vivienda 
(Codigo int unsigned,
Direccion varchar(40) not null unique,
NomMun varchar(40) not null unique,
NomProv varchar(40) not null unique
/*contraint varios, uno de Codigo, otro de alternativa y otro de foreitgn key*/
);