CREATE DATABASE AlmacenDB

USE AlmacenDB

-- ========================================
-- TABLAS DE LA BASE DE DATOS
-- ========================================

-- Almacén (Nro, Responsable) 
-- Artículo (CodArt, descripción, Precio) 
-- Material (CodMat, Descripción) 
-- Proveedor (CodProv, Nombre, Domicilio, Ciudad) 
-- Tiene (Nro, CodArt) 
-- Compuesto_por (CodArt, CodMat) 
-- Provisto_por (CodMat, CodProv) 

CREATE TABLE Almacen(
	Nro int not null,
	Responsable varchar(100) not null,

	CONSTRAINT PK_Nro_Almacen PRIMARY KEY(Nro)
);

ALTER TABLE Almacen
ALTER COLUMN Nro int not null

CREATE TABLE Articulo(
	CodArt char(1) not null,
	Descripcion varchar(100) not null,
	Precio decimal(20, 2) not null

	CONSTRAINT PK_CodArt_Articulo PRIMARY KEY(CodArt)
);

CREATE TABLE Material(
	CodMat varchar(6) not null,
	Descripcion varchar(100) not null,

	CONSTRAINT PK_CodMat_Material PRIMARY KEY(CodMat)
);

CREATE TABLE Proveedor(
	CodProv varchar(6) not null,
	Nombre varchar(50) not null,
	Domicilio varchar(200) not null,
	Ciudad varchar(100) not null,

	CONSTRAINT PK_CodProv_Proveedor PRIMARY KEY(CodProv)
);


CREATE TABLE Tiene(
	Nro int not null,
	CodArt char(1) not null,

	CONSTRAINT FK_Nro_Almacen_Tiene FOREIGN KEY(Nro) REFERENCES Almacen(Nro),
	CONSTRAINT FK_CodArt_Articulo_Tiene FOREIGN KEY(CodArt) REFERENCES Articulo(CodArt),

	CONSTRAINT PK_Nro_CodArt_Tiene PRIMARY KEY(Nro, CodArt)
);

CREATE TABLE Compuesto_por(
	CodArt char(1) not null,
	CodMat	varchar(6) not null,

	CONSTRAINT FK_CodArt_Articulo_Cp FOREIGN KEY(CodArt) REFERENCES Articulo(CodArt),
	CONSTRAINT FK_CodMat_Material_Cp FOREIGN KEY(CodMat) REFERENCES Material(CodMat),

	CONSTRAINT PK_CodMat_CodArt_Cp PRIMARY KEY(CodArt, CodMat)
);

CREATE TABLE Provisto_por(
	CodMat varchar(6) not null,
	CodProv varchar(6) not null,

	CONSTRAINT FK_CodMat_Material_Pp FOREIGN KEY(CodMat) REFERENCES Material(CodMat),
	CONSTRAINT FK_CodProv_Proveedor_Pp FOREIGN KEY(CodProv) REFERENCES Proveedor(CodProv),


	CONSTRAINT PK_CodMat_CodProv_Pp PRIMARY KEY(CodProv, CodMat)
);
-- ========================================
-- DATASET PARA SISTEMA DE ALMACÉN
-- ========================================

-- TABLA: Almacén
INSERT INTO Almacen (Nro, Responsable) VALUES
(1, 'Juan Pérez'),
(2, 'María González'),
(3, 'Carlos Rodríguez'),
(4, 'Ana Martínez');

-- TABLA: Material
INSERT INTO Material (CodMat, Descripcion) VALUES
('MAT001', 'Cemento Portland x 50kg'),
('MAT002', 'Arena fina x m3'),
('MAT003', 'Ladrillos comunes x 1000'),
('MAT004', 'Hierro 8mm x 12m'),
('MAT005', 'Pintura látex blanca x 20L'),
('MAT006', 'Cal hidratada x 25kg'),
('MAT007', 'Chapa zinc lisa 0.25mm'),
('MAT008', 'Caños PVC 110mm x 6m');

