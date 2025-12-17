create database geografia_bd
char set utf8mb4
collate utf8mb4_spanish_ci;

use geografia_bd;

create table localidades
(id_localidad int unsigned primary key,
nombre varchar(30) not null,
poblacion int unsigned not null,
n_provincia int unsigned not null,
constraint ck_id_localidad check (id_localidad between 1 and 9000),
constraint ck_poblacion check (poblacion between 1 and 10000000),
constraint uk_nombre_num_provincia unique (nombre, n_provincia)
);

create table comunidades
(id_comunidad int unsigned primary key,
nombre varchar(30) unique not null,
id_capital int unsigned not null unique,
constraint ck_idcomunidad check (id_comunidad between 1 and 19)
);

create table provincias
(n_provincia int unsigned primary key,
nombre varchar(30) unique not null,
superficie int unsigned not null,
id_capital int unsigned not null unique,
id_comunidad int unsigned not null,
constraint ck_n_provincia check (n_provincia between 1 and 52),
constraint ck_superficie check (superficie between 1 and 150000)
);

alter table localidades
add constraint fk_nprovincia foreign key (n_provincia) references provincias(n_provincia);

alter table comunidades
add constraint fk_idcapital foreign key (id_capital) references localidades(id_localidad) on update cascade;

alter table provincias
add constraint fk_idcomunidad foreign key (id_comunidad) references comunidades(id_comunidad) on update cascade;

alter table provincias
add constraint fk_idcapi_prov foreign key (id_capital) references localidades(id_localidad) on update cascade;



/*Responde a las siguientes preguntas:
a) ¿Por qué se ha especificado como única la pareja de atributos nombre + n_provincia en la tabla
Localidades?
	- Porque puede haber varias localidades con el mismo nombre pero no dentro de la misma provincia.

b) ¿Por qué se ha especificado como único el atributo id_capital en la tabla Provincias?
	- Porque cada provincia solo tiene una capital

c) ¿Por qué se ha especificado como único el atributo id_capital en la tabla Comunidades?
	- Porque cada comunidad solo tiene una capital

Una vez creada la base de datos vamos a hacer uso de la utilidad de ingeniería inversa de MySQL
Workbench. Esta utilidad permite a partir del esquema físico de una base de datos creada generar algo
similar a su diagrama Entidad-Relación. Para ello elijamos la opción Database – Reverse Engineer.
Una vez seleccionada una conexión, elijamos la base de datos cuyo diagrama queremos generar
(Geografía en este caso) y se nos generará el correspondiente diagrama.*/