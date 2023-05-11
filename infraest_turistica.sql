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