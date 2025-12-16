create database padron_municipal_bd
character set utf8mb4
collate utf8mb4_spanish_ci;

use padron_municipal_bd;

create table municipio
(nombre varchar(20),
provincia varchar(20),
numhabitantes int unsigned,
constraint primary key (nombre, provincia),
constraint ck_numhabitantes check (numhabitantes between 5 and 10000000)
);

create table vivienda
(codigo int unsigned auto_increment primary key,
direccion varchar(40) not null,
nommun varchar(20) not null,
nomprov varchar(20) not null,
constraint fk_nommunicipio_nomProv foreign key (nommun, nomprov) references municipio(nombre, provincia) on update cascade,
constraint uk_vivienda unique (direccion, nommun, nomprov)
);

create table persona
(nif char(9) primary key,
nombre varchar(20) not null,
fecnac date not null,
codvivienda int unsigned,
nifcabeza char(9),
constraint fk_codvivienda foreign key (codvivienda) references vivienda(codigo) on update cascade,
constraint fk_nifcabeza foreign key (nifcabeza) references persona(nif) on update cascade
);

create table posee
(nif char(9),
codvivienda int unsigned,
constraint fk_nif foreign key (nif) references persona(nif) on update cascade,
constraint fk_codigovivienda foreign key (codvivienda) references vivienda(codigo) on update cascade,
constraint primary key (nif, codvivienda)
);