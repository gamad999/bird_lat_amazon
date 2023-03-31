# Proyecto BirdLatam Amazonas Colombia Base de Datos Espacial de Biodiversidad con Propositos Ecoturísticos
Propuesta de desarrollo de base de datos espacial y geo-visor de infraestructura digital de Información Geográfica para la promoción de Leticia y Puerto Nariño Amazonas como destinos turísticos de avistamiento de aves en el mercado emisor de China – BirdLatam.

La Propuesta tecnológica BirdLatam pretende dar a conocer a las directivas de la Cámara Colombo-China de Inversión y Comercio una solución para el desarrollo y administración integral de una base de datos georreferenciada del sector ecoturístico en el Departamento del Amazonas Colombia y la definición de estrategias de promoción digital del conocimiento de biodiversidad de flora y fauna útiles para el logro de objetivos en materia de turismo sostenible, ofreciendo al visitante potencial la oportunidad de explorar y aprender más acerca de la riqueza de especies presentes en la región de la Amazonia colombiana. 

Como primera estrategia para captar la atención del turista se propone ofrecer un servicio de información integral que facilite la ejecución eficiente de consultas a traves de una aplicación móvil, enfocadas en servir datos cartográficos en forma de mapas digitales que integran imágenes satelitales de alta resolución de la región y sitios turísticos idóneos para el avistamiento e interaccion con especies de flora y fauna amazónica, temáticos como datos biológicos, taxonómicos, ecológicos y de distribución geográfica de cada especie de acuerdo a la infraestructura global de datos biológicos "Global Biodiversity Information Facility GBIF", graficos como una galería fotográfica completa alojada en la API de la Infraestructura Global de Datos Biológicos GBIF, culturales como nombres comunes de cada especie en varios idiomas como chino, español, inglés, francés, portugués y lenguas locales como la tikuna útiles para propiciar la interacción de los potenciales turistas con comunidades locales, y auditivos como enlaces a bases de datos de sonidos ambientales de las especies como Xeno Canto. 

De igual forma, se propone dentro de esta estrategia de atracción de turistas chinos, ofrecer una base de datos de riqueza de especies de colibríes alojada en la nube, como una familia biológica endémica de América y la región amazónica en su conjunto; este componente de la base de datos espacial puede sugerir una Ruta del Colibrí, que conecte localidades ubicadas en varios países como Colombia, Brasil y Perú, y así realizar un esfuerzo para consolidar a Colombia como punto de conexión de rutas ecoturisticas de avistamiento de fauna en recorridos que integren territorios transnacionales y que estimulen el interés de los visitantes por realizar recorridos de avistamiento de avifauna endémica propia de ecosistemas tropicales.

## Modelo de negocios de Propuesta BirdLatam

La Propuesta BirdLatam para el diseño e implementación de una base de datos espacial y geovisor web está enfocada en ofrecer una solución tecnológica que apoye la promoción y posicionamiento de la región amazónica colombiana como destino turístico de avistamiento de fauna (en un principio avifauna) en el mercado turístico emisor chino. Los dos principales componentes de esta solución tecnológica son:
1.	Base de datos con soporte de datos geográficos que recopile, almacene y administre la información soporte para la construcción de un modelo de datos de ecosistemas, territorios, infraestructura turística, transporte, biodiversidad de flora y fauna, comunidades locales, atractivos turísticos, comercio y servicios relacionados con el sector de turismo sostenible a escala local, regional y transnacional.
2.	Aplicación web móvil, consistente en un geovisor que integre la información del modelo de datos y facilite su consulta y exploración por parte de los usuarios por medio del despliegue de mapas digitales con imágenes satelitales de alta resolución, temas o capas de información de la base de datos mencionada y funcionalidades, enfocados en incentivar el interés y servir datos en la nube útiles para la realización de actividades ecoturisticas en el territorio, combinando las modalidades presencial y virtual en la interacción del viajero, las comunidades locales y las empresas con los recursos naturales y de biodiversidad propios de la región del Amazonas.

La labor conjunta y colaborativa de los equipos de trabajo que se propone organizar, involucra el desarrollo de actividades que permitan diseñar, implementar y administrar en el tiempo la solución tecnológica y alojar en ésta la información traducida al chino, que permita ofrecer un servicio integral al turista que visita el territorio y que puede ayudar a construir y/o fortalecer redes empresariales en las que la Cámara Colombo China de Inversión y Comercio aportaría tanto las traducciones de información turística, comercial, comunitaria y de servicios, como la construcción de alianzas que promuevan la socialización de los aspectos y ofertas de biodiversidad nativa, cultural y de negocios para que puedan ser conocidos y gradualmente apreciados en el mercado turístico emisor de China Continental. Las carteras de clientes potenciales de esta línea de negocios pueden incluir empresas relacionadas con infraestructura y prestación de servicios del sector  como hoteles, restaurantes, comercios de artículos, agencias locales de turismo, etc., cuya información debidamente traducida se integraría en el modelo de datos y en la aplicación web de mapas final, con el fin de lograr un posicionamiento gradual de todo el sector en el mercado emisor.




