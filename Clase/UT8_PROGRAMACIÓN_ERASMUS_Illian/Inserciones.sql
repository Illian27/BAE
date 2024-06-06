-- Hecho por: Illian Santiago Ortega Posso
-- Aquí insertaré los datos
insert into Profesor(DNI, Nombre, Telefono, email) values
("12345678A", "Jose", "612345678", "jose@gmail.com"),
("12345678B", "Manuel", "612345678", "manuel@gmail.com");

insert into Tutor(Profesor_DNI, Numero_horas) values
("12345678A", 8),
("12345678B", 7);

insert into Colaboradores(Profesor_DNI, Años_experiencia) values
("12345678A", 5),
("12345678B", 6);

insert into Documentación(DNI, CV, Carta, Tarjeta) values
("Entregado", "Entregado", "No entregado", "No entregado"),
("No entregado", "Entregado", "No entregado", "Entregado");

insert into Entrevista(Destreza) values
("Lógica"),
("Conocimiento");

insert into Domicilio(Provincia, Municipio, CodigoPostal) values
("Las Palmas", "Puerto del Rosario", 35600),
("Las Palmas", "Puerto del Rosario", 35612);

insert into Ciclo(Tipo, Familia, Denominacion) values
("Medio", "Informatica", "BAE"),
("Superior", "Informatica","PRO");

insert into Prueba(Idioma) values
("Ingles"),
("Aleman");

insert into Alumno(DNI, Nombre, Apellidos, FechaNacimiento, Domicilio_idDomicilio, Ciclo_idCiclo, Calle) values
("12345678A", "Juan", "Peinado", "2004-05-25", 1, 1, "Zaragoza"),
("12345678B", "Justin", "Blanco", "2004-12-27", 2, 2, "Camelleros");

insert into No_aceptado(Alumno_DNI) values
("12345678A"),
("12345678B");

insert into Movilidad(PeriodoDuracion, NumeroPlazas, tipo) values
(1, 19, "KA103"),
(1, 20, "KA116");

insert into Aceptado(Alumno_DNI, Movilidad_idMovilidad, FechaInicio, FechaFin) values
("12345678A", 1, "2024-01-01", "2024-07-26"),
("12345678B", 2, "2024-02-02", "2024-12-12");

insert into Aceptado_pais(Aceptado_Alumno_DNI, Pais, Idioma)values
("12345678A", "Alemania", "Aleman"),
("12345678B", "Inglaterra", "Ingles");

insert into Curso_idioma(Idioma, Nivel, Duracion) values
("Ingles", "Bajo", "00:10:00"),
("Aleman", "Medio", "01:00:00");

insert into Pruebas_nivel(Idioma, Nivel, NºPreguntasCorrectas, FechaRealizacion, Tipo) values
("Frances", "A1", 10, "2024-04-02", "Primera"),
("Castellano", "C1", 20, "2024-02-04", "Segunda");

insert into UsuarioOLS values
(1, "12345678A", "hola", "123", 1, 1, "Puntual", "Castellano", "12345678A", 1, "12345678A", "Juan", "juan@gmail.com"),
(2, "12345678B", "adios", "123", 2, 2, "Retrasado", "Frances", "12345678B", 2, "12345678B", "Justin", "justin@gmail.com");

insert into Reuniones(Fecha) values
("2024-02-02"),
("2024-07-07");

insert into Clases(Idioma, Nivel, Profesor_DNI) values
("Castellano", "Básico", "12345678A"),
("Ingles", "Intermedio", "12345678B");

insert into Entrega(Alumno_DNI, Tutor_Profesor_DNI, Documento_idDocumento, Fecha) values
("12345678A", "12345678A", 1, "2024-04-04"),
("12345678B", "12345678B", 2, "2023-03-03");

insert into Contacta(Alumno_DNI, Colaboradores_Profesor_DNI) values
("12345678A", "12345678A"),
("12345678B", "12345678B");

insert into Realiza_entrevista(Alumno_DNI, Entrevista_idEntrevista, Colaboradores_Profesor_DNI, Calificacion) values
("12345678A", 1, "12345678A", 6),
("12345678B", 2, "12345678B", 10);

insert into Realiza_prueba(Alumno_DNI, Prueba_idPrueba) values
("12345678A", 1),
("12345678B", 2);

insert into Asesora(Aceptado_AlumnoAsesora_DNI, Aceptado_AlumnoAsesorado_DNI1)values
("12345678A", "12345678B"),
("12345678B", "12345678A");

insert into Aceptado_has_clases(Aceptado_Alumno_DNI, Clases_idClases)values
("12345678A", 1),
("12345678B", 2);

insert into Da(Profesor_DNI, Reuniones_idReuniones) values
("12345678A", 1),
("12345678B", 2);