-- Inicio del Proyecto Bird Latam Amazon con propositos ecoturisticos

-- Creacion de extension postGIS para soporte de datos georreferenciados

CREATE EXTENSION postgis;

-- Socializacion de especies de aves (764 especies) por nombre cientifico y numero de registros GBIF presentes 
-- en territorio del Deparatamento del Amazonas Colombia a la fecha de marzo del 2023
SELECT species, family, COUNT(DISTINCT id) AS rec_gbif FROM gbif_amazonas WHERE class = 'Aves'
GROUP BY species, family ORDER BY rec_gbif DESC;

-- Socializacion de especies de mamiferos (125 especies) por nombre cientifico y numero de registros GBIF presentes 
-- en territorio del Deparatamento del Amazonas Colombia a la fecha de marzo del 2023
SELECT species, COUNT(DISTINCT id) AS rec_gbif FROM gbif_amazonas WHERE class = 'Mammalia'
GROUP BY species ORDER BY rec_gbif DESC;

-- Socializacion de especies de plantas (7394 especies) por nombre cientifico y numero de registros GBIF presentes 
-- en territorio del Deparatamento del Amazonas Colombia a la fecha de marzo del 2023
SELECT scientific, family, COUNT(DISTINCT id) AS rec_gbif FROM gbif_amazonas WHERE kingdom = 'Plantae'
GROUP BY scientific, family ORDER BY rec_gbif DESC;

-- Socializacion de especies de anfibios (189 especies) por nombre cientifico y numero de registros GBIF presentes 
-- en territorio del Deparatamento del Amazonas Colombia a la fecha de marzo del 2023
SELECT scientific, COUNT(DISTINCT id) AS rec_gbif FROM gbif_amazonas WHERE class = 'Amphibia'
GROUP BY scientific ORDER BY rec_gbif DESC;

-- Socializacion de especies de insectos (2260 especies) por nombre cientifico y numero de registros GBIF presentes 
-- en territorio del Deparatamento del Amazonas Colombia a la fecha de marzo del 2023
SELECT scientific, COUNT(DISTINCT id) AS rec_gbif FROM gbif_amazonas WHERE class = 'Insecta'
GROUP BY scientific ORDER BY rec_gbif DESC;


-- Socializacion de especies de abejas (38 especies) por nombre cientifico y numero de registros GBIF presentes 
-- en territorio del Departamento del Amazonas Colombia a la fecha de marzo del 2023
SELECT scientific, family, COUNT(DISTINCT id) AS rec_gbif FROM gbif_amazonas 
WHERE family = 'Apidae' OR family = 'Colletidae' OR family = 'Halictidae' OR 
family = 'Megachilidae'
GROUP BY scientific, family ORDER BY rec_gbif DESC;

-- Socializacion de especies de colibries (41 especies) por nombre cientifico y numero de registros GBIF presentes 
-- en territorio del Departamento del Amazonas Colombia a la fecha de marzo del 2023

SELECT species, COUNT(DISTINCT id) AS rec_gbif FROM gbif_amazonas 
WHERE family = 'Trochilidae'
GROUP BY species ORDER BY rec_gbif DESC;



-- Consulta de familias de aves por numero de especies y registros GBIF
SELECT family, COUNT(DISTINCT species) AS species, COUNT(DISTINCT id) AS rec_gbif 
FROM gbif_amazonas WHERE class = 'Aves' GROUP BY family ORDER BY species DESC, rec_gbif;

-- Creacion campo nombre de familia en chino mandarin
ALTER TABLE gbif_amazonas ADD COLUMN family_zh varchar(90);

-- Creacion de campo nombre de familia pinyin en chino mandarin
ALTER TABLE gbif_amazonas ADD COLUMN family_pinyin varchar(90);

-- Creacion de campo nombre comun en chino mandarin
ALTER TABLE gbif_amazonas ADD COLUMN name_zh varchar(150);

-- Consulta de familias
SELECT species, COUNT(DISTINCT id) AS rec_gbif
FROM gbif_amazonas WHERE family = 'Thraupidae' GROUP BY species ORDER BY rec_gbif DESC;

-------------------  Traducciones al chino mandarin -------------------------------------

