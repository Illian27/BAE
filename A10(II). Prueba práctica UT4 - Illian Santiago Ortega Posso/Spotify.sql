-- Hecho por: Illian Santiago Ortega Posso
-- Apartado 1
-- Base de datos
drop database if exists SPOTIFY;
create database if not exists SPOTIFY;
SET NAMES 'utf8mb4';
USE SPOTIFY;

-- Tablas
CREATE TABLE PLAYLIST(
CodigoLista INT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,  
Nombre VARCHAR(25) not null,
Duración time, 
FechaCreacion date, 
Categoría varchar(30), 
Imagen TEXT
);

CREATE TABLE ARTISTA(
Nombre varchar(25) primary key not null, 
Nacionalidad varchar(30) not null,  
AñoLanzamiento year(4),
Foto text,
Tipo enum('Individual','Grupo')
);

CREATE TABLE ALBUM(
CodigoAlbum int UNSIGNED primary KEY auto_increment NOT NULL, 
Título VARCHAR(25) not null, 
Discográfica VARCHAR(25), 
FechaLanzamiento datetime not null,
Recaudación MEDIUMINT,
Portada TEXT,
Artista varchar(25),
CONSTRAINT FK_Artista_Album foreign key(Artista) references ARTISTA(Nombre) ON DELETE cascade
);

CREATE TABLE CANCION(
CodigoCancion int UNSIGNED PRIMARY KEY auto_increment NOT NULL,  
Título VARCHAR(25) not null, 
TextoLetra TEXT, 
Duración time, 
NumReproducciones INT, 
Artista varchar(25),
Album int unsigned,
CONSTRAINT FK_Artista_Cancion foreign key(Artista) references ARTISTA(Nombre) on delete cascade,
CONSTRAINT FK_Album foreign key(Album) references ALBUM(CodigoAlbum)
);

CREATE TABLE PLAYLISTCANCION(
Lista int unsigned PRIMARY KEY NOT NULL, 
Cancion INT UNSIGNED, 
FechaAñadida datetime,
CONSTRAINT FK_Cancion foreign key(Cancion) references CANCION(CodigoCancion)
);

-- INSERTS
insert into PLAYLIST (Nombre, Duración, FechaCreacion, Categoría, Imagen) values
("Hits1990","50:30","2023-01-01","Exitos",NULL),
("In Life","45:15","2023-05-25","Conciertos",NULL),
("Pure Rock","35:40","2023-03-21","Estado de animo",NULL),
("All Love","25:30","2023-01-17","Relax",NULL);

insert into ARTISTA (Nombre, Nacionalidad, AñoLanzamiento, Foto,Tipo) values
("Dire Straits", "Britanica", 1978,"DireStraits/image.jpg","Grupo"),
("Carlos Santana", "Mexicana", 1966,"Santana/image.jpg","Individual"),
("Bob Marley", "Jamaicano", 1962,"Marley/image.jpg","Individual"),
("Queen", "Británica", 1970,"Queen/image.jpg","Grupo");

insert into ALBUM (Título, Discográfica, FechaLanzamiento,Recaudación, Portada, Artista) values
("on every street","Mercury Records","1991-09-10",1000000,"DireStraits/onevery.jpg","Dire Straits"),
("supernatural","Columbia Records","1999-05-15",2000000,"Santana/supernatural.jpg","Carlos Santana"),
("KAYA","Trojan Records","1978-11-18",2000000,"Marley/Kaya.jpg","Bob Marley"),
("brother in arms","Mercury Records","1985-06-01",500000,"DireStraits/brother.jpg","Dire Straits"),
("shaman","Columbia Records","2002-07-25",1000000,"Santana/Shaman.jpg","Carlos Santana"),
("made in heaven","Hollywood Records","1995-11-06",2000000,"Queen/heaven.jpg","Queen"),
("a kind of magic","Hollywood Records","1986-06-02",2000000,"Queen/magic.jpg","Queen"),
("the miracle","Hollywood Records","1989-06-02",2000000,"Queen/miracle.jpg","Queen");

insert into CANCION (Título, TextoLetra, Duración, NumReproducciones, Artista, Album) values
("Bothers in Arms",NULL,"03:25",12026,"Dire Straits",1),
("Romeo and Juliet",NULL,"04:06",1138,"Dire Straits",1),
("Maria Maria",NULL,"04:39",22050,"Carlos Santana",2),
("Corazon Espinado",NULL,"03:55",18580,"Carlos Santana",2),
("Is this love",NULL,"03:52",21000,"Bob Marley",3),
("Crisis",NULL,"03:55",17480,"Bob Marley",3),
("Walk of life",NULL,"03:18",10125,"Dire Straits",4),
("Shaman",NULL,"03:10",12580,"Carlos Santana",5),
("One year of love",NULL,"03:40",60900,"Queen",7),
("I want it all",NULL,"04:50",12300,"Queen",8),
("Heaven for everyone",NULL,"05:00",50100,"Queen",6);

insert into PLAYLISTCANCION (Lista, Cancion, FechaAñadida) values
(1,1,"2018-01-01"),
(2,2,"2018-01-03"),
(3,3,"2018-01-02"),
(4,4,"2019-05-25"),
(5,5,"2019-05-27"),
(6,6,"2019-05-26"),
(7,7,"2019-03-21"),
(8,8,"2019-03-21"),
(9,9,"2019-03-21"),
(10,10,"2020-01-17"),
(11,11,"2020-01-17"),
(12,3,"2020-01-17");