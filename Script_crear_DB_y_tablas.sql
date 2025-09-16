CREATE DATABASE Academia;

USE Academia;

CREATE TABLE Aula
(
id_aula INT NOT NULL auto_increment PRIMARY KEY,
nombre_aula varchar(45) not null
);

CREATE TABLE Curso
(
id_curso INT not null auto_increment PRIMARY KEY,
nombre_curso varchar(60) not null,
carga_horaria_curso INT not null
);

CREATE TABLE Forma_de_pago
(
id_forma_de_pago INT not null auto_increment PRIMARY KEY,
nombre_forma_de_pago varchar(45) not null
);

CREATE TABLE Género
(
id_genero INT not null auto_increment PRIMARY KEY,
nombre_genero varchar(45) not null
);

CREATE TABLE Modalidad_curso
(
id_modalidad INT not null auto_increment PRIMARY KEY,
modalidad_curso varchar(45) not null
);

CREATE TABLE Profesor
(
id_profesor INT not null auto_increment PRIMARY KEY,
apellido_profesor varchar(45) not null,
nombre_profesor varchar(45) not null,
DNI_profesor INT not null,
fecha_nacimiento_profesor DATE not null,
id_genero_profesor INT not null,
especialidad_profesor varchar(45) not null,
email_profesor varchar(45) not null,
FOREIGN KEY (id_genero_profesor) REFERENCES Género (id_genero)
);

CREATE TABLE Vendedor
(
id_vendedor INT not null auto_increment PRIMARY KEY,
apellido_vendedor varchar(45) not null,
nombre_vendedor varchar(45) not null,
fecha_nacimiento_vendedor DATE not null,
DNI_vendedor INT not null,
id_genero_vendedor INT not null,
email_vendedor varchar(45) not null,
FOREIGN KEY (id_genero_vendedor) REFERENCES Género (id_genero)
);

CREATE TABLE Alumno
(
id_alumno INT NOT NULL auto_increment PRIMARY KEY,
DNI_alumno INT not null,
apellido_alumno varchar(45) not null,
nombre_alumno varchar(45) not null,
fecha_nacimiento_alumno date not null,
telefono_alumno INT not null,
dirección_alumno varchar(45) not null,
id_genero_alumno INT not null,
email_alumno varchar(45) not null,
FOREIGN KEY (id_genero_alumno) REFERENCES Género (id_genero)
);

CREATE TABLE Clase
(
id_clase INT NOT NULL auto_increment PRIMARY KEY,
nombre_clase varchar(60) not null,
id_profesor_clase INT not null,
id_aula_clase INT not null,
fecha_hora_clase datetime(6) not null,
id_modalidad_clase INT not null,
FOREIGN KEY (id_profesor_clase) REFERENCES Profesor (id_profesor),
FOREIGN KEY (id_aula_clase) REFERENCES Aula (id_aula),
FOREIGN KEY (id_modalidad_clase) REFERENCES Modalidad_curso (id_modalidad)
);

CREATE TABLE Examen
(
id_examen INT not null auto_increment PRIMARY KEY,
nombre_examen varchar(60) not null,
id_alumno_examen INT not null,
id_curso_examen INT not null,
calificacion_examen decimal(5) not null,
fecha_examen DATE not null,
id_modalidad_examen INT not null,
id_aula_examen INT not null,
FOREIGN KEY (id_alumno_examen) REFERENCES Alumno (id_alumno),
FOREIGN KEY (id_curso_examen) REFERENCES Curso (id_curso),
FOREIGN KEY (id_modalidad_examen) REFERENCES Modalidad_curso (id_modalidad),
FOREIGN KEY (id_aula_examen) REFERENCES Aula (id_aula)
);

CREATE TABLE Matrículas
(
id_matricula INT not null auto_increment PRIMARY KEY,
id_alumno_matricula INT not null,
fecha_matricula DATE not null,
id_curso_matricula INT not null,
id_modalidad_matricula INT not null,
id_vendedor_matricula INT not null,
FOREIGN KEY (id_alumno_matricula) REFERENCES Alumno (id_alumno),
FOREIGN KEY (id_curso_matricula) REFERENCES Curso (id_curso),
FOREIGN KEY (id_modalidad_matricula) REFERENCES Modalidad_curso (id_modalidad),
FOREIGN KEY (id_vendedor_matricula) REFERENCES Vendedor (id_vendedor)
);

CREATE TABLE Factura
(
id_factura INT not null auto_increment PRIMARY KEY,
tipo_factura varchar(3) not null,
fecha_factura DATE not null,
titular_factura varchar(60) not null,
id_curso_factura INT not null,
id_forma_de_pago_factura INT not null,
total_factura decimal(12) not null,
id_matricula_factura INT not null,
FOREIGN KEY (id_curso_factura) REFERENCES Curso (id_curso),
FOREIGN KEY (id_forma_de_pago_factura) REFERENCES Forma_de_pago (id_forma_de_pago),
FOREIGN KEY (id_matricula_factura) REFERENCES Matrículas (id_matricula)
);
