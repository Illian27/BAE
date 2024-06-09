-- Hecho por: Illian Santiago Ortega Posso

-- Creando la base de datos
drop database if exists Erasmus;
create database if not exists Erasmus character set utf8mb4 collate utf8mb4_0900_as_Cs;
use Erasmus;

-- Creando las tablas
-- Generalidad de profesor
create table if not exists Profesor(
	DNI char(9) primary key not null check(DNI rlike "^[0-9]{8}[A-Z]{1}"),
    Nombre varchar(15) not null check(Nombre rlike "^[A-Z]{1}"),
    Telefono char(9) not null check(Telefono rlike "^[6-7]{1}"),
    email varchar(40) not null check(email rlike "[@gmail.com]{1}")
);

create table if not exists Tutor(
	Profesor_DNI char(9) primary key not null,
    Numero_horas tinyint not null default 32,
    foreign key (Profesor_DNI) references Profesor(DNI)
);

create table if not exists Colaboradores(
	Profesor_DNI char(9) primary key not null,
    Años_experiencia tinyint not null default 3,
    foreign key (Profesor_DNI) references Profesor(DNI)
);


-- Generalidad de documento
create table if not exists Documentación(
	idDocumento int unsigned auto_increment primary key not null,
    DNI Enum("Entregado", "No entregado") default 'No entregado',
    CV Enum("Entregado", "No entregado") default 'No entregado',
    Carta Enum("Entregado", "No entregado") default 'No entregado',
    Tarjeta Enum("Entregado", "No entregado") default 'No entregado'
);


-- Entrevista
create table if not exists Entrevista(
	idEntrevista int unsigned primary key auto_increment not null,
    Destreza varchar(15) not null,
    Fecha date
);

	
-- Relacionado con alumno
create table if not exists Domicilio(
	idDomicilio int unsigned primary key auto_increment not null,
    Provincia varchar(20),
    Municipio varchar(50),
    CodigoPostal int check(CodigoPostal rlike "[0-9]{5}")
);

create table if not exists Ciclo(
	idCiclo int unsigned primary key auto_increment not null,
    Tipo enum("Medio", "Superior") not null,
    Familia varchar(20),
    Denominacion varchar(20) not null
);

create table if not exists Prueba(
	idPrueba int unsigned primary key auto_increment not null,
    Idioma enum("Castellano", "Ingles", "Frances", "Aleman"),
    Fecha date
);

create table if not exists Alumno(
	DNI char(9) primary key not null check(DNI rlike "^[0-9]{8}[A-Z]{1}"),
    Nombre varchar(15) not null,
    Apellidos varchar(35) not null,
    FechaNacimiento datetime not null,
    Domicilio_idDomicilio int unsigned,
    Ciclo_idCiclo int unsigned,
    Calle varchar(50),
    foreign key (Domicilio_idDomicilio) references Domicilio(idDomicilio),
    foreign key (Ciclo_idCiclo) references Ciclo(idCiclo)
);

create table if not exists No_aceptado(
	Alumno_DNI char(9) primary key not null,
    foreign key (Alumno_DNI) references Alumno(DNI)
);

create table if not exists Movilidad(
	idMovilidad int unsigned primary key auto_increment not null,
    PeriodoDuracion smallint unsigned,
    NumeroPlazas tinyint not null,
    tipo enum("KA103", "KA116")
);

create table if not exists Aceptado(
	Alumno_DNI char(9) primary key not null,
    Movilidad_idMovilidad int unsigned not null,
    FechaInicio date not null,
    FechaFin date not null,
    foreign key (Alumno_DNI) references Alumno(DNI),
    foreign key (Movilidad_idMovilidad) references Movilidad(idMovilidad)
);

create table if not exists Aceptado_pais(
	Aceptado_Alumno_DNI char(9) primary key not null,
    Pais varchar(20),
    Idioma enum("Castellano", "Ingles", "Frances", "Aleman"),
    foreign key (Aceptado_Alumno_DNI) references Aceptado(Alumno_DNI)
);


-- Relacionado con Usuario OLS
create table if not exists Curso_idioma(
	idCursoIdioma int unsigned primary key auto_increment not null,
    Idioma enum("Castellano", "Ingles", "Frances", "Aleman"),
    Nivel enum("Bajo", "Medio"),
    Duracion time
);

create table if not exists Pruebas_nivel(
	idPruebasNivel int unsigned primary key auto_increment not null,
    Idioma varchar(10) not null,
    Nivel enum("A1", "A2", "B1", "B2", "C1", "C2") not null,
    NºPreguntasCorrectas tinyint,
    FechaRealizacion date not null,
    Tipo enum("Primera", "Segunda") not null
);

