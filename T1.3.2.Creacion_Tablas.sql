CREATE DATABASE CovidAntioquia

USE CovidAntioquia

CREATE TABLE "Geografia" (
  "ID_Geografia" bigint NOT NULL ,
  "CodigoDepartamento" bigint NOT NULL,
  "DescripcionDepartamento" varchar(20) NOT NULL,
  "DescripcionMunicipio" varchar(30) NOT NULL,
  PRIMARY KEY ("ID_Geografia")
);

CREATE TABLE "Seguimiento" (
  "ID_Caso" bigint NOT NULL ,
  "ID_FechaReporteWeb" date NOT NULL,
  "ID_FechaNotificacion" date NOT NULL,
  "ID_FechaInicioSintomas" date NOT NULL,
  "ID_FechaMuerte" date NULL,
  "ID_FechaDiagnostico" date NOT NULL,
  "ID_FechaRecuperacion" date NULL,
  "TipoContagio" varchar(20) NULL,
  "Estado" varchar(20) NULL,
  "Recuperado" varchar(20) NULL,
  PRIMARY KEY ("ID_Caso")
);

CREATE TABLE "Personas" (
  "ID_Caso" bigint NOT NULL,
  "ID_Geografia" bigint NOT NULL,
  "ID_RangoEdad" int NOT NULL,
  "ID_GrupoEtnico" int NOT NULL,
  "Genero" varchar(1) NOT NULL,
  "Edad" int NOT NULL,
  PRIMARY KEY ("Personas")
);

CREATE TABLE "GrupoEtnico" (
  "ID_GrupoEtnico" int NOT NULL,
  "DescripcionGrupoEtnico" varchar(20) NOT NULL,
  PRIMARY KEY ("ID_GrupoEtnico")
);

CREATE TABLE "RangoEdad" (
  "ID_RangoEdad" int NOT NULL,
  "DescripcionRangoEdad" varchar(20) NOT NULL,
  PRIMARY KEY ("ID_RangoEdad")
);

