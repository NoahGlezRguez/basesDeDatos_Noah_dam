use padronmunicipal_dam_v;

create table Municipio
(Nombre varchar(40),
Provincia varchar(40),
NumHabitantes mediumint unsigned,
constraint ck_num_habitantes_municipio check (NumHabitantes between 5 and 10000000),
constraint pk_nombre_provincia_municipiO primary key (Nombre, Provincia)
);