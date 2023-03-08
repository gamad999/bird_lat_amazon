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




