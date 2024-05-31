-- Hecho por: Illian Santiago Ortega Posso
-- Apartado 2
-- 1º
ALTER TABLE PLAYLIST MODIFY CategorÍa ENUM('Éxitos', 'Conciertos', 'Indie', 'Relax', 'Estado de animo', 'varios');


-- 2º
-- alter table CANCION add check(minute(Duración) < "10");
-- alter table PLAYLIST add check(hour(Duración) < 1);

-- 3º He puesto todos los años en 2023 porque si no, no se cumple el check
alter table PLAYLIST add check(year(FechaCreacion) >= 2024 - 3);
-- alter table PLAYLIST add check(year(FechaCreacion) >= year(current_date()) - 3);

-- 4º 
alter table ALBUM add check(Discográfica like "%Records");

-- 5º Modifique los titulos porque si no, no se cumple el check
alter table AlBUM add check(Título rlike '[a-z]||[A-Z]');


-- Apartado 3
-- alter table ALBUM add column Género enum('Pop', 'Jazz', 'Rock', 'Reggae', 'Clásica') default('') after Discográfica;


-- Apartado 4
/*
1º
No es correcta debido a que no se inserta la nacionalidad que es obligatoria y "Cantante" no es un tipo

2º
No es correcta debido a que la fecha de lanzamiento no se especifica y es obligatoria, el título tiene que estar todo 
en mayusculas o en minusculas. Recaudación es un int y no puede ir con comillas y Michael Jackson no esta definido como un artista

-- 3º
No es correcto porque duración es un time, y se intenta insertar un date, NumReproducciones no se inserta y ni el artista
ni el album estan definidos (este último es un int, no una cadena de texto).
*/

-- Apartado 5
insert into ARTISTA(Nombre, Nacionalidad, AñoLanzamiento, Foto,Tipo)
values("Michel Jackson", "Americana", 1982, "Michael_Jackson/Thriller.jpg", "Individual");

insert into ALBUM(Título, Discográfica, FechaLanzamiento,Recaudación, Portada, Artista) 
values("thiller", "Sony", "1982-11-30", 1000000, NULL, "Michael Jackson");

-- Apartado 6
-- DELETE FROM PLAYLIST WHERE Imagen = null;