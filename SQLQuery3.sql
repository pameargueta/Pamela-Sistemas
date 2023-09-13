--Generando la base de datos nueva
CREATE DATABASE PRUEBA2
go 
--Esta linea es para saber si la base de datos se me genero correctamente
use PRUEBA2

--Ahora voy a crear las tablas que hice en el modelo grafico, primero territorio 
create table TERRITORIO(
    idterritorio int PRIMARY KEY, --asigno llave primaria al atributo, usando el tipo de dato "int" para que me acepte valores enteros 
    provincia varchar(50) not null, --voy a trabajar con el tipo de dato "varchar" porque me permite ingresar caracteres en una longitud que yo asigné 
    canton varchar(50) not null, --cuando yo pongo "not null" hago la restricción para que no se permitan la entrada de los valores nulos
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
    tamaño varchar(50) not null,
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
--Tabla de categoría
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
-- VALUES ('123456789', 'Física', 'Proveedor Prueba', 'proveedor@prueba.com', '1234567890', 1);


-----------------------------------------------------------------------------------------------------------------------------------------------

use PRUEBA2
-- Insertar datos para la provincia de San José
INSERT INTO TERRITORIO (idterritorio, provincia, canton, distrito)
VALUES 
(1, 'San José', 'Goicoechea', 'Guadalupe'),
(2, 'San José', 'Goicoechea', 'San Francisco'),
(3, 'San José', 'Montes de Oca', 'San Pedro'),
(4, 'San José', 'Montes de Oca', 'Sabanilla');

-- Insertar datos para la provincia de Limón
INSERT INTO TERRITORIO (idterritorio, provincia, canton, distrito)
VALUES 
(5, 'Limón', 'Pococí', 'Guápiles'),
(6, 'Limón', 'Pococí', 'Jiménez'),
(7, 'Limón', 'Siquirres', 'Siquirres'),
(8, 'Limón', 'Siquirres', 'Pacuarito');

-- Insertar datos para la provincia de Puntarenas
INSERT INTO TERRITORIO (idterritorio, provincia, canton, distrito)
VALUES 
(9, 'Puntarenas', 'Garabito', 'Jacó'),
(10, 'Puntarenas', 'Garabito', 'Tárcoles'),
(11, 'Puntarenas', 'Esparza', 'Espíritu Santo'),
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
(19, 'Alajuela', 'San Ramón', 'San Ramón'),
(20, 'Alajuela', 'San Ramón', 'Santiago');

-- Insertar datos para la provincia de Cartago
INSERT INTO TERRITORIO (idterritorio, provincia, canton, distrito)
VALUES 
(21, 'Cartago', 'Cartago', 'Oriental'),
(22, 'Cartago', 'Cartago', 'Occidental'),
(23, 'Cartago', 'Paraíso', 'Paraíso'),
(24, 'Cartago', 'Paraíso', 'Orosi');

-- Insertar datos para la provincia de Guanacaste
INSERT INTO TERRITORIO (idterritorio, provincia, canton, distrito)
VALUES 
(25, 'Guanacaste', 'Liberia', 'Liberia'),
(26, 'Guanacaste', 'Liberia', 'Cañas Dulces'),
(27, 'Guanacaste', 'Santa Cruz', 'Santa Cruz'),
(29, 'Guanacaste', 'Santa Cruz', 'Bolsón');


--- PROVEEDOR
DECLARE @i int; -- Declara la variable @i
SET @i = 0; -- Inicializa la variable @i con el valor 0
WHILE @i < 100
BEGIN
    -- Selecciona un idterritorio aleatorio de la tabla TERRITORIO
    DECLARE @idterritorio INT;
    SELECT TOP 1 @idterritorio = idterritorio FROM TERRITORIO ORDER BY NEWID();

    -- Genera un tipo de cédula aleatorio
    DECLARE @tipodecedula VARCHAR(50);
    SET @tipodecedula = CASE CAST((RAND() * 2) as INT)
        WHEN 0 THEN 'Física'
        ELSE 'Jurídica'
    END;

    -- Genera una cédula de proveedor aleatoria basada en el tipo de cédula
    DECLARE @cedulaproveedor VARCHAR(20);
    IF @tipodecedula = 'Física'
        SET @cedulaproveedor = CAST((RAND() * (999999999 - 100000000) + 100000000) as BIGINT); -- genera una cédula física aleatoria de 9 dígitos
    ELSE
        SET @cedulaproveedor = '3-101-' + RIGHT('00000' + CAST(CAST((RAND() * (99999 - 10000) + 10000) as INT) as VARCHAR), 5); -- genera una cédula jurídica aleatoria en el formato '3-101-#####'

    INSERT INTO PROVEEDOR (cedulaproveedor, tipodecedula, nombre, correo, telefono, idterritorio)
    VALUES (
        @cedulaproveedor,
        @tipodecedula,
        'Proveedor ' + CAST(@i as VARCHAR(3)), -- genera un nombre único para cada proveedor
        'proveedor' + CAST(@i as VARCHAR(3)) + '@prueba.com', -- genera un correo electrónico único para cada proveedor
        '8' + RIGHT('0000000' + CAST(CAST((RAND() * (9999999 - 1000000) + 1000000) as INT) as VARCHAR), 7), -- genera un número de teléfono aleatorio de 8 dígitos que comienza con 8
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
    -- Genera un consecutivo aleatorio de 6 dígitos
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

    -- Genera un tamaño aleatorio entre 6 y 20 cm
    DECLARE @tamaño INT = CAST((RAND() * (20 - 6) + 6) as INT);

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

    -- Selecciona una cédula de proveedor aleatoria de la tabla PROVEEDOR
   
    SELECT TOP 1 @cedulaproveedor = cedulaproveedor FROM PROVEEDOR ORDER BY NEWID();

    INSERT INTO PRODUCTO (consecutivo, iduniversal, nombre, tamaño, precio, color, cedulaproveedor)
    VALUES (
        @consecutivo,
        @iduniversal,
        @nombre,
        @tamaño,
        @precio,
        @color,
        @cedulaproveedor -- usa la cédula del proveedor seleccionada de la tabla PROVEEDOR
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

    -- Genera un nombre de subcategoría basado en si @i es par o impar
    SET @nombre = CASE @i % 2
        WHEN 0 THEN 'Plástico'
        ELSE 'Vidrio'
    END;

    -- Genera un valor aleatorio para idsubcategoria dentro del rango válido
    DECLARE @newIdSubcategoria INT;
    SET @newIdSubcategoria = CAST((RAND() * 1000) + 1 AS INT); -- Genera un número aleatorio entre 1 y 1000

    -- Verifica si el idsubcategoria ya existe en la tabla SUBCATEGORIA
    WHILE EXISTS (SELECT * FROM SUBCATEGORIA WHERE idsubcategoria = @newIdSubcategoria)
        SET @newIdSubcategoria = CAST((RAND() * 1000) + 1 AS INT); -- Si existe, genera un nuevo número aleatorio

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

    -- Genera un valor aleatorio para idcategoria de 4 dígitos
    DECLARE @newIdCategoria INT;
    SET @newIdCategoria = CAST((RAND() * (9999 - 1000) + 1000) AS INT); -- Genera un número aleatorio de 4 dígitos

    INSERT INTO CATEGORIA (idcategoria, nombre, idsubcategoria)
    VALUES (
        @newIdCategoria, -- usa el valor aleatorio de idcategoria
        'Categoría ' + @nombreproducto, -- genera un nombre único para cada categoría basado en el nombre del producto
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

    -- Genera un correo electrónico aleatorio para el cliente
    DECLARE @correo VARCHAR(50) = 'cliente' + CAST(@i AS VARCHAR(3)) + '@sistemas.com';

    -- Genera una cantidad de compra aleatoria entre 1 y 10
    DECLARE @cantidadcompra INT = CAST((RAND() * (10 - 1) + 1) AS INT);

    -- Genera un descuento aleatorio entre 0% y 50%
    DECLARE @descuento DECIMAL(5,2) = CAST((RAND() * (0.50 - 0.00) + 0.00) AS DECIMAL(5,2));

    -- El impuesto es fijo en un 13%
    DECLARE @impuesto DECIMAL(5,2) = 0.13;

    -- Genera una fecha aleatoria dentro de un rango específico
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
     -- Genera un tipo de cédula aleatorio
    DECLARE @tipodecedulaC VARCHAR(50);
    SET @tipodecedulaC = CASE CAST((RAND() * 2) as INT)
        WHEN 0 THEN 'Física'
        ELSE 'Jurídica'
    END;
    -- Genera una cédula de cliente aleatoria basada en el tipo de cédula
    DECLARE @cedula VARCHAR(20);
    IF @tipodecedulaC = 'Física'
        SET @cedula = CAST((RAND() * (999999999 - 100000000) + 100000000) AS BIGINT); -- genera una cédula física aleatoria de 9 dígitos
    ELSE
        SET @cedula = '3-101-' + RIGHT('00000' + CAST(CAST((RAND() * (99999 - 10000) + 10000) as INT) as VARCHAR), 5); -- genera una cédula jurídica aleatoria en el formato '3-101-#####'


    -- Verifica si la cédula ya existe en la tabla CLIENTE
    WHILE EXISTS (SELECT * FROM CLIENTE WHERE cedula = @cedula)
        SET @cedula = CAST((RAND() * (999999999 - 100000000) + 100000000) AS BIGINT); -- Si existe, genera un nuevo número aleatorio

    SELECT TOP 1 @nombreCLIENTE = nombre FROM FACTURA ORDER BY NEWID();

    -- Genera un correo electrónico aleatorio para el cliente
    DECLARE @correoC VARCHAR(50) = @nombreCLIENTE + CAST(@i AS VARCHAR(3)) + '@cliente.com';

    -- Genera una dirección ficticia para el cliente
    DECLARE @direccion VARCHAR(50) = 'Dirección ' + CAST(@i AS VARCHAR(3));

    -- Selecciona un número de factura aleatorio de la tabla FACTURA
    DECLARE @numerofactura INT;
    SELECT TOP 1 @numerofactura = numerofactura FROM FACTURA ORDER BY NEWID();

    INSERT INTO CLIENTE (cedula, tipodecedula, nombre, correo, direccion, numerofactura)
    VALUES (
        @cedula,
        'Física', -- Solo se usará el tipo de cédula 'Física'
        @nombreCLIENTE,
        @correoC,
        @direccion,
        @numerofactura -- usa el número de factura seleccionado de la tabla FACTURA
    );
    
    SET @i = @i + 1;
END;

SET @i = NULL; -- Reinicia la variable @i


-----------------------------------------------------------------------------------------------------------------------------------------------------------
--¿Cuánto dinero se ha vendido en total por mes?
SELECT MONTH(fecha) as Mes, SUM(cantidadcompra * precio) as TotalVendido
FROM FACTURA F
JOIN PRODUCTO P ON F.consecutivo = P.consecutivo
GROUP BY MONTH(fecha);


--¿CuántoS productos se ha vendido en total por mes?
SELECT MONTH(fecha) as Mes, SUM(cantidadcompra) as TotalVendido
FROM FACTURA
GROUP BY MONTH(fecha);


---¿Cuántos productos diferentes tiene la empresa?
SELECT COUNT(DISTINCT nombre) as TotalProductosDiferentes
FROM PRODUCTO;


---¿Cuáles son los proveedores a los que más unidades de productos se les compra?
SELECT P.cedulaproveedor, SUM(F.cantidadcompra) as TotalComprado
FROM FACTURA F
JOIN PRODUCTO P ON F.consecutivo = P.consecutivo
GROUP BY P.cedulaproveedor
ORDER BY TotalComprado DESC;


---¿Cuáles son los clientes a los que más unidades de productos se les vende?
SELECT C.nombre, SUM(F.cantidadcompra) as TotalVendido
FROM FACTURA F
JOIN CLIENTE C ON F.numerofactura = C.numerofactura
GROUP BY C.nombre
ORDER BY TotalVendido DESC;


---¿Qué categoría de producto vende menos?
SELECT C.nombre, SUM(F.cantidadcompra) as TotalVendido
FROM CATEGORIA C
JOIN SUBCATEGORIA S ON C.idsubcategoria = S.idsubcategoria
JOIN PRODUCTO P ON S.consecutivo = P.consecutivo
JOIN FACTURA F ON P.consecutivo = F.consecutivo
GROUP BY C.nombre
ORDER BY TotalVendido ASC;


---¿Qué SUBCATEGORIA de producto vende menos?
SELECT S.nombre, SUM(F.cantidadcompra) as TotalVendido
FROM SUBCATEGORIA S
JOIN PRODUCTO P ON S.consecutivo = P.consecutivo
JOIN FACTURA F ON P.consecutivo = F.consecutivo
GROUP BY S.nombre
ORDER BY TotalVendido ASC;

