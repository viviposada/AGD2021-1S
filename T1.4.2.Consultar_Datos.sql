---Consultas Mongo

--Consultar la totalidad de la base de datos
db.CovidAntioquia.find().pretty()

--Conteo del n�mero de casos
db.CovidAntioquia.find( { ID_Caso: { $exists: true } } ).count()

---Selecci�n y cuenta de los contagiados en Medell�n
db.CovidAntioquia.find( { DescripcionMunicipio: "MEDELLIN"} ).pretty()
db.CovidAntioquia.find( { DescripcionMunicipio: "MEDELLIN"} ).count()

--Visualizaci�n del tipo de contagio, Rango de edad y grupo �tnico para el municipio de Medell�n 
db.CovidAntioquia.find(
    { DescripcionMunicipio: "MEDELLIN" },
    { TipoContagio: 1, ID_RangoEdad: 1, ID_GrupoEtnico: 1}
)

--Filtro de los municipios diferentes de Medell�n con casos de contagiados
db.CovidAntioquia.find(     { DescripcionMunicipio: {$ne: "MEDELLIN"} } ).pretty()

--Cuenta de los municipios diferentes de Medell�n con casos de contagiados
db.CovidAntioquia.find(     { DescripcionMunicipio: {$ne: "MEDELLIN"} } ).count()

--Visualizaci�n del tipo de contagio, Rango de edad y grupo �tnico para los municipios diferentes de Medell�n
db.CovidAntioquia.find(
    { DescripcionMunicipio: {$ne: "MEDELLIN"} },
    { TipoContagio: 1, ID_RangoEdad: 1, ID_GrupoEtnico: 1}
)

--Filtro de los contagiados con edades superiores a 50 y determinaci�n de la cantidad
db.CovidAntioquia.find(
    { Edad: { $gt: 50 } },
).pretty()

db.CovidAntioquia.find(     { Edad: { $gt: 50 } }, ).count()


--Filtro de los contagiados con edades entre 56 y 65 y determinaci�n de la cantidad
db.CovidAntioquia.find(    { Edad: { $gt: 56, $lte: 65 } } )
db.CovidAntioquia.find(    { Edad: { $gt: 56, $lte: 65 } } ).count()


--Selecci�n de los casos recuperados y fallecidos con su respectiva cantidad
----Recuperados
db.CovidAntioquia.find( { Recuperado: "Recuperado" } ).sort( { Edad: -1 } ).pretty()
db.CovidAntioquia.find( { Recuperado: "Recuperado" } ).sort( { Edad: -1 } ).count()

----Fallecidos
db.CovidAntioquia.find( { Recuperado: "Fallecido" } ).sort( { Edad: -1 } ).pretty()
db.CovidAntioquia.find( { Recuperado: "Fallecido" } ).sort( { Edad: -1 } ).count()

--Municipios con casos de contagiados con COVID reportados en Antioquia
db.CovidAntioquia.aggregate( [ { $group : { _id : "$DescripcionMunicipio" } } ] )

--Tipos de Contagio reportados para las personas contagiadas en Antioquia
db.CovidAntioquia.aggregate( [ { $group : { _id : "$TipoContagio" } } ] )

--Filtro de los contagiados para cada g�nero (F:Femenino y M:Masculino)
--------Masculino
db.CovidAntioquia.find(    { Genero: "M"  } ).pretty()
db.CovidAntioquia.find(    { Genero:  "M" } ).count()
--------Femenino
db.CovidAntioquia.find(    { Genero: "F"  } ).pretty()
db.CovidAntioquia.find(    { Genero:  "F" } ).count()