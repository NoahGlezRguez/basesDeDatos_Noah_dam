create database empre_dam collate utf8mb4_spanish_ci;
use empre_dam;

CREATE TABLE Dep
(numdep int unsigned PRIMARY KEY,
nomdep varchar(30) NOT NULL,
numemple int unsigned NOT NULL DEFAULT 0);

CREATE TABLE Emp
(numemp int unsigned PRIMARY KEY,
nomemp varchar(40) NOT NULL,
salemp numeric(6,2) NOT NULL CONSTRAINT CH_salemp CHECK (salemp > 1100),
numdep int unsigned NOT NULL,
constraint FK_Dep_Emp FOREIGN KEY(numdep) REFERENCES Dep(numdep) ON UPDATE CASCADE);

CREATE TRIGGER NuevoEmpleado
AFTER INSERT ON Emp FOR EACH ROW
UPDATE Dep SET numemple = numemple + 1 WHERE numdep = NEW.numdep;

INSERT INTO Dep (numdep,nomdep)
VALUES (1, 'Compras'), (2, 'Ventas');
INSERT into Emp VALUES (1, 'Jose Gil', 1250.45, 1);

SELECT * from DEP;

CREATE TRIGGER BajaEmpleado
AFTER DELETE ON Emp FOR EACH ROW
UPDATE Dep SET numemple = numemple - 1 WHERE numdep = OLD.numdep;

DELETE FROM Emp WHERE numemp=1;

SELECT * from DEP;