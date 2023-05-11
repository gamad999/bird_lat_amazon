---- INicio de rama Base de datos componente comunitario del Proyecto BirdLatam


--- Creacion de campo y calculo de area en hectareas de resguardos indigenas Amazonas

ALTER TABLE resguardos_indigenas_amazonas ADD COLUMN area_has double precision;

UPDATE resguardos_indigenas_amazonas SET area_has = (SELECT ST_Area(geom)/10000.0);