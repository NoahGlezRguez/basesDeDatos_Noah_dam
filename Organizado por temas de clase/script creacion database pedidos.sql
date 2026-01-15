create database pedidos_dam collate utf8mb4_spanish_ci;
use pedidos_dam;

create table Pedido
(RefPed char(5) primary key,
FecPed date not null);

create table Articulo
(CodArt char(5) primary key,
DesArt varchar(30) not null,
PVPArt numeric(6,2) not null,
constraint ck_PVPArt check (PVPArt>0));

create table LineaPedido
(RefPed char(5),
CodArt char(5),
CantArt int unsigned not null default 1 ,
constraint ck_CantArt check (CantArt > 0),
constraint fk_RefPed_LineaPedido foreign key (RefPed) 
				references Pedido(RefPed) on update cascade,
constraint fk_CodArt_LineaPedido foreign key (CodArt) 
				references Articulo(CodArt) on update cascade,
constraint pk_LineaPedido primary key (RefPed, CodArt));

insert into pedido values ('P0001', '2025-02-16');
insert into pedido values ('P0002', '2025-02-18');
insert into pedido values ('P0003', '2025-02-23');
insert into pedido values ('P0004', '2025-02-25');

insert into articulo values ('A0043', 'Bolígrafo azul', 0.78);
insert into articulo values ('A0078', 'Bolígrafo rojo normal', 1.05);
insert into articulo values ('A0075', 'Lápiz 2B', 0.55);
insert into articulo values ('A0012', 'Goma de borrar', 0.15);
insert into articulo values ('A0089', 'Sacapuntas', 0.25);

insert into lineapedido values ('P0001', 'A0043', 10);
insert into lineapedido values ('P0001', 'A0078', 12);
insert into lineapedido values ('P0002', 'A0043', 5);
insert into lineapedido values ('P0003', 'A0075', 20);
insert into lineapedido values ('P0004', 'A0012', 15);
insert into lineapedido values ('P0004', 'A0043', 5);
insert into lineapedido values ('P0004', 'A0089', 50);
 