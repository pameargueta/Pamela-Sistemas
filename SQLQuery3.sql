--Generando la base de datos nueva
CREATE DATABASE PRUEBA2
go 
--Esta linea es para saber si la base de datos se me genero correctamente
use PRUEBA2

--Ahora voy a crear las tablas que hice en el modelo grafico, primero territorio 
create table TERRITORIO(
    idterritorio int PRIMARY KEY, --asigno llave primaria al atributo, usando el tipo de dato "int" para que me acepte valores enteros 
    provincia varchar(50) not null, --voy a trabajar con el tipo de dato "varchar" porque me permite ingresar caracteres en una longitud que yo asign� 
    canton varchar(50) not null, --cuando yo pongo "not null" hago la restricci�n para que no se permitan la entrada de los valores nulos
    distrito varchar(50) not null
);
-- Tabla PROVEEDOR
create table PROVEEDOR(
    cedulaproveedor varchar(20) PRIMARY KEY, --asigno llave primaria al atributo 
    tipodecedula varchar(50) not null,
    nombre varchar(80) not null,
    correo varchar(50) not null,
    telefono varchar(50) not null,
    idterritorio int, --llave foranea
    constraint for_idterritorio foreign key (idterritorio) references TERRITORIO(idterritorio) 
);
-- Tabla PRODUCTO
create table PRODUCTO(
    consecutivo int IDENTITY(1,1) PRIMARY KEY, --asigno llave primaria al atributo 
    iduniversal varchar(50) not null,
    nombre varchar(80) not null,
    tama�o varchar(50) not null,
    precio decimal(10,2) not null, -- cambio a decimal
    color varchar(50) not null,
    cedulaproveedor varchar(20), --llave foranea y cambio a varchar(20)
    constraint for_cedulaproveedor foreign key (cedulaproveedor) references PROVEEDOR(cedulaproveedor) 
);
--Tabla de subcategoria
create table SUBCATEGORIA(
    idsubcategoria int PRIMARY KEY, --asigno llave primaria al atributo 
    nombre varchar(80) not null,
    consecutivo int, --llave foranea
    constraint for_consecutivo foreign key (consecutivo) references PRODUCTO(consecutivo) 
);
--Tabla de categor�a
create table CATEGORIA(
    idcategoria int IDENTITY(1,1) PRIMARY KEY, --asigno llave primaria al atributo  
    nombre varchar(80) not null,
    idsubcategoria int, --llave foranea
    constraint for_idsubcategoria foreign key (idsubcategoria) references SUBCATEGORIA(idsubcategoria) 
);
--Tabla de factura
create table FACTURA(
    numerofactura int IDENTITY(1,1) PRIMARY KEY, --asigno llave primaria al atributo 
    nombre varchar(80) not null,
    correo varchar(50) not null, 
    cantidadcompra int not null, -- cambio a int
    descuento decimal(5,2) not null, -- cambio a decimal
    impuesto decimal(5,2) not null, -- cambio a decimal
    fecha date not null, -- nueva columna de fecha
    consecutivo int, --llave foranea
    constraint for_consecutivo_factura foreign key (consecutivo) references PRODUCTO(consecutivo)
);
--Tabla de cliente
create table CLIENTE(
    cedula varchar(20) PRIMARY KEY, --asigno llave primaria al atributo 
    tipodecedula varchar(50) not null,
    nombre varchar(80) not null, 
    correo varchar(50) not null,
    direccion varchar(50) not null,
    numerofactura int, --llave foranea
    constraint for_numerofactura foreign key (numerofactura) references FACTURA(numerofactura)
);

----INSERTAR LOS DATOS MANUALEMENTE
-- INSERT INTO PROVEEDOR (cedulaproveedor, tipodecedula, nombre, correo, telefono, idterritorio)
-- VALUES ('123456789', 'F�sica', 'Proveedor Prueba', 'proveedor@prueba.com', '1234567890', 1);


-----------------------------------------------------------------------------------------------------------------------------------------------

use PRUEBA2
-- Insertar datos para la provincia de San Jos�
INSERT INTO TERRITORIO (idterritorio, provincia, canton, distrito)
VALUES 
(1, 'San Jos�', 'Goicoechea', 'Guadalupe'),
(2, 'San Jos�', 'Goicoechea', 'San Francisco'),
(3, 'San Jos�', 'Montes de Oca', 'San Pedro'),
(4, 'San Jos�', 'Montes de Oca', 'Sabanilla');

