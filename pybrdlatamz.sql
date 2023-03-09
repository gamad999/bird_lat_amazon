-- Inicio del Proyecto Bird Latam Amazon con propositos ecoturisticos

-- Socializacion de especies de aves (764 especies) por nombre cientifico y numero de registros GBIF presentes 
-- en territorio del Deparatamento del Amazonas Colombia a la fecha de marzo del 2023
SELECT species, COUNT(DISTINCT id) AS rec_gbif FROM gbif_amazonas WHERE class = 'Aves'
GROUP BY species ORDER BY rec_gbif DESC;

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
UPDATE gbif_amazonas SET family_zh = '鹭科' WHERE family = 'Ardeidae';

-- Traduccion fonetica nombre de familias al chino mandarin
UPDATE gbif_amazonas SET family_pinyin = 'Lù kē' WHERE family = 'Ardeidae';

-- Nombre comun de familias biologicas en español
ALTER TABLE gbif_amazonas ADD COLUMN nombre_familia varchar(80);

-- Actualizacion nombre de familia biologica en español
UPDATE gbif_amazonas SET nombre_familia = 'Garzas' 
WHERE family = 'Ardeidae';

SELECT family_zh, family_pinyin, nombre_familia, COUNT(DISTINCT id) AS rec
FROM gbif_amazonas WHERE family = 'Picidae' GROUP BY family_zh, family_pinyin, nombre_familia
ORDER BY rec;





