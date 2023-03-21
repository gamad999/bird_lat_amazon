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

-- Creacion de campo nombre comun y traduccion fonetica pinyin del nombre de especies en chino mandarin
ALTER TABLE gbif_amazonas ADD COLUMN name_zh varchar(150);

ALTER TABLE gbif_amazonas ADD COLUMN name_pinyin varchar(150);

-- Nombres comunes de especies en ingles, español, frances y portugues
ALTER TABLE gbif_amazonas 
ADD COLUMN name_en varchar(60), ADD COLUMN name_es varchar(80), ADD COLUMN name_fr varchar(50),
ADD COLUMN name_pr varchar(50);

UPDATE gbif_amazonas SET name_zh = '白颊红嘴蜂鸟' WHERE species = 'Chlorestes cyanus';
UPDATE gbif_amazonas SET name_pinyin = 'Bái jiá hóng zuǐ fēngniǎo' WHERE species = 'Chlorestes cyanus'
UPDATE gbif_amazonas SET name_en = 'White-chinned sapphire' WHERE species = 'Chlorestes cyanus';
UPDATE gbif_amazonas SET name_es = 'zafiro gorgiblanco o de cabeza azul, picaflor lazulita' WHERE species = 'Chlorestes cyanus';
UPDATE gbif_amazonas SET name_fr = 'Saphir azuré' WHERE species = 'Chlorestes cyanus';
UPDATE gbif_amazonas SET name_pr = 'Beija-flor-roxo' WHERE species = 'Chlorestes cyanus';


-- Consulta de familias
SELECT species, COUNT(DISTINCT id) AS rec_gbif
FROM gbif_amazonas WHERE family = 'Trochilidae' GROUP BY species ORDER BY rec_gbif DESC;

-- Construccion de tabla de especies de colibries con traduccion de nombres comunes a chino mandarin,
-- español, ingles, frances y portugues

SELECT species, name_es AS nombre_esp, name_zh AS nombre_chino, name_pinyin AS pinyin,
name_en AS nombre_ingl, name_fr AS nombre_franc, name_pr AS nombre_portg, 
COUNT(DISTINCT id) AS gbif_records FROM gbif_amazonas WHERE family = 'Trochilidae' AND species IS NOT NULL
GROUP BY species, nombre_esp, nombre_chino, pinyin, nombre_ingl, nombre_franc, nombre_portg
ORDER BY gbif_records DESC;


-------------------- Segmentacion por Municipio del Departamento de Amazonas Colombia -----

ALTER TABLE gbif_amazonas ADD COLUMN municipio varchar(80);

UPDATE gbif_amazonas 
SET municipio = municipios_amazonas.mpio_cnmbr
FROM municipios_amazonas
WHERE ST_Intersects(gbif_amazonas.geom, municipios_amazonas.geom);










-------------------  Traducciones al chino mandarin -------------------------------------

-- Traduccion de nombre de familias biologicas al chino mandarin
UPDATE gbif_amazonas SET family_zh = '巨嘴鳥' WHERE family = 'Ramphastidae';

-- Traduccion fonetica nombre de familias al chino mandarin
UPDATE gbif_amazonas SET family_pinyin = 'Cǎo xiāo kē' WHERE family = 'Tytonidae';

-- Nombre comun de familias biologicas en español
ALTER TABLE gbif_amazonas ADD COLUMN nombre_familia varchar(80);

-- Actualizacion nombre de familia biologica en español
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
UPDATE municipios_amazonas SET name_zh = '桑坦德港' 
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

UPDATE hoteles_amazonas SET nombre_zh = '怀拉套房酒店' WHERE nombre = 'Waira Suites Hotel'
UPDATE hoteles_amazonas SET pinyin = 'Huái lā tàofáng jiǔdiàn' WHERE nombre = 'Waira Suites Hotel'
UPDATE hoteles_amazonas SET categoria = '3 星级酒店' WHERE nombre = ''
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


SELECT species, COUNT(DISTINCT id) AS rec_gbif FROM gbif_amazonas WHERE class = 'Aves'
GROUP BY species ORDER BY rec_gbif DESC;






----  Creacion de base de datos de lugares y atracciones turisticas en Deparatamento de Amazonas

-- Consulta de localidades en la tabla de registros biologicos GBIF Amazonas

