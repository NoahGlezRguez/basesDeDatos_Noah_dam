create database suministros_bd
char set utf8mb4
collate utf8mb4_spanish_ci;

use suministros_bd;

create table proveedor
(codprov int unsigned primary key ,			
nomprov varchar(30) not null unique,
dirprov varchar(30) not null
constraint ck_codprov check (codprov > 0)
);

create table materiaprima
(codmp int unsigned primary key,
nommp varchar(30) not null,
codprov int unsigned not null,
constraint fk_codProv_mp foreign key (codprov) references proveedor(codprov) on update cascade
);

create table componente
(codcomp char(4) primary key,
nomcomp varchar(30) not null,
stockcomp int unsigned not null,
stockmincomp int unsigned not null default 5
);

create table composicion
(codcompsup char(4),
codcompinf char(4),
cant int unsigned default 1,
constraint pk_codcomps_composicion primary key (codcompsup, codcompinf),
constraint fk_codcomsup_codcominf foreign key (codcompsup, codcompinf) references componente(codcomp) on delete restrict
);

create table fabricacion
(codmp int unsigned,
codcomp char(4),
constraint pk_codmp_codcomp primary key (codmp, codcomp),
constraint fk_codmp foreign key (codmp) references materiaprima(codmp)  on delete restrict,
constraint fk_codcomp foreign key (condcomp) references componente(codmp) on delete restrict
);