-- Insertar datos para la provincia de Lim�n
INSERT INTO TERRITORIO (idterritorio, provincia, canton, distrito)
VALUES 
(5, 'Lim�n', 'Pococ�', 'Gu�piles'),
(6, 'Lim�n', 'Pococ�', 'Jim�nez'),
(7, 'Lim�n', 'Siquirres', 'Siquirres'),
(8, 'Lim�n', 'Siquirres', 'Pacuarito');

-- Insertar datos para la provincia de Puntarenas
INSERT INTO TERRITORIO (idterritorio, provincia, canton, distrito)
VALUES 
(9, 'Puntarenas', 'Garabito', 'Jac�'),
(10, 'Puntarenas', 'Garabito', 'T�rcoles'),
(11, 'Puntarenas', 'Esparza', 'Esp�ritu Santo'),
(12, 'Puntarenas', 'Esparza', 'San Juan Grande');

-- Insertar datos para la provincia de Heredia
INSERT INTO TERRITORIO (idterritorio, provincia, canton, distrito)
VALUES 
(13, 'Heredia', 'Barva', 'Barva'),
(14, 'Heredia', 'Barva', 'San Roque'),
(15, 'Heredia', 'Santo Domingo', 'Santo Domingo'),
(16, 'Heredia', 'Santo Domingo', 'Paracito');

-- Insertar datos para la provincia de Alajuela
INSERT INTO TERRITORIO (idterritorio, provincia, canton, distrito)
VALUES 
(17, 'Alajuela', 'Alajuela', 'Alajuela'),
(18, 'Alajuela', 'Alajuela', 'Carrizal'),
(19, 'Alajuela', 'San Ram�n', 'San Ram�n'),
(20, 'Alajuela', 'San Ram�n', 'Santiago');

-- Insertar datos para la provincia de Cartago
INSERT INTO TERRITORIO (idterritorio, provincia, canton, distrito)
VALUES 
(21, 'Cartago', 'Cartago', 'Oriental'),
(22, 'Cartago', 'Cartago', 'Occidental'),
(23, 'Cartago', 'Para�so', 'Para�so'),
(24, 'Cartago', 'Para�so', 'Orosi');

-- Insertar datos para la provincia de Guanacaste
INSERT INTO TERRITORIO (idterritorio, provincia, canton, distrito)
VALUES 
(25, 'Guanacaste', 'Liberia', 'Liberia'),
(26, 'Guanacaste', 'Liberia', 'Ca�as Dulces'),
(27, 'Guanacaste', 'Santa Cruz', 'Santa Cruz'),
(29, 'Guanacaste', 'Santa Cruz', 'Bols�n');


--- PROVEEDOR
DECLARE @i int; -- Declara la variable @i
SET @i = 0; -- Inicializa la variable @i con el valor 0
WHILE @i < 100
BEGIN
    -- Selecciona un idterritorio aleatorio de la tabla TERRITORIO
    DECLARE @idterritorio INT;
    SELECT TOP 1 @idterritorio = idterritorio FROM TERRITORIO ORDER BY NEWID();

    -- Genera un tipo de c�dula aleatorio
    DECLARE @tipodecedula VARCHAR(50);
    SET @tipodecedula = CASE CAST((RAND() * 2) as INT)
        WHEN 0 THEN 'F�sica'
        ELSE 'Jur�dica'
    END;

    -- Genera una c�dula de proveedor aleatoria basada en el tipo de c�dula
    DECLARE @cedulaproveedor VARCHAR(20);
    IF @tipodecedula = 'F�sica'
        SET @cedulaproveedor = CAST((RAND() * (999999999 - 100000000) + 100000000) as BIGINT); -- genera una c�dula f�sica aleatoria de 9 d�gitos
    ELSE
        SET @cedulaproveedor = '3-101-' + RIGHT('00000' + CAST(CAST((RAND() * (99999 - 10000) + 10000) as INT) as VARCHAR), 5); -- genera una c�dula jur�dica aleatoria en el formato '3-101-#####'

    INSERT INTO PROVEEDOR (cedulaproveedor, tipodecedula, nombre, correo, telefono, idterritorio)
    VALUES (
        @cedulaproveedor,
        @tipodecedula,
        'Proveedor ' + CAST(@i as VARCHAR(3)), -- genera un nombre �nico para cada proveedor
        'proveedor' + CAST(@i as VARCHAR(3)) + '@prueba.com', -- genera un correo electr�nico �nico para cada proveedor
        '8' + RIGHT('0000000' + CAST(CAST((RAND() * (9999999 - 1000000) + 1000000) as INT) as VARCHAR), 7), -- genera un n�mero de tel�fono aleatorio de 8 d�gitos que comienza con 8
        @idterritorio -- usa el idterritorio seleccionado de la tabla TERRITORIO
    );
    SET @i = @i + 1;
