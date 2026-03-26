/*
ACTIVIDADES ADICIONALES TEMA 11
Se entregan todos los apartados, del 1 al 9.
*/

/*
Sobre la base de datos Pedidos lleva a cabo las siguientes operaciones:

Pedido (RefPed, FecPed)
LíneaPedido (RefPed, CodArt, CantArt)
Artículo (CodArt, DesArt, PVPArt)
*/


/*
1. Crea una función que reciba el código de un artículo y que devuelva un número entero que
indique en cuántos pedidos diferentes ha sido solicitado dicho artículo.
*/



/*
2. Escribe un procedimiento que reciba dos parámetros: el código de un artículo y un importe.
Este procedimiento debe modificar el precio del artículo cuyo código se pasa como primer
parámetro, incrementándolo con el importe pasado como segundo parámetro. Muestra tras
la modificación el siguiente mensaje: “El nuevo precio del artículo con código XXXXX es
YYYY.YY euros”.
*/


/*
3. Crea un procedimiento que reciba el código de un artículo y una descripción. El
procedimiento se debe encargar de añadir dicho artículo a la tabla Articulo, asignándole
como precio el precio mayor de los artículos de la tabla Articulo. El procedimiento, tras
realizar la inserción, mostrará el mensaje: “Se ha añado un artículo con código XXXX y
precio YYYY.YY euros.”
*/


/*
4. Crea una función que reciba la referencia de un pedido y que devuelva el número total de
unidades de artículos que han sido solicitadas en dicho pedido.
Para la base de datos Empresa2, lleva a cabo las siguientes operaciones:
Centro (CodCen, CodEmpDir, NomCen, DirCen, PobCen)
Departamento (CodDep, CodEmpDir, CodDepDep, CodCen, NomDep, PreAnu, TiDir)
Empleado (CodEmp, CodDep, ExTelEmp, FecInEmp, FecNaEmp, NIFEmp, NomEmp, NumHi, SalEmp)
Hijo (CodEmp, NumHij, FecNaHi, NomHi)
HabEmp (CodHab, CodEmp, NivHab)
Habilidad (CodHab, DesHab)
*/


/*
5. Crea una función llamada ObtenerEdad que reciba el NIF de un empleado y nos devuelva
su edad. Para calcular la edad se podrá hacer uso de la función timestampdiff.
*/



/*
6. Crea un procedimiento llamado SubirSalarioDepar que reciba el nombre de un
departamento y que en función del salario medio de los empleados de ese departamento
haga lo siguiente: si el salario medio es superior a 35.000 €, debe subir el salario a todos sus
empleados un 2%; en caso contrario, les subirá el salario a todos sus empleados un 4%.
Mostrar un mensaje como el siguiente: ‘El salario de los empleados del dpto. XXXX se ha
subido un Y%’.
*/



/*
7. Crea una función llamada NumDptosDependientes que reciba el código de un departamento
y que nos indique cuántos departamentos dependen directamente de él. Ten en cuenta que
el atributo CodDepDep de la tabla Departamento indica por cada departamento cuál es el
departamento del que depende, o lo que es lo mismo, su departamento jefe.
*/


/*
Sobre la base de datos geografia realiza las siguientes operaciones:
Localidades (id_localidad, nombre, poblacion, n_provincia)

Provincias (n_provincia, nombre, superficie, id_capital, id_comunidad)

Comunidades (id_comunidad, nombre, id_capital)
*/



/*
8. Crea un procedimiento que reciba el nombre de una comunidad autónoma y que muestre el
número de provincias y el número de localidades de que consta dicha comunidad autónoma.
Si no consta ninguna provincia para dicha comunidad autónoma en la base de datos, se
deberá mostrar el mensaje: “La comunidad autónoma llamada XXXX no está en la base de
datos”.
*/



/*
9. Crea una función que reciba el nombre de una comunidad autónoma y devuelva el nombre
de la provincia con mayor superficie de la misma.
*/


