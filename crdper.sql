drop procedure crdper;
delimiter $$
CREATE PROCEDURE crdper 
(		
		IN nomext VARCHAR(50),	-- nombre
		IN apeext VARCHAR(50),	-- apellido
		IN docext VARCHAR(50), 	-- documento
		IN tddext VARCHAR(03),	-- tipo documento
		IN dirext VARCHAR(50),	-- direccion
		IN telext NUMERIC(10),	-- telefono
		IN flgext VARCHAR(01)
) 
	BEGIN 
		DECLARE keyint NUMERIC(12); 
        DECLARE respuesta varchar(100);
			
			/*Crear registro*/
			IF flgext = 'C' 
			THEN 
				IF (SELECT COUNT(*) FROM persona WHERE documento = docext) > 0
					THEN
						SET respuesta ='El registro ya existe';
					ELSE 
							SELECT	ifnull(MAX(idPersona),0) + 1
                            into keyint
							FROM	persona;
                            
						INSERT INTO persona VALUES(
									keyint,
									nomext,
									apeext,
									docext,
									tddext,
									dirext,
									telext
								);
						 SET respuesta = 'Registro exitoso';
			END IF;
		END IF; 
        
		/*Actualizar registro*/
        IF flgext = 'U' 
			THEN 
				IF (SELECT COUNT(*) FROM persona WHERE documento = docext) = 0
					THEN
						SET respuesta ='El registro no existe';
					ELSE                            
						UPDATE persona 
						SET		nombre = nomext,
								apellido = apeext,
								tipoDoc = tddext,
								direccion =	dirext,
								telefono = 	telext
						where 	documento = docext;	
						SET respuesta = 'Actualización exitosa';
			END IF;
		END IF;
        select respuesta;
END $$
delimiter ;