-- TABLA: Artículo
INSERT INTO Articulo (CodArt, Descripcion, Precio) VALUES
('A', 'Martillo carpintero 25oz', 1850.00),
('B', 'Destornillador Phillips 6"', 450.00),
('C', 'Llave francesa 12"', 2300.00),
('D', 'Sierra circular 7 1/4"', 15500.00),
('E', 'Taladro percutor 1/2"', 12800.00),
('F', 'Nivel torpedo 9"', 980.00),
('G', 'Cinta métrica 5m', 650.00),
('H', 'Pala punta cuadrada', 3200.00),
('I', 'Carretilla reforzada 60L', 8900.00),
('J', 'Escalera tijera aluminio 6 peldaños', 18500.00);

-- TABLA: Proveedor
INSERT INTO Proveedor (CodProv, Nombre, Domicilio, Ciudad) VALUES
('PROV1', 'Materiales del Sur SA', 'Av. Libertador 2345', 'Buenos Aires'),
('PROV2', 'Ferreterías Unidas SRL', 'San Martín 567', 'Rosario'),
('PROV3', 'Construcciones del Norte', 'Belgrano 890', 'Córdoba'),
('PROV4', 'Hierros y Aceros SA', 'Ruta 9 Km 45', 'San Miguel de Tucumán'),
('PROV5', 'Pinturas Premium', 'Sarmiento 1234', 'Mendoza');

-- TABLA: Tiene (Almacén - Artículo)
INSERT INTO Tiene (Nro, CodArt) VALUES
(1, 'A'),
(1, 'B'),
(1, 'C'),
(1, 'G'),
(2, 'D'),
(2, 'E'),
(2, 'F'),
(2, 'J'),
(3, 'A'),
(3, 'H'),
(3, 'I'),
(4, 'B'),
(4, 'C'),
(4, 'G');

-- TABLA: Compuesto_por (Artículo - Material)
INSERT INTO Compuesto_por (CodArt, CodMat) VALUES
('B', 'MAT001'), -- Cemento Portland
('A', 'MAT004'),  -- Martillo usa hierro
('C', 'MAT004'),  -- Llave francesa usa hierro
('H', 'MAT004'),  -- Pala usa hierro
('I', 'MAT004'),  -- Carretilla usa hierro
('I', 'MAT007'),  -- Carretilla usa chapa
('J', 'MAT004');  -- Escalera usa hierro

-- TABLA: Provisto_por (Material - Proveedor)
INSERT INTO Provisto_por (CodMat, CodProv) VALUES
('MAT001', 'PROV1'),
('MAT001', 'PROV3'),
('MAT002', 'PROV1'),
('MAT003', 'PROV1'),
('MAT003', 'PROV3'),
('MAT004', 'PROV4'),
('MAT005', 'PROV5'),
('MAT006', 'PROV1'),
('MAT007', 'PROV4'),
('MAT008', 'PROV2'),
('MAT008', 'PROV3');


-- ========================================
-- EJERCICIOS PARA RESOLVER
-- ========================================

-- 1. Listar los nombres de los proveedores de la ciudad de La Plata. 
SELECT Nombre FROM Proveedor pv WHERE pv.Ciudad = 'La Plata'

-- 2. Listar los números de artículos cuyo precio sea inferior a $8900. 
SELECT COUNT(*) as 'Cantidad de Articulos' FROM Articulo art WHERE art.Precio < 8900

-- 3. Listar los responsables de los almacenes. 
SELECT Responsable FROM Almacen alm;

-- 4. Listar los códigos de los materiales que provea el proveedor 5 y no los provea el proveedor 1.
SELECT CodMat FROM Provisto_por pp
WHERE CodProv = 'PROV5'
AND CodMat NOT IN (
	SELECT CodMat FROM Provisto_por
	WHERE CodProv = 'PROV1'
)

