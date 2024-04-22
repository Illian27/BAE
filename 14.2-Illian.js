use Spotify;

db.listas.insertMany([
    {
        nombre_lista: string,
        alias_creador: string,
        fecha_ultima_modificacion:date,
        numero_seguidores: int,
        canciones:[
        // Array de objetos
        {
            titulo: string,
            artista: string
        },
        {
            titulo: string,
            artista: string
        }],
        idiomas: array
    }
]);