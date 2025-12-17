create database multas_bd
char set utf8mb4
collate utf8mb4_spanish_ci;

use multas_bd;

create table vehiculos
(matricula char(7) primary key,
marcamodelo varchar(30) not null,
impuesto double not null default 50,
constraint ck_impuesto check (impuesto >= 10)
);

create table guardias
(codigog char(5) primary key,
codigogjefe char(5),
nombre varchar(30) not null,
constraint fk_codgjefe foreign key (codigogjefe) references guardias(codigog) on update cascade
);

create table multas
(nmulta int unsigned primary key auto_increment,
codigog char(5) not null,
matricula char(7) not null,
fecha timestamp not null default current_timestamp,
lugar varchar(30) not null, 
importe double not null,
descripcion varchar(30) not null,
pagada enum('si', 'no') not null,
constraint ck_importe check (importe between 15 and 600),
constraint fk_codguardia foreign key (codigog) references guardias(codigog) on update cascade,
constraint fk_matricula foreign key (matricula) references vehiculos(matricula) on update cascade
);

