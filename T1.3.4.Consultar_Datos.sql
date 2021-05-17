/****** Script for SelectTopNRows command from SSMS  ******/
 USE CovidAntioquia

 --Número total de personas contagiadas con COVID por Rango de edad 
 SELECT E.DescripcionRangoEdad, COUNT(P.ID_RangoEdad) AS Cantidad_Edad 
 FROM Personas AS P JOIN RangoEdad AS E ON P.ID_RangoEdad = E.ID_RangoEdad 
 GROUP BY E.DescripcionRangoEdad ORDER BY COUNT(P.ID_RangoEdad) DESC;

  --Número total de personas contagiadas con COVID pertenecientes a un grupo etnico
 SELECT G.DescripcionGrupoEtnico, COUNT(P.ID_GrupoEtnico) AS Cantidad_Etnia 
 FROM Personas AS P JOIN GrupoEtnico AS G ON P.ID_GrupoEtnico = G.ID_GrupoEtnico 
 GROUP BY G.DescripcionGrupoEtnico ORDER BY COUNT(P.ID_GrupoEtnico) DESC;
 
  --Número total de personas contagiadas con COVID por género
 SELECT Genero, COUNT(Genero) AS Cantidad_Genero 
 FROM Personas GROUP BY Genero ORDER BY COUNT(Genero) DESC;
 
 --15 Municipios con mayor número de personas contagiadas
 SELECT TOP 15 G.DescripcionMunicipio, COUNT(P.ID_Caso) AS Contagiados 
 FROM Personas AS P JOIN Geografia AS G ON P.ID_Geografia = G.ID_Geografia 
 GROUP BY G.DescripcionMunicipio ORDER BY COUNT(P.ID_Caso) DESC;

 --Cantidad de contagiados por mes
  SELECT MONTH(ID_FechaDiagnostico) AS Mes, COUNT(ID_Caso) AS Contagiados 
  FROM Seguimiento GROUP BY MONTH(ID_FechaDiagnostico) 
  ORDER BY COUNT(ID_Caso) DESC;
 
 --Cantidad de recuperados por mes
 SELECT MONTH(ID_FechaReporteWeb) AS Mes, COUNT(ID_Caso) AS Recuperados 
 FROM Seguimiento WHERE Recuperado = 'Recuperado' 
 GROUP BY MONTH(ID_FechaReporteWeb) ORDER BY COUNT(ID_Caso) DESC;

 --Cantidad de fallecidos por mes
  SELECT MONTH(ID_FechaMuerte) AS Mes, COUNT(ID_Caso) AS Fallecidos 
  FROM Seguimiento WHERE Recuperado = 'Fallecido' 
  GROUP BY MONTH(ID_FechaMuerte) ORDER BY COUNT(ID_Caso) DESC;

 --Promedio de la cantidad de días en que tardan las personas en recuperarse por cada mes
 SELECT MONTH(ID_FechaDiagnostico) AS Mes, AVG(DATEDIFF(DD, ID_FechaDiagnostico, ID_FechaRecuperacion)) AS Tiempo_Recuperacion FROM Seguimiento 
 WHERE Recuperado = 'Recuperado' AND YEAR(ID_FechaDiagnostico) > 2019 GROUP BY MONTH(ID_FechaDiagnostico) ORDER BY MONTH(ID_FechaDiagnostico);

  --Promedio de la cantidad de días en que tardan las personas en fallecer por cada mes
  SELECT MONTH(ID_FechaDiagnostico) AS Mes, AVG(DATEDIFF(DD, ID_FechaDiagnostico, ID_FechaMuerte)) AS Tiempo_Fallecimiento FROM Seguimiento 
  WHERE Recuperado = 'Fallecido' AND YEAR(ID_FechaDiagnostico) > 2019 GROUP BY MONTH(ID_FechaDiagnostico) ORDER BY MONTH(ID_FechaDiagnostico);

 --Cantidad de contagiados por mes para cada municipio
  SELECT MONTH(S.ID_FechaDiagnostico) AS Mes, COUNT(S.ID_Caso) AS Contagiados, 
  AVG(S.ID_Caso) AS Promedio_Contagiados, G.DescripcionMunicipio 
  FROM Seguimiento AS S JOIN Personas AS P ON S.ID_Caso = P.ID_Caso JOIN Geografia AS G 
  ON P.ID_Geografia = G.ID_Geografia WHERE YEAR(S.ID_FechaDiagnostico) > 2019 
  GROUP BY MONTH(S.ID_FechaDiagnostico), G.DescripcionMunicipio 
  ORDER BY MONTH(S.ID_FechaDiagnostico), G.DescripcionMunicipio;
  
  --Cantidad de tipos de contagio y estado por municipio, sólo se tuvieron en cuenta los que presentaran algún tipo de estado
  SELECT S.TipoContagio, S.Estado, COUNT(S.ID_Caso) AS Contagiados, G.DescripcionMunicipio FROM Seguimiento AS S JOIN Personas AS P 
  ON S.ID_Caso = P.ID_Caso JOIN Geografia AS G ON P.ID_Geografia = G.ID_Geografia 
  WHERE YEAR(S.ID_FechaDiagnostico) > 2019 AND S.Estado not in ('N/A')
  GROUP BY S.TipoContagio, S.Estado, G.DescripcionMunicipio ORDER BY G.DescripcionMunicipio;


