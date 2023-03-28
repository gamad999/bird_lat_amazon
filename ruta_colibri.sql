-------- Desarrollo Ruta del Colibri ------------------

-- Construcción de campo y enlace a la API - Backbone de la "Global Biodiversity Information Facility, GBIF"

ALTER TABLE ruta_colibri ADD COLUMN gbif_backb varchar(150);
UPDATE ruta_colibri SET gbif_backb = CONCAT('https://www.gbif.org/zh/species/', taxonkey);


-- Construcción de campos de nombres comunes en varios idiomas

ALTER TABLE ruta_colibri ADD COLUMN name_zh varchar(70), ADD COLUMN pinyin varchar(80);
ALTER TABLE ruta_colibri ADD COLUMN name_en varchar(50), ADD COLUMN name_es varchar(80),
ADD COLUMN name_pr varchar(60), ADD COLUMN name_fr varchar(50);


-- Migracion de datos de nombres comunes desde capa gbif_amazonas

UPDATE ruta_colibri SET name_zh = gbif_amazonas.name_zh FROM gbif_amazonas
WHERE ruta_colibri.species = gbif_amazonas.species;

UPDATE ruta_colibri SET pinyin = gbif_amazonas.name_pinyin FROM gbif_amazonas
WHERE ruta_colibri.species = gbif_amazonas.species;

UPDATE ruta_colibri SET name_en = gbif_amazonas.name_en FROM gbif_amazonas
WHERE ruta_colibri.species = gbif_amazonas.species;

UPDATE ruta_colibri SET name_es = gbif_amazonas.name_es FROM gbif_amazonas
WHERE ruta_colibri.species = gbif_amazonas.species;

UPDATE ruta_colibri SET name_pr = gbif_amazonas.name_pr FROM gbif_amazonas
WHERE ruta_colibri.species = gbif_amazonas.species;

UPDATE ruta_colibri SET name_fr = gbif_amazonas.name_fr FROM gbif_amazonas
WHERE ruta_colibri.species = gbif_amazonas.species;

-- Verificación 

SELECT DISTINCT species, name_zh, pinyin, name_en, name_es, name_pr, name_fr 
FROM ruta_colibri;

--- Traduccion a nombres comunes en chino, español, ingles, portugues y frances

UPDATE ruta_colibri SET name_zh = gbif_amazonas.name_zh FROM gbif_amazonas
WHERE ruta_colibri.species = 'Phaethornis philippii';

UPDATE ruta_colibri SET pinyin = gbif_amazonas.name_pinyin FROM gbif_amazonas
WHERE ruta_colibri.species = 'Phaethornis philippii';

UPDATE ruta_colibri SET name_en = gbif_amazonas.name_en FROM gbif_amazonas
WHERE ruta_colibri.species = 'Phaethornis philippii';

UPDATE ruta_colibri SET name_es = gbif_amazonas.name_es FROM gbif_amazonas
WHERE ruta_colibri.species = 'Phaethornis philippii';

UPDATE ruta_colibri SET name_pr = gbif_amazonas.name_pr FROM gbif_amazonas
WHERE ruta_colibri.species = 'Phaethornis philippii';

UPDATE ruta_colibri SET name_fr = gbif_amazonas.name_fr FROM gbif_amazonas
WHERE ruta_colibri.species = 'Phaethornis philippii';



