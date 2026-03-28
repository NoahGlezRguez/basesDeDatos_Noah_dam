create database LFP collate utf8mb4_spanish_ci;
use LFP;

Create table Equipos
(id_equipo int unsigned auto_increment primary key,
nombre varchar(30) not null unique,
estadio varchar(30) not null,
aforo int unsigned default 2000,
año_fundación int unsigned,
ciudad varchar(30) not null, 
capitán int unsigned);

Create table Jugadores
(id_jugador int unsigned auto_increment primary key,
nombre varchar(30) not null unique,
fecha_nac date not null,
id_equipo int unsigned not null,
foreign key(id_equipo) references Equipos(id_equipo));

create table Partidos
(id_equipo_casa int unsigned,
id_equipo_fuera int unsigned,
Fecha date not null,
Goles_casa int unsigned default 0 not null,
Goles_fuera int unsigned default 0 not null,
Observaciones varchar(200),
Primary key (id_equipo_casa, id_equipo_fuera),
foreign key(id_equipo_casa) references Equipos(id_equipo),
foreign key(id_equipo_fuera) references Equipos(id_equipo));

create table goles
(id_equipo_casa int unsigned,
id_equipo_fuera int unsigned,
minuto int unsigned,
descripción varchar(200) not null,
id_jugador int unsigned,
primary key (id_equipo_casa, id_equipo_fuera, minuto),
foreign key (id_equipo_casa, id_equipo_fuera) references partidos (id_equipo_casa, id_equipo_fuera),
foreign key(id_jugador) references Jugadores(id_jugador) on delete cascade on update cascade);

insert into equipos values (1,'Retortillo','Los pinares',1200,1960,'Retortillo', 6);
insert into equipos values (2,'Villa F.C.','San Isidro',3500,1970,'Villa', 17);
insert into equipos values (3,'Athletic Formeñosa','La Huerta',350,1963,'Formeñosa', 27);
insert into equipos values (4,'Valdeajos','Municipal de valdeajos',2100,1962,'Valdeajos', 34);

insert into jugadores values (1,'Alberto','1985-03-12',1);
insert into jugadores values (2,'Diego','1990-04-13',1);
insert into jugadores values (3,'José','1991-02-02',1);
insert into jugadores values (4,'Díez Crespo','1987-07-01',1);
insert into jugadores values (5,'Avellaneda','1990-02-25',1);
insert into jugadores values (6,'Julianillo','1996-05-30',1);
insert into jugadores values (7,'Redondela','1993-11-18',1);
insert into jugadores values (8,'Casero','1994-12-03',1);
insert into jugadores values (9,'Quirós','1995-11-17',1);
insert into jugadores values (10,'Fonseca','1991-03-18',1);
insert into jugadores values (11,'Lucín','1993-07-12',1);
insert into jugadores values (12,'Pacheco','1995-11-12',2);
insert into jugadores values (13,'Pablillo','1998-02-01',2);
insert into jugadores values (14,'Sandrelli','1999-07-08',2);
insert into jugadores values (15,'Caramiñán','1995-11-12',2);
insert into jugadores values (16,'Sondíez','2000-01-31',2);
insert into jugadores values (17,'Carrasco','1996-02-19',2);
insert into jugadores values (18,'Rodríguez','1995-09-06',2);
insert into jugadores values (19,'Mercena','1996-11-28',2);
insert into jugadores values (20,'Frasco','1997-07-12',2);
insert into jugadores values (21,'Carmona','2000-05-31',2);
insert into jugadores values (22,'Velazquez','1993-12-02',2);
insert into jugadores values (23,'Valdivia','1993-07-13',3);
insert into jugadores values (24,'Francisco','1991-09-11',3);
insert into jugadores values (25,'Casares','1992-04-23',3);
insert into jugadores values (26,'Jofaina','1999-09-17',3);
insert into jugadores values (27,'Santiago','1996-09-20',3);
insert into jugadores values (28,'Zárate','1994-08-19',3);
insert into jugadores values (29,'Solís','1998-01-31',3);
insert into jugadores values (30,'Crespo','1992-06-17',3);
insert into jugadores values (31,'Leresma','1992-08-18',3);
insert into jugadores values (32,'Juárez','1994-11-20',3);
insert into jugadores values (33,'Márquez','1995-01-26',3);
insert into jugadores values (34,'Porras','1993-02-12',4);
insert into jugadores values (35,'Paredes','1995-07-15',4);
insert into jugadores values (36,'Delarrós','1996-04-26',4);
insert into jugadores values (37,'Ramiro','2001-09-01',4);
insert into jugadores values (38,'Gonzálvez','2002-09-20',4);
insert into jugadores values (39,'Darbaño','1996-06-19',4);
insert into jugadores values (40,'Luisón','1989-08-09',4);
insert into jugadores values (41,'Carrasposa','2001-08-06',4);
insert into jugadores values (42,'Serrano','1992-12-12',4);
insert into jugadores values (43,'Unanu','1994-08-02',4);
insert into jugadores values (44,'Narvaja','1995-09-08',4);

insert into partidos values (1,2,'2019-08-18',1,2,'Se aplazó al día siguiente');
insert into partidos values (1,3,'2019-08-17',2,0,null);
insert into partidos values (2,4,'2019-08-17',4,2,null);
insert into partidos values (3,2,'2019-08-25',0,2,null);
insert into partidos values (3,4,'2019-08-10',0,0,null);
insert into partidos values (4,1,'2019-08-25',2,2,null);

insert into goles values (1,2,9,'Golazo de cabeza',1);
insert into goles values (1,2,60,'Carambola',16);
insert into goles values (1,2,87,'Zurdazo impresionantes',12);
insert into goles values (1,3,28,'De penalti',1);
insert into goles values (1,3,57,'De falta',1);
insert into goles values (2,4,17,'Gran combinación',12);
insert into goles values (2,4,21,'De falta',12);
insert into goles values (2,4,75,'Desde el medio campo',34);
insert into goles values (2,4,78,'Centro chut',35);
insert into goles values (2,4,82,'De penalti',14);
insert into goles values (2,4,89,'De penalti',12);
insert into goles values (4,1,67,'En propia puerta',34);
insert into goles values (4,1,68,'regate impresionante y marca tras quedarse solo',36);
insert into goles values (3,2,27,'De falta',12);
insert into goles values (4,1,83,'Cabezazo desde el borde del area pequeña',1);
insert into goles values (4,1,88,'De penalti',1);
insert into goles values (3,2,78,'De cabeza',16);

alter table Equipos add constraint fk_capitan foreign key (capitán) references Jugadores(id_jugador) on update cascade; 