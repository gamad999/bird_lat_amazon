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

SELECT DISTINCT species, name_zh, pinyin, name_en, name_es, name_pr, name_fr,
COUNT(DISTINCT id) AS rec_gbif
FROM ruta_colibri GROUP BY species, name_zh, pinyin, name_en, name_es, name_pr, name_fr
ORDER BY rec_gbif DESC;

--- Traduccion a nombres comunes en chino, español, ingles, portugues y frances

UPDATE ruta_colibri SET name_zh = '扇尾蜂鸟' 
WHERE ruta_colibri.species = 'Discosura longicaudus';

UPDATE ruta_colibri SET pinyin = 'Shàn wěi fēngniǎo' 
WHERE ruta_colibri.species = 'Discosura longicaudus';

UPDATE ruta_colibri SET name_en = 'Racket-tailed Coquette' 
WHERE ruta_colibri.species = 'Discosura longicaudus';

UPDATE ruta_colibri SET name_es = 'Rabudito de Raquetas' 
WHERE ruta_colibri.species = 'Discosura longicaudus';

UPDATE ruta_colibri SET name_pr = 'Bandeirinha'
WHERE ruta_colibri.species = 'Discosura longicaudus';

UPDATE ruta_colibri SET name_fr = 'Coquette à raquettes' 
WHERE ruta_colibri.species = 'Discosura longicaudus';

--- Traduccion de nombres de municipios transnacionales al chino mandarin

ALTER TABLE municipios_transnacional ADD COLUMN municipio_zh varchar(120);

SELECT municipio, country, municipio_zh FROM municipios_transnacional;

UPDATE municipios_transnacional SET municipio_zh = '乌卡亚利大区 (Wū kǎ yǎ lì dà qū)'
WHERE municipio = 'Ucayali';


--- Geoproceso de enlace espacial para segmentacion de capas de ruta del colibri y administrativas transnacionales

ALTER TABLE ruta_colibri ADD COLUMN pais varchar(30), ADD COLUMN region varchar(40), 
ADD COLUMN municipio varchar(80);

ALTER TABLE ruta_colibri ADD COLUMN pais_zh varchar(50), ADD COLUMN region_zh varchar(50), 
ADD COLUMN municipio_zh varchar(120);

UPDATE ruta_colibri SET pais = region_transnacional.nacion FROM region_transnacional
WHERE ST_Intersects(ruta_colibri.geom, region_transnacional.geom);

UPDATE ruta_colibri SET pais_zh = region_transnacional.nacion_zh FROM region_transnacional
WHERE ST_Intersects(ruta_colibri.geom, region_transnacional.geom);

UPDATE ruta_colibri SET region = region_transnacional.region FROM region_transnacional
WHERE ST_Intersects(ruta_colibri.geom, region_transnacional.geom);

UPDATE ruta_colibri SET region_zh = region_transnacional.region_zh FROM region_transnacional
WHERE ST_Intersects(ruta_colibri.geom, region_transnacional.geom);

UPDATE ruta_colibri SET municipio = municipios_transnacional.municipio FROM municipios_transnacional
WHERE ST_Intersects(ruta_colibri.geom, municipios_transnacional.geom);

UPDATE ruta_colibri SET municipio_zh = municipios_transnacional.municipio_zh FROM municipios_transnacional
WHERE ST_Intersects(ruta_colibri.geom, municipios_transnacional.geom);



-- Generación de tabla de diagnostico de biodiversidad de colibries en municipios transnacionales

SELECT municipio, region, pais, municipio_zh, region_zh, pais_zh, COUNT(DISTINCT species) AS riq_species,
COUNT(DISTINCT id) AS rec_gbif FROM ruta_colibri
GROUP BY municipio, region, pais, municipio_zh, region_zh, pais_zh
ORDER BY riq_species DESC, rec_gbif;




