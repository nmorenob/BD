create database parking;

CREATE
  TABLE bahia
  (
    idBahia       NUMERIC (12) NOT NULL ,
    idParqueadero NUMERIC (12) NOT NULL ,
    disponible BIT ,
    CONSTRAINT bahia_PK PRIMARY KEY CLUSTERED (idBahia)
  );
CREATE UNIQUE INDEX bahia_idBahia_IDX ON bahia
(
  idBahia ASC
);
CREATE
  INDEX bahia_idParqueadero_IDX ON bahia
  (
    idParqueadero ASC
  );

CREATE
  TABLE pago
  (
    idPago     NUMERIC (12) NOT NULL ,
    idBahia    NUMERIC (12) NOT NULL ,
    idVehiculo NUMERIC (12) NOT NULL ,
    tiempo BIGINT ,
    costo BIGINT ,
    fecha DATE ,
    estado BIT ,
    CONSTRAINT pago_PK PRIMARY KEY CLUSTERED (idPago)
  );
CREATE UNIQUE INDEX pago_idPago_IDX ON pago
(
  idPago ASC
);
CREATE
  INDEX pago_idBahia_IDX ON pago
  (
    idBahia ASC
  );
CREATE
  INDEX pago_idVehiculo_IDX ON pago
  (
    idVehiculo ASC
  );

CREATE
  TABLE parqueadero
  (
    IdParqueadero NUMERIC (12) NOT NULL ,
    nombre        VARCHAR (50) ,
    ubicacion     VARCHAR (50) ,
    CONSTRAINT parqueadero_PK PRIMARY KEY CLUSTERED (IdParqueadero)
  );
CREATE UNIQUE INDEX parqueadero_IdParqueadero_IDX ON parqueadero
(
  IdParqueadero ASC
);

CREATE
  TABLE persona
  (
    idPersona NUMERIC (12) NOT NULL ,
    nombre    VARCHAR (50) ,
    apellido  VARCHAR (50) ,
    documento VARCHAR (50) ,
    tipoDoc   VARCHAR (3) ,
    direccion VARCHAR (50) ,
    telefono  NUMERIC (10) ,
    CONSTRAINT persona_PK PRIMARY KEY CLUSTERED (idPersona)
  );
CREATE UNIQUE INDEX persona_idPersona_IDX ON persona
(
  idPersona ASC
);

CREATE
  TABLE tarifa
  (
    idTarifa NUMERIC (12) NOT NULL ,
    costo BIGINT NOT NULL ,
    idTipo NUMERIC (12) NOT NULL ,
    CONSTRAINT tarifa_PK PRIMARY KEY CLUSTERED (idTarifa)
  );
CREATE UNIQUE INDEX tarifa_idTarifa_IDX ON tarifa
(
  idTarifa ASC
);
CREATE
  INDEX tarifa_idTipo_IDX ON tarifa
  (
    idTipo ASC
  );

CREATE
  TABLE tipoVehiculo
  (
    ipTipo NUMERIC (12) NOT NULL ,
    Clase  VARCHAR (20) ,
    CONSTRAINT tipoVehiculo_PK PRIMARY KEY CLUSTERED (ipTipo)
  );
CREATE UNIQUE INDEX tipoVehiculo_ipTipo_IDX ON tipoVehiculo
(
  ipTipo ASC
);

CREATE
  TABLE vehiculo
  (
    idVehiculo NUMERIC (12) NOT NULL ,
    marca      VARCHAR (50) ,
    placa      VARCHAR (6) ,
    idPersona  NUMERIC (12) NOT NULL ,
    idTipo     NUMERIC (12) NOT NULL ,
    CONSTRAINT vehiculo_PK PRIMARY KEY CLUSTERED (idVehiculo)
  );
CREATE UNIQUE INDEX vehiculo_idVehiculo_IDX ON vehiculo
(
  idVehiculo ASC
);
CREATE
  INDEX vehiculo_idPersona_IDX ON vehiculo
  (
    idPersona ASC
  );
CREATE
  INDEX vehiculo_idTipo_IDX ON vehiculo
  (
    idTipo ASC
  );

ALTER TABLE bahia
ADD CONSTRAINT bahia_parqueadero_FK FOREIGN KEY
(
idParqueadero
)
REFERENCES parqueadero
(
IdParqueadero
)
ON
DELETE
  NO ACTION ON
UPDATE NO ACTION
;

ALTER TABLE pago
ADD CONSTRAINT pago_bahia_FK FOREIGN KEY
(
idBahia
)
REFERENCES bahia
(
idBahia
)
ON
DELETE
  NO ACTION ON
UPDATE NO ACTION
;

ALTER TABLE pago
ADD CONSTRAINT pago_vehiculo_FK FOREIGN KEY
(
idVehiculo
)
REFERENCES vehiculo
(
idVehiculo
)
ON
DELETE
  NO ACTION ON
UPDATE NO ACTION
;

ALTER TABLE tarifa
ADD CONSTRAINT tarifa_tipoVehiculo_FK FOREIGN KEY
(
idTipo
)
REFERENCES tipoVehiculo
(
ipTipo
)
ON
DELETE
  NO ACTION ON
UPDATE NO ACTION
;

ALTER TABLE vehiculo
ADD CONSTRAINT vehiculo_persona_FK FOREIGN KEY
(
idPersona
)
REFERENCES persona
(
idPersona
)
ON
DELETE
  NO ACTION ON
UPDATE NO ACTION
;

ALTER TABLE vehiculo
ADD CONSTRAINT vehiculo_tipoVehiculo_FK FOREIGN KEY
(
idTipo
)
REFERENCES tipoVehiculo
(
ipTipo
)
ON
DELETE
  NO ACTION ON
UPDATE NO ACTION
;



