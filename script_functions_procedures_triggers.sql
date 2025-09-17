// Función para mostrar el nombre completo del primer alumno que se matriculó en la Academia

DELIMITER %%

CREATE FUNCTION f_nombre_completo_primer_alumno ()
RETURNS VARCHAR(100) READS SQL DATA
BEGIN

	DECLARE v_nombre_alumno VARCHAR(45);

	DECLARE v_apellido_alumno VARCHAR(45); 

    SELECT nombre_alumno, apellido_alumno

    INTO v_nombre_alumno, v_apellido_alumno

    FROM alumno WHERE id_alumno = 1;

	RETURN concat(v_nombre_alumno,' ',v_apellido_alumno);
		

END

 %%

select f_nombre_completo_primer_alumno ();

select* from alumno;


// Función para mostrar el total de ventas acumuladas

DELIMITER %%

CREATE FUNCTION f_ventas_acumuladas ()
RETURNS DECIMAL (12) DETERMINISTIC
BEGIN

	DECLARE v_ventas_acumuladas DECIMAL (12);

	SELECT SUM(total_factura) INTO v_ventas_acumuladas FROM factura;
    
	RETURN v_ventas_acumuladas;
		
END

 %%
 
 SELECT f_ventas_acumuladas();


// Procedimiento para visualizar los datos de los alumnos que hayan obtenido, por lo menos una vez, la calificación “10” en un examen

DELIMITER //

CREATE PROCEDURE sp_alumnos_calificacion_sobresaliente ()

BEGIN
SELECT DISTINCT id_alumno, nombre_alumno, apellido_alumno, calificacion_examen
FROM examen INNER JOIN alumno ON (id_alumno = id_alumno_examen)
WHERE calificacion_examen = 10;

END
//

CALL sp_alumnos_calificacion_sobresaliente();


// Procedimiento para contar la cantidad de matrículas realizadas durante el año actual

DELIMITER //

CREATE PROCEDURE sp_matriculas_año_actual ()

BEGIN
SELECT COUNT(*) id_matricula
FROM Matrículas
WHERE fecha_matricula BETWEEN '2024-01-01' AND NOW();

END
//

CALL sp_matriculas_año_actual ();


// Trigger que almacena registros en una nueva tabla llamada “auditoria_carga_calificaciones” cada vez que se insertan nuevos registros en la tabla Examen

CREATE TABLE auditoria_carga_calificaciones
(
id_auditoria INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
nombre_accion VARCHAR (60),
fecha_accion DATETIME not null DEFAULT CURRENT_TIMESTAMP
);


DELIMITER //
CREATE TRIGGER tr_auditoria_carga_calificaciones AFTER
INSERT ON Examen
FOR EACH ROW 
BEGIN
	INSERT INTO auditoria_carga_calificaciones (nombre_accion) 
    VALUE (concat("Calificación ",NEW.calificacion_examen," ","cargada correctamente en alumno ID N° ", NEW.id_alumno_examen));
END
//

select * from Examen;

select * from auditoria_carga_calificaciones;


// Trigger que almacena registros en una nueva tabla llamada “auditoria_carga_alumnos” cada vez que se insertan nuevos registros en la tabla Alumno

CREATE TABLE auditoria_carga_alumnos
(
id_auditoria_alumno INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
descripcion_accion VARCHAR (60),
fecha_accion DATETIME not null DEFAULT CURRENT_TIMESTAMP
);


DELIMITER //
CREATE TRIGGER tr_auditoria_carga_alumnos AFTER
INSERT ON Alumno
FOR EACH ROW 
BEGIN
	INSERT INTO auditoria_carga_alumnos (descripcion_accion) 
    VALUE (concat("El alumno ID N° ", NEW.id_alumno," ","acaba de ser cargado o modificado"));
END
//

SELECT * FROM auditoria_carga_alumnos;