END;
SET @i = NULL; -- Reinicia la variable @i

-------- PRODUCTO
SET IDENTITY_INSERT PRODUCTO ON;
SET @i = 0;
WHILE @i < 100
BEGIN
    -- Genera un consecutivo aleatorio de 6 d�gitos
    DECLARE @consecutivo INT = CAST((RAND() * (999999 - 100000) + 100000) as INT);

    -- Genera un iduniversal basado en el consecutivo
    DECLARE @iduniversal VARCHAR(50) = LEFT(CAST(@consecutivo as VARCHAR(6)), 4);

    -- Selecciona un nombre de producto aleatorio
    DECLARE @nombre VARCHAR(50);
    SET @nombre = CASE CAST((RAND() * 3) as INT)
        WHEN 0 THEN 'Vaso'
        WHEN 1 THEN 'Copa'
        ELSE 'Taza'
    END;

    -- Genera un tama�o aleatorio entre 6 y 20 cm
    DECLARE @tama�o INT = CAST((RAND() * (20 - 6) + 6) as INT);

    -- Genera un precio aleatorio entre $5 y $15
    DECLARE @precio DECIMAL(10,2) = CAST((RAND() * (15 - 5) + 5) as DECIMAL(10,2));

    -- Genera un color aleatorio
    DECLARE @color VARCHAR(50);
    SET @color = CASE CAST((RAND() * 5) as INT)
        WHEN 0 THEN 'Rojo'
        WHEN 1 THEN 'Azul'
        WHEN 2 THEN 'Verde'
        WHEN 3 THEN 'Amarillo'
        ELSE 'Negro'
    END;

    -- Selecciona una c�dula de proveedor aleatoria de la tabla PROVEEDOR
   
    SELECT TOP 1 @cedulaproveedor = cedulaproveedor FROM PROVEEDOR ORDER BY NEWID();

    INSERT INTO PRODUCTO (consecutivo, iduniversal, nombre, tama�o, precio, color, cedulaproveedor)
    VALUES (
        @consecutivo,
        @iduniversal,
        @nombre,
        @tama�o,
        @precio,
        @color,
        @cedulaproveedor -- usa la c�dula del proveedor seleccionada de la tabla PROVEEDOR
    );
    
    SET @i = @i + 1;
END;
SET IDENTITY_INSERT PRODUCTO OFF;
SET @i = NULL; -- Reinicia la variable @i



-- Insertar datos para la tabla SUBCATEGORIA

SET @i = 0;
WHILE @i < 100
BEGIN
    -- Selecciona un consecutivo aleatorio de la tabla PRODUCTO

    SELECT TOP 1 @consecutivo = consecutivo FROM PRODUCTO ORDER BY NEWID();

    -- Genera un nombre de subcategor�a basado en si @i es par o impar
    SET @nombre = CASE @i % 2
        WHEN 0 THEN 'Pl�stico'
        ELSE 'Vidrio'
    END;

    -- Genera un valor aleatorio para idsubcategoria dentro del rango v�lido
    DECLARE @newIdSubcategoria INT;
    SET @newIdSubcategoria = CAST((RAND() * 1000) + 1 AS INT); -- Genera un n�mero aleatorio entre 1 y 1000

    -- Verifica si el idsubcategoria ya existe en la tabla SUBCATEGORIA
    WHILE EXISTS (SELECT * FROM SUBCATEGORIA WHERE idsubcategoria = @newIdSubcategoria)
        SET @newIdSubcategoria = CAST((RAND() * 1000) + 1 AS INT); -- Si existe, genera un nuevo n�mero aleatorio

    INSERT INTO SUBCATEGORIA (idsubcategoria, nombre, consecutivo)
    VALUES (
        @newIdSubcategoria, -- usa el valor aleatorio de idsubcategoria
        @nombre,
        @consecutivo -- usa el consecutivo seleccionado de la tabla PRODUCTO
    );
    
    SET @i = @i + 1;