create table if not exists UsuarioOLS(
	idUsuarioOLS int unsigned unique auto_increment not null,
    Aceptado_Alumno_DNI char(9) not null,
    Login varchar(30),
    Pass varchar(50),
    Pruebasnivel_idPruebasnivel int unsigned not null,
    Cursoidioma_idCursoidioma int unsigned not null,
    Participa enum("Puntual", "Retrasado", "NoAsisteInjustificado", "NoAsisteJustificado"),
    Idioma enum("Castellano", "Ingles", "Frances", "Aleman"),
    Profesor_DNI char(9) not null,
    codProyecto int not null,
    Aceptado_Alumno_DNI1 char(9) not null,
    UsuarioOLS varchar(45) not null,
    CorreoAlumno varchar(50) not null,
    foreign key (Aceptado_Alumno_DNI) references Aceptado(Alumno_DNI),
    foreign key (Pruebasnivel_idPruebasnivel) references Pruebas_nivel(idPruebasnivel),
    foreign key (Cursoidioma_idCursoidioma) references Curso_idioma(idCursoidioma),
    foreign key (Profesor_DNI) references Profesor(DNI),
    foreign key (Aceptado_Alumno_DNI1) references Aceptado(Alumno_DNI),
primary key(Aceptado_Alumno_DNI1, idUsuarioOLS, Aceptado_Alumno_DNI));


-- Entidades reuniones y clases
create table if not exists Reuniones(
	idReuniones int unsigned primary key auto_increment not null,
    Fecha date
);

create table if not exists Clases(
	idClases int unsigned primary key auto_increment not null,
    Idioma enum("Castellano", "Ingles", "Frances", "Aleman"),
    Nivel enum("Básico", "Intermedio", "Avanzado"),
    Profesor_DNI char(9) not null,
    foreign key (Profesor_DNI) references Profesor(DNI)
);


-- Relaciones
create table if not exists Entrega(	
	Alumno_DNI char(9) primary key not null,
    Tutor_Profesor_DNI char(9) not null,
    Documento_idDocumento int unsigned not null,
	Fecha date,
    foreign key (Alumno_DNI) references Alumno(DNI),
    foreign key (Tutor_Profesor_DNI) references Tutor(Profesor_DNI),
    foreign key (Documento_idDocumento) references Documentación(idDocumento)
);

create table if not exists Contacta(
	Alumno_DNI char(9) not null,
    Colaboradores_Profesor_DNI char(9) not null,
    foreign key (Alumno_DNI) references Alumno(DNI),
    foreign key (Colaboradores_Profesor_DNI) references Colaboradores(Profesor_DNI),
primary key(Alumno_DNI, Colaboradores_Profesor_DNI));

create table if not exists Realiza_entrevista(
	Alumno_DNI char(9) primary key not null,
	Entrevista_idEntrevista int unsigned not null,
	Colaboradores_Profesor_DNI char(9) not null,
	Calificacion tinyint unsigned not null,
    foreign key (Alumno_DNI) references Alumno(DNI),
    foreign key (Entrevista_idEntrevista) references Entrevista(idEntrevista)
);

create table if not exists Realiza_prueba(
	Alumno_DNI char(9) primary key not null,
    Prueba_idPrueba int unsigned not null,
	foreign key (Alumno_DNI) references Alumno(DNI),
    foreign key (Prueba_idPrueba) references Prueba(idPrueba)
);

create table if not exists Asesora(
	Aceptado_AlumnoAsesora_DNI char(9) not null,
    Aceptado_AlumnoAsesorado_DNI1 char(9) not null,
    foreign key (Aceptado_AlumnoAsesora_DNI) references Aceptado(Alumno_DNI),
    foreign key (Aceptado_AlumnoAsesorado_DNI1) references Aceptado(Alumno_DNI),
primary key(Aceptado_AlumnoAsesora_DNI, Aceptado_AlumnoAsesorado_DNI1));

create table if not exists Aceptado_has_clases(
	Aceptado_Alumno_DNI char(9) not null,
    Clases_idClases int unsigned not null,
    foreign key (Aceptado_Alumno_DNI) references Aceptado(Alumno_DNI),
    foreign key (Clases_idClases) references Clases(idClases),
primary key(Aceptado_Alumno_DNI, Clases_idClases));

create table if not exists Da(
	Profesor_DNI char(9) not null,
    Reuniones_idReuniones int unsigned not null,
	foreign key (Profesor_DNI) references Profesor(DNI),
    foreign key (Reuniones_idReuniones) references Reuniones(idReuniones),
primary key(Profesor_DNI, Reuniones_idReuniones));

SET foreign_key_checks = 0;