## Etapas en el diseño e implementación de un SIG y base de datos espacial

Cuando se ha tomado la determinación de implementar un SIG y al margen del área temática que quiera sistematizarse, es indispensable seguir un procedimiento, una serie de pasos o etapas sucesivas, cuyo cumplimiento garantiza el éxito del sistema, su óptimo funcionamiento a través del tiempo y la justificación de la inversión. Este procedimiento se aplica genéricamente a cualquier SIG y sus etapas son:

1.	Definir claramente los Objetivos que deberá cumplir el SIG, los cuales están determinados por las funciones propias de la Entidad, Institución o Empresa que pretende implementarlo, o por los alcances y objetivos de un Proyecto o investigación dada.
2.	Identificar los datos que se usan y generan en las Instituciones para desarrollar sus funciones, o aquellos involucrados en el Proyecto. 
3.	Identificar los requerimientos de los usuarios de la información del Proyecto SIG. 
4.	Esquematizar los flujos de información requerida en las rutinas institucionales o del área de actividad que se desea sistematizar bajo el esquema SIG.
5.	Definir el Modelo de Datos, que es la estructura formal de los datos para su implementación. El Modelo expresa las especificaciones, reglas y restricciones para la captura, almacenamiento, consulta, actualización y manipulación de los datos del Sistema.
6.	Implementar el SIG, que consiste en la preparación de la información relevante, su captura mediante digitalización o rasterización, la creación de tablas de atributos asociadas a los objetos o entidades espaciales y el almacenamiento de los valores de los atributos que deberán llenar las columnas o campos correspondientes. Esto último puede lograrse mediante digitación directa y alojamiento de servidores de bases de datos espaciales en la nube. La implementación del SIG también implica la estructuración de las entidades temáticas derivadas de otras, mediante análisis en el motor de administración de la base de datos con soporte espacial y el software SIG (modelamiento cartográfico). Finalmente y una vez toda la información se encuentre estructurada y almacenada en el sistema, es necesario diseñar todos aquellos programas, macros, algoritmos y aplicaciones que de acuerdo con los requerimientos específicos son indispensables para extraer, actualizar información o derivar nueva a partir de la que está almacenada en el Sistema. Estos programas se diseñan en el lenguaje particular del software utilizado.
7.	Reacondicionar el Modelo original de acuerdo con los resultados y el desempeño del Sistema. Esto significa que el Modelo de Datos se pone a prueba mediante la manipulación de la información en el Sistema, por parte de los usuarios. Las expectativas deben satisfacerse en aspectos como: el desempeño del Sistema o dicho de otra forma, la velocidad de respuesta cuando se realzan peticiones a los servicios implementados. Tambien se espera la generación eficiente ya sea de reportes tabulares o mapas, la velocidad y efectividad en los procesos de actualización de los datos, etc.


## Servidores en la nube y software propuestos para el desarrollo de la solución tecnológica

#### Software

1.	Motor de base de datos PostgreSQL y extensión PostGIS para soporte de datos espaciales
2. 	Software SIG QGIS 2.8 (Software libre)
3.	Sistema de control de versiones GIT y plataforma de alojamiento de repositorios remotos en internet GitHub.

#### Servidores

1.	Amazon Web Services AWS - Relational Databases Services RDS (alojamiento de base de datos espacial en la nube)
2.	ESRI - ArcGIS Online (Desarrollo de Aplicación Web Móvil para el despliegue de información geográfica y temática - Geovisor web)

## Guía de navegación archivos en este repositorio de Github

Archivo pybrdlatamz.sql: puede consultar el codigo SQL de diseño preliminar de la base de datos geográfica BirdLatam
Fichero Tablas: puede consultar las tablas resultado de consultas preliminares a la bd sobre diagnostico de biodiversidad de flora y fauna e infraestructura turística


## Autor de la Propuesta:

Geovanny Andrés Marmolejo De Oro

Geógrafo egresado de la Universidad del Valle

M.P. 464 / 2012 Colegio Profesional de Geógrafos de Colombia

email: geoconsultores.eu@gmail.com

Teléfono móvil: (57) 315 5429106

Repositorios Github: www.github.com/gamad999