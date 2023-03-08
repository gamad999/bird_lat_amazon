-- Inicio del Proyecto Bird Latam Amazon con propositos ecoturisticos

SELECT species, COUNT(DISTINCT id) AS rec_gbif FROM gbif_amazonas WHERE class = 'Aves'
GROUP BY species ORDER BY rec_gbif DESC;