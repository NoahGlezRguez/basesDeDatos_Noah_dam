create database ligaFutbol_bd
character set utf8mb4
collate utf8mb4_spanish_ci;

use ligaFutbol_bd;

create table equipos
(id_equipo int unsigned auto_increment primary key,
nombre varchar(40) unique not null,
estadio varchar(40) not null,
aforo int unsigned not null default 2000,
año_fundacion year not null,
ciudad varchar(40) not null,
constraint ck_aforo check (aforo >100),
constraint ck_año_funda check (año_fundacion between '1850' and '2050')
);

create table jugadores
(id_jugador int unsigned auto_increment primary key,
nombre varchar(40) unique not null,
fecha_nac date not null,
id_equipo int unsigned not null,
constraint fk_id_equipo foreign key (id_equipo) references equipos(id_equipo)
);

create table partidos
(id_equipo_casa int unsigned,
id_equipo_fuera int unsigned,
fecha date not null,
goles_casa int unsigned not null default 0,
goles_fuera int unsigned not null default 0,
observaciones varchar(100),
constraint fk_id_equicasa foreign key (id_equipo_casa) references equipos(id_equipo),
constraint fk_id_equifuera foreign key (id_equipo_fuera) references equipos(id_equipo),
constraint pk_id_equi_casafuera primary key (id_equipo_casa, id_equipo_fuera)
);

create table goles
(id_equipo_casa int unsigned,
id_equipo_fuera int unsigned,
minuto int unsigned not null,
descripcion varchar(100) not null,
id_jugador int unsigned,
constraint ck_minuto check (minuto between 0 and 130),
constraint fk_id_equipo_casa foreign key (id_equipo_casa) references equipos(id_equipo),
constraint fk_id_equipo_fuera foreign key (id_equipo_fuera) references equipos(id_equipo),
constraint fk_id_jugador foreign key (id_jugador) references jugadores(id_jugador) on update cascade on delete cascade,
constraint pk_idequicasa_idequifuera_minuto primary key (id_equipo_casa, id_equipo_fuera, minuto)
);