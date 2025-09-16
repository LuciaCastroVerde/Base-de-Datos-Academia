// Vista para obtener el total facturado por ventas anualmente
  
CREATE OR REPLACE VIEW ventas_por_año AS
(SELECT YEAR(fecha_factura), SUM(total_factura)
 FROM factura GROUP BY YEAR(fecha_factura));

SELECT * FROM ventas_por_año;

// Vista para obtener los datos de alumnos que estén matriculados en más de un curso
  
CREATE OR REPLACE VIEW alumno_multi_matricula AS
(SELECT id_alumno, apellido_alumno, nombre_alumno
 FROM Matrículas as m INNER JOIN alumno as a ON (m.id_alumno_matricula = a.id_alumno)
 GROUP BY id_alumno_matricula
 HAVING count(m.id_alumno_matricula) > 1);

SELECT * FROM alumno_multi_matricula;

// Vista para analizar la performance comercial de cada vendedor

CREATE OR REPLACE VIEW ventas_acumuladas_vendedor AS
(SELECT apellido_vendedor, nombre_vendedor, id_vendedor, SUM(total_factura)
 FROM factura INNER JOIN Matrículas ON (id_matricula_factura = id_matricula)
 INNER JOIN Vendedor ON (id_vendedor_matricula = id_vendedor)
 GROUP BY (id_vendedor)
 );

SELECT * FROM ventas_acumuladas_vendedor;

// Vista para analizar la matriculación por curso durante el año 2024

CREATE OR REPLACE VIEW matriculas_por_curso_2024 AS
(SELECT id_curso, nombre_curso, COUNT(id_curso_matricula)
 FROM Matrículas INNER JOIN Curso ON (id_curso_matricula = id_curso)
 WHERE YEAR(fecha_matricula) = "2024"
 GROUP BY (id_curso_matricula)
 );

SELECT * FROM matriculas_por_curso_2024;

// Vista para conocer cantidad de alumnos matriculados en cada modalidad de cursada por año

CREATE OR REPLACE VIEW modalidad_cursos_por_año AS
(SELECT YEAR(fecha_matricula), modalidad_curso, COUNT(id_modalidad_matricula)
FROM Matrículas INNER JOIN Modalidad_curso ON (id_modalidad_matricula = id_modalidad)
GROUP BY YEAR(fecha_matricula), id_modalidad_matricula
);

SELECT * FROM modalidad_cursos_por_año;