-- 5. Listar los números de almacenes que almacenan el artículo A. 
SELECT DISTINCT tn.Nro FROM Tiene tn
WHERE tn.CodArt = 'A'

-- 6. Listar los proveedores de Rosario que se llamen Ferreterías Unidas SRL. 
SELECT pvr.Nombre FROM Proveedor pvr
WHERE pvr.Ciudad = 'Rosario' AND pvr.Nombre LIKE ('Ferreterías Unidas SRL')

-- 7. Listar los almacenes que contienen los artículos A y los artículos B (ambos). 
SELECT tn.Nro as Almacen FROM Tiene tn
WHERE tn.CodArt = 'A'
INTERSECT
SELECT tn.Nro as Almacen FROM Tiene tn
WHERE tn.CodArt = 'B'

-- 8. Listar los artículos que cuesten más de $2300 o que estén compuestos por el material M001.
SELECT art.CodArt FROM Compuesto_por cp
JOIN Articulo art ON art.CodArt = cp.CodArt
WHERE art.Precio > 2300 OR cp.CodMat = 'MAT001'

-- 9. Listar los materiales, código y descripción, provistos por proveedores de la ciudad de Rosario. 
SELECT mat.CodMat as 'Codigo de Material', mat.Descripcion FROM Provisto_por pp
JOIN Material mat ON mat.CodMat = pp.CodMat
JOIN Proveedor prv ON prv.CodProv = pp.CodProv
WHERE prv.Ciudad = 'Rosario'

-- 10. Listar el código, descripción y precio de los artículos que se almacenan en A1. 
SELECT art.CodArt, art.Descripcion, art.Precio FROM Tiene tn
JOIN Articulo art ON art.CodArt = tn.CodArt
WHERE tn.Nro = 1

-- 11. Listar la descripción de los materiales que componen el artículo B. 
SELECT mat.Descripcion FROM Compuesto_por cp
JOIN Material mat ON mat.CodMat = cp.CodMat
WHERE cp.CodArt = 'B'

-- 12. Listar los nombres de los proveedores que proveen los materiales al almacén que Juan Pérez tiene a su cargo. 
SELECT DISTINCT prv.Nombre FROM Provisto_por pp
JOIN Proveedor prv ON prv.CodProv = pp.CodProv
JOIN Compuesto_por cp ON cp.CodMat = pp.CodMat
JOIN Tiene tn ON  tn.CodArt = cp.CodArt
JOIN Almacen alm ON alm.Nro = tn.Nro
WHERE alm.Responsable = 'Juan Pérez';

-- 13. Listar códigos y descripciones de los artículos compuestos por al menos un material 
SELECT DISTINCT art.CodArt as 'Codigo Articulo', art.Descripcion FROM Compuesto_por cp
JOIN Articulo art ON art.CodArt = cp.CodArt

-- 14. Hallar los códigos y nombres de los proveedores que proveen al menos un material que se usa en algún artículo cuyo precio es mayor a $100.
SELECT DISTINCT prv.CodProv, prv.Nombre FROM Provisto_por pp
JOIN Proveedor prv ON prv.CodProv = pp.CodProv
JOIN Compuesto_por cp ON cp.CodMat = pp.CodMat
JOIN Articulo art ON art.CodArt = cp.CodArt
WHERE art.Precio > 100;

-- 15. Listar los números de almacenes que tienen todos los artículos que incluyen el material con código MAT004.

-- ============================
--	CONSULTAR
-- ============================
SELECT DISTINCT alm.Nro as 'Numero de almacenes' FROM Tiene tn
JOIN Almacen alm ON alm.Nro = tn.Nro
JOIN Compuesto_por cp ON cp.CodArt = tn.CodArt
WHERE cp.CodMat = 'MAT004';