-- Traduccion de nombre de familias biologicas al chino mandarin
UPDATE gbif_amazonas SET family_zh = '?????????' WHERE family = 'Ramphastidae';

-- Traduccion fonetica nombre de familias al chino mandarin
UPDATE gbif_amazonas SET family_pinyin = 'C??o xi??o k??' WHERE family = 'Tytonidae';

-- Nombre comun de familias biologicas en espa??ol
ALTER TABLE gbif_amazonas ADD COLUMN nombre_familia varchar(80);

-- Actualizacion nombre de familia biologica en espa??ol
UPDATE gbif_amazonas SET nombre_familia = 'Tucanes' 
WHERE family = 'Ramphastidae';

SELECT family, family_zh, family_pinyin, nombre_familia, COUNT(DISTINCT species) AS species,
COUNT(DISTINCT id) AS rec
FROM gbif_amazonas WHERE class = 'Aves' AND family_zh IS NOT NULL
GROUP BY family, family_zh, family_pinyin, nombre_familia ORDER BY species DESC, rec;



--------- Diagnostico de recursos de biodiversidad en Municipios del Departamento Amazonas ----------
-- Fuente de datos georreferenciados de biodiversidad: "Global Biodiversity Information Facility GBIF"----
--- Creacion de campos en la tabla espacial de Municipios y registros GBIF del Departamento

ALTER TABLE municipios_amazonas ADD COLUMN area_has double precision; 

ALTER TABLE municipios_amazonas ADD COLUMN riq_aves int,
ADD COLUMN riq_mammal int, ADD COLUMN riq_planta int,
ADD COLUMN riq_reptil int, ADD COLUMN riq_amphib int,
ADD COLUMN riq_insect int, ADD COLUMN riq_abejas int;

ALTER TABLE municipios_amazonas ADD COLUMN riq_colibri int;
ALTER TABLE gbif_amazonas ADD COLUMN frutal int;

-- Calculo de area en hectareas

UPDATE municipios_amazonas SET area_has = (ST_Area(municipios_amazonas.geom) / 10000);

-- Calculo de riqueza de especies de flora y fauna en el Departamento del Amazonas Colombia

-------------------------- Aves --------------------------------------------------------
UPDATE municipios_amazonas 
SET riq_aves = (SELECT COUNT(DISTINCT gbif_amazonas.species)
FROM gbif_amazonas
WHERE ST_Intersects(municipios_amazonas.geom, gbif_amazonas.geom)
AND gbif_amazonas.class = 'Aves');
										  

--------------------------- Mamiferos ----------------------------------------------------
UPDATE municipios_amazonas 
SET riq_mammalia = (SELECT COUNT(DISTINCT gbif_amazonas.species)
FROM gbif_amazonas
WHERE ST_Intersects(municipios_amazonas.geom, gbif_amazonas.geom)
AND gbif_amazonas.class = 'Mammalia');


-------------------------- Plantas -------------------------------------------------------
UPDATE municipios_amazonas 
SET riq_planta = (SELECT COUNT(DISTINCT gbif_amazonas.species)
FROM gbif_amazonas
WHERE ST_Intersects(municipios_amazonas.geom, gbif_amazonas.geom)
AND gbif_amazonas.kingdom = 'Plantae');


-------------------------- Anfibios ----------------------------------------------------
UPDATE municipios_amazonas 
SET riq_amphib = (SELECT COUNT(DISTINCT gbif_amazonas.species)
FROM gbif_amazonas
WHERE ST_Intersects(municipios_amazonas.geom, gbif_amazonas.geom)
AND gbif_amazonas.class = 'Amphibia');


-------------------------- Insectos -----------------------------------------------------
UPDATE municipios_amazonas 
SET riq_insect = (SELECT COUNT(DISTINCT gbif_amazonas.species)
FROM gbif_amazonas
WHERE ST_Intersects(municipios_amazonas.geom, gbif_amazonas.geom)
AND gbif_amazonas.class = 'Insecta');


