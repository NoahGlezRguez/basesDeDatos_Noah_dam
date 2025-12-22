create database empresa_dam
collate utf8mb4_spanish_ci;

use empresa_dam;

create table Departamento
(NumDep int unsigned primary key,
NomDep varchar(40) unique not null,
Localidad varchar(40) not null,
constraint cK_NumDep check (NumDep between 1 and 100));

create table Empleado
(NumEmp int unsigned primary key,
NomEmp varchar(40) not null,
Puesto enum ('Gerente', 'Director', 'Empleado', 'Vendedor') not null,
NumEmpJefe int unsigned,
FecIngreso date not null,
Salario numeric(6,2) not null ,
Comision numeric(6,2) ,
NumDep int unsigned default 1 not null,
constraint ck_salario check (salario >= 1100),
constraint ck_comision check (comision >= 0),
constraint fk_Jefe_Empleado foreign key(NumEmpJefe) references Empleado(NumEmp)on update cascade,
constraint fk_NumDep_Empleado foreign key(NumDep) references Departamento(NumDep) on update cascade,
constraint ck_comision_salario check (Comision <= 1.5 * Salario));

insert into Departamento values (1, 'Compras', 'Madrid');
insert into Departamento values (2, 'Recursos humanos', 'Barcelona');
insert into Departamento values (3, 'Ventas', 'Bilbao');

insert into Empleado values (1, 'Alberto Rey Ruiz', 'Gerente', NULL, '2014-01-02', 5500, 0, 1);
insert into Empleado values (2, 'Luis Grande Gil', 'Director', 1, '2014-01-02', 3200, 0, 1);
insert into Empleado values (3, 'Ana Ruiz Almeida', 'Empleado', 2, '2014-01-02', 1525, 0, 1);
insert into Empleado values (4, 'Albert Rius García', 'Director', 1, '2016-02-02', 3100, 0, 2);
insert into Empleado values (5, 'Georgina Ruiz Plá', 'Empleado', 4, '2016-02-02', 1420, 0, 2);
insert into Empleado values (6, 'Laura Díaz Folgado', 'Empleado', 4, '2016-12-12', 1320, 0, 2);
insert into Empleado values (7, 'Esther Gómez Bilbao', 'Director', 1, '2018-01-02', 2800, 0, 3);
insert into Empleado values (8, 'Vanessa Amor López', 'Vendedor', 7, '2018-01-02', 1600, 250, 3);
insert into Empleado values (9, 'Ángel Jiménez Sánchez', 'Empleado', 8, '2018-01-02', 1450, 0, 3);
insert into Empleado values (10, 'Sandra Rojo Núñez', 'Vendedor', 8, '2018-01-02', 1900, 400, 3);
insert into Empleado values (11, 'María Galiano Lastra', 'Vendedor', 10, '2020-01-15', 1300, 900, 3);
insert into Empleado values (12, 'Pedro Gómez Sanz', 'Vendedor', 10, '2022-05-05', 1250, 300, 3);