-- 16. Listar los proveedores de Mendoza que sean únicos proveedores de algún material. 
SELECT DISTINCT pp.CodProv FROM Provisto_por pp
JOIN Proveedor prv ON prv.CodProv = pp.CodProv
WHERE prv.Ciudad = 'Mendoza' AND pp.CodMat IN (
	SELECT CodMat FROM Provisto_por
	GROUP BY CodMat
	HAVING COUNT(CodProv) = 1
)

-- 17. Listar el/los artículo/s de mayor precio. 
SELECT art.CodArt, art.Descripcion, art.Precio as 'Articulo de mayor precio' FROM Articulo art
WHERE art.Precio = (SELECT MAX(Precio) FROM Articulo)

-- 18. Listar el/los artículo/s de menor precio. 
SELECT art.CodArt, art.Descripcion, art.Precio as 'Articulo de mayor precio' FROM Articulo art
WHERE art.Precio = (SELECT MIN(Precio) FROM Articulo)

-- 19. Listar el promedio de precios de los artículos en cada almacén. 
SELECT alm.Nro as 'Almacen', AVG(art.Precio) AS 'Promedio'
FROM Articulo art
JOIN Tiene tn ON tn.CodArt = art.CodArt
JOIN Almacen alm ON alm.Nro = tn.Nro
GROUP BY alm.Nro;

-- 20. Listar los almacenes que almacenan la mayor cantidad de artículos. 
SELECT alm.Nro as 'Almacen', COUNT(art.CodArt) as 'Cantidad de articulos' FROM Tiene tn
JOIN Almacen alm ON alm.Nro = tn.Nro
JOIN Articulo art ON art.CodArt = tn.CodArt
GROUP BY alm.Nro
HAVING COUNT(art.CodArt) = (
	SELECT MAX(Cantidad)
    FROM (
        SELECT COUNT(CodArt) AS Cantidad
        FROM Tiene
        GROUP BY Nro
    ) AS Conteos
)




/* 
1. Listar los nombres de los proveedores de la ciudad de La Plata. 
2. Listar los números de artículos cuyo precio sea inferior a $10. 
3. Listar los responsables de los almacenes. 
4. Listar los códigos de los materiales que provea el proveedor 10 y no los provea el 
proveedor 15. 
5. Listar los números de almacenes que almacenan el artículo A. 
6. Listar los proveedores de Pergamino que se llamen Pérez. 
7. Listar los almacenes que contienen los artículos A y los artículos B (ambos). 
8. Listar los artículos que cuesten más de $100 o que estén compuestos por el material 
M1. 
9. Listar los materiales, código y descripción, provistos por proveedores de la ciudad 
de Rosario. 
10. Listar el código, descripción y precio de los artículos que se almacenan en A1. 
11. Listar la descripción de los materiales que componen el artículo B. 
12. Listar los nombres de los proveedores que proveen los materiales al almacén que 
Martín Gómez tiene a su cargo. 
13. Listar códigos y descripciones de los artículos compuestos por al menos un material 
provisto por el proveedor López. 
14. Hallar los códigos y nombres de los proveedores que proveen al menos un material 
que se usa en algún artículo cuyo precio es mayor a $100. 
15. Listar los números de almacenes que tienen todos los artículos que incluyen el 
material con código 123. 
16. Listar los proveedores de Capital Federal que sean únicos proveedores de algún 
material. 
17. Listar el/los artículo/s de mayor precio. 
18. Listar el/los artículo/s de menor precio. 
19. Listar el promedio de precios de los artículos en cada almacén. 
20. Listar los almacenes que almacenan la mayor cantidad de artículos. 
21. Listar los artículos compuestos por al menos 2 materiales. 
22. Listar los artículos compuestos por exactamente 2 materiales. 
23. Listar los artículos que estén compuestos con hasta 2 materiales. 
24. Listar los artículos compuestos por todos los materiales. 
25. Listar las ciudades donde existan proveedores que provean todos los materiales.
*/