END;

SET @i = NULL; -- Reinicia la variable @i


-- Insertar datos para la tabla CATEGORIA
SET IDENTITY_INSERT CATEGORIA ON; -- Activa IDENTITY_INSERT para la tabla CATEGORIA

SET @i = 0;
WHILE @i < 100
BEGIN
    -- Selecciona un idsubcategoria aleatorio de la tabla SUBCATEGORIA
    DECLARE @idsubcategoria INT;
    SELECT TOP 1 @idsubcategoria = idsubcategoria FROM SUBCATEGORIA ORDER BY NEWID();

    -- Selecciona un nombre de producto aleatorio de la tabla PRODUCTO
    DECLARE @nombreproducto VARCHAR(50);
    SELECT TOP 1 @nombreproducto = nombre FROM PRODUCTO ORDER BY NEWID();

    -- Genera un valor aleatorio para idcategoria de 4 d�gitos
    DECLARE @newIdCategoria INT;
    SET @newIdCategoria = CAST((RAND() * (9999 - 1000) + 1000) AS INT); -- Genera un n�mero aleatorio de 4 d�gitos

    INSERT INTO CATEGORIA (idcategoria, nombre, idsubcategoria)
    VALUES (
        @newIdCategoria, -- usa el valor aleatorio de idcategoria
        'Categor�a ' + @nombreproducto, -- genera un nombre �nico para cada categor�a basado en el nombre del producto
        @idsubcategoria -- usa el idsubcategoria seleccionado de la tabla SUBCATEGORIA
    );
    
    SET @i = @i + 1;
END;

SET IDENTITY_INSERT CATEGORIA OFF; -- Desactiva IDENTITY_INSERT para la tabla CATEGORIA

SET @i = NULL; -- Reinicia la variable @i

-------------------------FACTURA
SET @i = 0;
WHILE @i < 100
BEGIN
    -- Genera un nombre aleatorio para el cliente
    DECLARE @nombreCLIENTE VARCHAR(50) = 'Cliente ' + CAST(@i AS VARCHAR(3));

    -- Genera un correo electr�nico aleatorio para el cliente
    DECLARE @correo VARCHAR(50) = 'cliente' + CAST(@i AS VARCHAR(3)) + '@sistemas.com';

    -- Genera una cantidad de compra aleatoria entre 1 y 10
    DECLARE @cantidadcompra INT = CAST((RAND() * (10 - 1) + 1) AS INT);

    -- Genera un descuento aleatorio entre 0% y 50%
    DECLARE @descuento DECIMAL(5,2) = CAST((RAND() * (0.50 - 0.00) + 0.00) AS DECIMAL(5,2));

    -- El impuesto es fijo en un 13%
    DECLARE @impuesto DECIMAL(5,2) = 0.13;

    -- Genera una fecha aleatoria dentro de un rango espec�fico
    DECLARE @fecha DATE = DATEADD(DAY, CAST((RAND() * (365 - 0) + 0) AS INT), '2023-01-01');

    -- Selecciona un consecutivo aleatorio de la tabla PRODUCTO
    SELECT TOP 1 @consecutivo = consecutivo FROM PRODUCTO ORDER BY NEWID();

    INSERT INTO FACTURA (nombre, correo, cantidadcompra, descuento, impuesto, fecha, consecutivo)
    VALUES (
        @nombreCLIENTE,
        @correo,
        @cantidadcompra,
        @descuento,
        @impuesto,
        @fecha,
        @consecutivo
    );
    
    SET @i = @i + 1;
END;

SET @i = NULL; -- Reinicia la variable @i


