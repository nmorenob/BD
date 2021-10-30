drop procedure crdveh;
delimiter $$
CREATE PROCEDURE crdveh 
(		
		IN marext VARCHAR(50),	-- marca
		IN plaext VARCHAR(6),	-- placa
		IN idpext NUMERIC(12), 	-- idPersona
		IN idtext NUMERIC(12),	-- idTipo
		IN flgext VARCHAR(01)
) 
	BEGIN 
		DECLARE keyint NUMERIC(12); 
        DECLARE respuesta varchar(100);
			
			/*Crear registro*/
			IF flgext = 'C' 
			THEN 
				IF (SELECT COUNT(*) FROM vehiculo WHERE placa = plaext) > 0
					THEN
						SET respuesta ='El vehículo ya existe';
					ELSE IF (SELECT COUNT(*) FROM persona WHERE idPersona = idpext) = 0	
					THEN
						SET respuesta ='El registro de la persona no existe';
					ELSE IF (SELECT COUNT(*) FROM tipovehiculo WHERE ipTipo = idtext) = 0
					THEN
						SET respuesta ='El tipo de vehículo no existe';
					ELSE 
							SELECT	ifnull(MAX(idVehiculo),0) + 1
                            into keyint
							FROM	vehiculo;
                            
						INSERT INTO vehiculo VALUES(
									keyint,
									marext,
									plaext,
									idpext,
									idtext
								);
						 SET respuesta = 'Registro exitoso';
						END IF;
					END IF; 
				END IF;
			END IF;
        
		/*Actualizar registro*/
        IF flgext = 'U' 
			THEN 
				IF (SELECT COUNT(*) FROM vehiculo WHERE placa = plaext) = 0
					THEN
						SET respuesta ='El vehículo no existe';
					ELSE
						UPDATE vehiculo 
						SET		marca = marext,
								placa = plaext,
								idPersona = idpext,
								idTipo =	idtext
						where 	placa = plaext;	
						SET respuesta = 'Actualización exitosa';
			END IF;
		END IF;
        select respuesta;
END $$
delimiter ;