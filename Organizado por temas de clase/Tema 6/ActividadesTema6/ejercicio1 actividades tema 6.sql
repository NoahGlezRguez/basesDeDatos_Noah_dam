create database Formación_bd 
character set utf8mb4
collate utf8mb4_spanish_ci;

use formación_bd;

create table Curso
(titulo varchar(20) primary key,
objetivos longtext not null,
programa longtext not null,
duracion int not null,
constraint ck_duracion check (duracion between 5 and 200)
);

create table empleado
(numero int primary key,
nombre varchar(20) not null,
dir varchar(40) not null,
titulacion enum('ESO', 'Bachillerato', 'FP Grado Medio', ' FP Grado Superior', 'Diplomatura', 'Ingeniería técnica', 'Grado', 'Licenciatura', 'Ingeniería', 'Máster', 'Doctorado') not null,
cargo varchar(20) not null,
constraint ck_numEmp check (numero > 0)
);

