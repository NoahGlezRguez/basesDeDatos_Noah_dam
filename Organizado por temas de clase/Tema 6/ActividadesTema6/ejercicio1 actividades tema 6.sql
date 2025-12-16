create database Formacion_bd 
character set utf8mb4
collate utf8mb4_spanish_ci;

use formacion_bd;

create table Curso
(titulo varchar(20) primary key,
objetivos text not null,
programa text not null,
duracion int not null,
constraint ck_duracion check (duracion between 5 and 200)
);

create table empleado
(numero int unsigned primary key,
nombre varchar(20) not null,
dir varchar(40) not null,
titulacion enum('ESO', 'Bachillerato', 'FP grado medio', 'FP grado superior', 'Diplomatura', 'Ingeniería técnica', 'Grado', 'Licenciatura', 'Ingeniería', 'Máster', 'Doctorado') not null,
cargo varchar(20) not null,
constraint ck_numEmp check (numero > 0)
);

create table requisito
(Titcurso varchar(20),
titcursoreq varchar(20),
constraint primary key (titcurso, titcursoreq),
constraint fk_titcurso foreign key (titcurso) references curso(titulo) on update cascade on delete cascade,
constraint fk_titcursoreq foreign key (titcursoreq) references curso(titulo) on update cascade on delete restrict
);

create table oferta
(titcurso varchar(20),
fecha date not null default (current_date()),
lugar varchar(40) not null,
horario varchar(50) not null,
numempprof int unsigned not null,
constraint primary key (titcurso, fecha),
constraint fk_ofertacurso foreign key (titcurso) references curso(titulo) on update cascade on delete cascade,
constraint fk_numempprof foreign key (numempprof) references empleado(numero) on update cascade
);

create table asistencia
(titcurso varchar(20),
fecha date,
numalumno int unsigned,
calificacion int,
constraint primary key (titcurso, fecha, numalumno),
constraint fk_titcurfecha foreign key (titcurso, fecha) references oferta(titcurso, fecha) on update cascade on delete cascade,
constraint ck_calificacion check (calificacion between 0 and 10 or calificacion is null)
);