----------------------CLIENTE
SET @i = 0;
WHILE @i < 100
BEGIN
     -- Genera un tipo de c�dula aleatorio
    DECLARE @tipodecedulaC VARCHAR(50);
    SET @tipodecedulaC = CASE CAST((RAND() * 2) as INT)
        WHEN 0 THEN 'F�sica'
        ELSE 'Jur�dica'
    END;
    -- Genera una c�dula de cliente aleatoria basada en el tipo de c�dula
    DECLARE @cedula VARCHAR(20);
    IF @tipodecedulaC = 'F�sica'
        SET @cedula = CAST((RAND() * (999999999 - 100000000) + 100000000) AS BIGINT); -- genera una c�dula f�sica aleatoria de 9 d�gitos
    ELSE
        SET @cedula = '3-101-' + RIGHT('00000' + CAST(CAST((RAND() * (99999 - 10000) + 10000) as INT) as VARCHAR), 5); -- genera una c�dula jur�dica aleatoria en el formato '3-101-#####'


    -- Verifica si la c�dula ya existe en la tabla CLIENTE
    WHILE EXISTS (SELECT * FROM CLIENTE WHERE cedula = @cedula)
        SET @cedula = CAST((RAND() * (999999999 - 100000000) + 100000000) AS BIGINT); -- Si existe, genera un nuevo n�mero aleatorio

    SELECT TOP 1 @nombreCLIENTE = nombre FROM FACTURA ORDER BY NEWID();

    -- Genera un correo electr�nico aleatorio para el cliente
    DECLARE @correoC VARCHAR(50) = @nombreCLIENTE + CAST(@i AS VARCHAR(3)) + '@cliente.com';

    -- Genera una direcci�n ficticia para el cliente
    DECLARE @direccion VARCHAR(50) = 'Direcci�n ' + CAST(@i AS VARCHAR(3));

    -- Selecciona un n�mero de factura aleatorio de la tabla FACTURA
    DECLARE @numerofactura INT;
    SELECT TOP 1 @numerofactura = numerofactura FROM FACTURA ORDER BY NEWID();

    INSERT INTO CLIENTE (cedula, tipodecedula, nombre, correo, direccion, numerofactura)
    VALUES (
        @cedula,
        'F�sica', -- Solo se usar� el tipo de c�dula 'F�sica'
        @nombreCLIENTE,
        @correoC,
        @direccion,
        @numerofactura -- usa el n�mero de factura seleccionado de la tabla FACTURA
    );
    
    SET @i = @i + 1;
END;

SET @i = NULL; -- Reinicia la variable @i


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--�Cu�nto dinero se ha vendido en total por mes?
SELECT MONTH(fecha) as Mes, SUM(cantidadcompra * precio) as TotalVendido
FROM FACTURA F
JOIN PRODUCTO P ON F.consecutivo = P.consecutivo
GROUP BY MONTH(fecha);


--�Cu�ntoS productos se ha vendido en total por mes?
SELECT MONTH(fecha) as Mes, SUM(cantidadcompra) as TotalVendido
FROM FACTURA
GROUP BY MONTH(fecha);


---�Cu�ntos productos diferentes tiene la empresa?
SELECT COUNT(DISTINCT nombre) as TotalProductosDiferentes
FROM PRODUCTO;


---�Cu�les son los proveedores a los que m�s unidades de productos se les compra?
SELECT P.cedulaproveedor, SUM(F.cantidadcompra) as TotalComprado
FROM FACTURA F
JOIN PRODUCTO P ON F.consecutivo = P.consecutivo
GROUP BY P.cedulaproveedor
ORDER BY TotalComprado DESC;


---�Cu�les son los clientes a los que m�s unidades de productos se les vende?
SELECT C.nombre, SUM(F.cantidadcompra) as TotalVendido
FROM FACTURA F
JOIN CLIENTE C ON F.numerofactura = C.numerofactura
GROUP BY C.nombre
ORDER BY TotalVendido DESC;


---�Qu� categor�a de producto vende menos?
SELECT C.nombre, SUM(F.cantidadcompra) as TotalVendido
FROM CATEGORIA C
JOIN SUBCATEGORIA S ON C.idsubcategoria = S.idsubcategoria
JOIN PRODUCTO P ON S.consecutivo = P.consecutivo
JOIN FACTURA F ON P.consecutivo = F.consecutivo
GROUP BY C.nombre
ORDER BY TotalVendido ASC;


---�Qu� SUBCATEGORIA de producto vende menos?
SELECT S.nombre, SUM(F.cantidadcompra) as TotalVendido
FROM SUBCATEGORIA S
JOIN PRODUCTO P ON S.consecutivo = P.consecutivo
JOIN FACTURA F ON P.consecutivo = F.consecutivo
GROUP BY S.nombre
ORDER BY TotalVendido ASC;