SELECT locality, decimallat, decimallon, COUNT(DISTINCT id) AS rec_gbif, COUNT(DISTINCT species) AS species
FROM gbif_amazonas WHERE class = 'Aves' 
GROUP BY locality, decimallat, decimallon ORDER BY rec_gbif DESC, species;

-- Creacion de tabla de sitios turisticos propuestos

CREATE TABLE sitios_turisticos(id SERIAL PRIMARY KEY, nombre varchar(80),
							  municipio varchar(50), latitud double precision,
							  longitud double precision);
							  

INSERT INTO sitios_turisticos(nombre, latitud, longitud) 
VALUES('Rio Amazonas - Puerto Nariño', -3.772705, -70.381424);

INSERT INTO sitios_turisticos(nombre, latitud, longitud)
VALUES('Varzea PN Amacayacu', -3.814165, -70.2605),
	   ('PN Amacayacu - Tierra Firma', -3.804732, -70.26116);


INSERT INTO sitios_turisticos(nombre, latitud, longitud)
VALUES('Laguna Tarapoto', -3.794373, -70.42717),
('Isla de Los Micos', -4.036043, -70.10654),
('Lagos Yahuarcaca', -4.189504, -69.95843),
('Hotel Malokamazonas', -4.214694, -69.9369),
('Quebrada Tucuchira', -4.019386, -70.11283),
('Parque Ecológico Mundo Amazónico', -4.145263, -69.92987),
('Isla Mocagua y Zaragocilla', -3.85, -70.23333),
('Parque Santander', -4.212645, -69.94298),
('Isla Fantasía', -4.202146, -69.95933),
('Barrio Punta Brava - Leticia', -4.216849, -69.93832),
('Sendero San Rafael', -1.711944, -73.21333),
('Isla Ronda', -4.153002, -69.99372),
('Reserva Natural Selva', -4.124637, -69.94567),
('Parque Natural Amacayacu', -3.391333, -70.15283),
('Quebrada Matamatá', -3.818111, -70.256226),
('Puerto Nariño - Pueblo', -3.77933, -70.363976),
('Amazon Bird Lodge - Puerto Nariño', -3.787876, -70.356125),
('Reserva Natural Cerca Viva', -4.122799, -69.947975),
('Sector La Playa', -4.2045, -69.9536),
('Reserva Natural Tanimboca', -4.120865, -69.952034),
('Rio Tacana - Maloka William', -4.135825, -69.921295),
('Comunidad Bora - Muinane Km 17', -4.065, -69.979),
('Puerto Nariño - zona alta', -3.772191, -70.35739),
('San Pedro de Tipisca', -3.682451, -70.59858),
('Comunidad Ronda', -4.131566, -69.99239),
('Laguna Pexiboy 10 Km', -2.6138, -69.8452),
('Reserva Ara', -4.095942, -69.95063),
('Leticia - Sendero norte', -4.156991, -69.93536),
('Comunidad Indígena Mocagua', -3.825149, -70.25331),
('Comunidad Indígena San Martín de Amacayacu', -3.776302, -70.30106),
('Barrio Costa Rica - Leticia', -4.203987, -69.93603),
('Tarapoto - Canales internos', -3.821427, -70.49108),
('Laguna El correo', -3.781046, -70.395195),
('Sendero Puerto Nariño a San Martín', -3.764346, -70.334755),
('Aeropuerto Internacional Alfredo Vasquez Cobo', -4.197502, -69.94276),
('Reserva Wochine', -3.778989, -70.35819),
('Isla Mocagua - Lago Huito', -3.844986, -70.2529),
('Lago Sapo - rio Loretoyacu', -3.779762, -70.3763),
('Puerto fluvial - Leticia', -4.22317, -69.94498),
('Río Loretoyacu', -3.77847, -70.37334),
('Reserva Flor de Loto', -4.184499, -69.97337),
('Casa Gregorio', -3.775628, -70.30518);

--- Enlace espacial de tabla de sitios turisticos con tabla de Municipios del Amazonas
--- para actualizar campo de localizacion de cada sitio dentro de Area de Aplicación de 
--- PBOT del correspondiente Municipio

UPDATE sitios_turisticos SET municipio = municipios_amazonas.mpio_cnmbr
FROM municipios_amazonas WHERE ST_Intersects()
