create database suministros_bd
char set utf8mb4
collate utf8mb4_spanish_ci;

use suministros_bd;

create table proveedor
(codprov int unsigned primary key  			
nomprov varchar(30) not null unique
dirprov
);


/*
constraints pendientes:
	- proveedor.codprov debe ser mayor que 0



*/