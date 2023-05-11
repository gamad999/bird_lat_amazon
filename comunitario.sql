---- INicio de rama Base de datos componente comunitario del Proyecto BirdLatam


--- Creacion de campo y calculo de area en hectareas de resguardos indigenas Amazonas

ALTER TABLE resguardos_indigenas_amazonas ADD COLUMN area_has double precision;

UPDATE resguardos_indigenas_amazonas SET area_has = (SELECT ST_Area(geom)/10000.0);

--- Inicio diagnostico preliminar de componente comunitario Amazonas Colombia

SELECT nombre_res AS reguardo, matricula_, pueblo, municipio, area_has
FROM resguardos_indigenas_amazonas;

--- Diagnostico de area de resguardos por pueblo

SELECT pueblo, SUM(area_has) AS tot_area_has FROM resguardos_indigenas_amazonas
GROUP BY pueblo ORDER BY tot_area_has DESC;