-------------------------- Abejas --------------------------------------------------------
UPDATE municipios_amazonas 
SET riq_abejas = (SELECT COUNT(DISTINCT gbif_amazonas.species)
FROM gbif_amazonas
WHERE ST_Intersects(municipios_amazonas.geom, gbif_amazonas.geom)
AND (gbif_amazonas.family = 'Apidae' OR gbif_amazonas.family = 'Colletidae' OR
	gbif_amazonas.family = 'Halictidae' OR gbif_amazonas.family = 'Megachilidae'));


-------------------------- Colibries -----------------------------------------------------
UPDATE municipios_amazonas 
SET riq_colibri = (SELECT COUNT(DISTINCT gbif_amazonas.species)
FROM gbif_amazonas
WHERE ST_Intersects(municipios_amazonas.geom, gbif_amazonas.geom)
AND gbif_amazonas.family = 'Trochilidae');


----------------- Frutas silvestres de Colombia -----------------------------------------
------ Fuentes: Romero, R. "Frutas silvestres de Colombia". 2 Edicion. 1991.---------------
------- SINCHI. Frutas de la Amazonia: Colombia. -----------------------------------------
UPDATE gbif_amazonas SET frutal = 1 WHERE genus = 'Inga';

------ Construccion de tabla frutales silvestres ----------------------------------------

SELECT scientific, family, COUNT(DISTINCT id) AS rec_gbif 
FROM gbif_amazonas WHERE frutal = 1 GROUP BY scientific, family ORDER BY rec_gbif DESC;

-------------------------- Tablas resultado diagnostico de biodiversidad Amazonas --------

SELECT mpio_cnmbr AS municipio, name_zh, pinyin, area_has, riq_aves, riq_mammal, riq_planta, riq_amphib,
riq_insect, riq_abejas, riq_colibri FROM municipios_amazonas;

------------------------- Traduccion a chino mandarin de nombres de Municipios ----------
UPDATE municipios_amazonas SET name_zh = '????????????' 
WHERE mpio_cnmbr = 'SANTANDER (Araracuara)';







---------------- Desarrollo base de datos espacial de infraestructura hotelera -----------


ALTER TABLE hoteles_amazonas
ADD COLUMN nombre_zh varchar(150),
ADD COLUMN pinyin varchar(150),
ADD COLUMN categoria varchar(40),
ADD COLUMN precio_cop int,
ADD COLUMN direccion varchar(250),
ADD COLUMN telefonos varchar(100),
ADD COLUMN correo varchar(180),
ADD COLUMN web varchar(180),
ADD COLUMN servicios varchar(250),
ADD COLUMN ctrip varchar(200);

SELECT nombre, nombre_zh, pinyin FROM hoteles_amazonas;

---- Construccion de datos basicos de hoteles -----------

UPDATE hoteles_amazonas SET nombre_zh = '??????????????????' WHERE nombre = 'Waira Suites Hotel'
UPDATE hoteles_amazonas SET pinyin = 'Hu??i l?? t??of??ng ji??di??n' WHERE nombre = 'Waira Suites Hotel'
UPDATE hoteles_amazonas SET categoria = '3 ????????????' WHERE nombre = ''
UPDATE hoteles_amazonas SET precio_cop = 98000 WHERE nombre = ''
UPDATE hoteles_amazonas SET direccion = 'Cra. 10 # 7-36, Leticia, Amazonas' WHERE nombre = 'Waira Suites Hotel'
UPDATE hoteles_amazonas SET telefonos = '(57) 314 264 7018' WHERE nombre = 'Waira Suites Hotel'
UPDATE hoteles_amazonas SET correo = 'gerenciao@wairahotel.com.co' WHERE nombre = 'Waira Suites Hotel'
UPDATE hoteles_amazonas SET web = 'https://wairahotel.com.co/' WHERE nombre = 'Waira Suites Hotel'
UPDATE hoteles_amazonas SET servicios = '' WHERE nombre = 'Casa Hotel Maune'
UPDATE hoteles_amazonas SET ctrip = 'https://hotels.ctrip.com/hotels/3662657.html#ctm_ref=www_hp_bs_lst' WHERE nombre = 'Waira Suites Hotel'


----------------- Generacion de tabla de datos basicos de hoteles (Propuesta de desarrollo) ----------------

SELECT nombre, nombre_zh, pinyin, telefonos, correo, ctrip
FROM hoteles_amazonas;




