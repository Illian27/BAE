use Spotify;

// 1
db.listas.insertMany([
    {
        nombre_lista: "Melodías de Medianoche",
        alias_creador: "LunaMística",
        fecha_ultima_modificacion: "2024:04:22",
        numero_seguidores: 1520,
        canciones:[
        // Array de objetos
        {
            titulo: "Nocturne in Blue",
            artista: "Jazzy Echoes"
        },
        {
            titulo: "Midnight Pulse",
            artista: "The Velvet Shadows"
        }],
        idiomas: ["Ingles", "Frances", "Castellano", "Aleman"]
    },
    {
        nombre_lista: "Viaje Solar",
        alias_creador: "AstroNomad",
        fecha_ultima_modificacion: "2024:04:20",
        numero_seguidores: 2300,
        canciones:[
        // Array de objetos
        {
            titulo: "Sunbeam Surf",
            artista: "Solar Vibes"
        },
        {
            titulo: "Lunar Ride",
            artista: "Galaxy Tourist"
        }],
        idiomas: ["Ingles", "Frances", "Castellano", "Aleman"]
    },
    {
        nombre_lista: "Éxitos de Garage",
        alias_creador: "RockinRudy",
        fecha_ultima_modificacion: "2024:04:18",
        numero_seguidores: 985,
        canciones:[
        // Array de objetos
        {
            titulo: "Grease Lightning",
            artista: "The Greasers"
        },
        {
            titulo: "Broken Strings",
            artista: "The Wreckers"
        }],
        idiomas: ["Ingles", "Frances", "Castellano", "Aleman"]
    },
    {
        nombre_lista: "Jazz de Media Tarde",
        alias_creador: "SmoothOperator",
        fecha_ultima_modificacion: "2024:04:21",
        numero_seguidores: 1345,
        canciones:[
        // Array de objetos
        {
            titulo: "Smooth Sailing",
            artista: "Cool Cats"
        },
        {
            titulo: "Evening Drizzle",
            artista: "The Jazz Drops"
        }],
        idiomas: ["Ingles", "Frances", "Castellano", "Aleman"]
    },
    {
        nombre_lista: "Cantos del Bosque",
        alias_creador: "GreenWhisperer",
        fecha_ultima_modificacion: "2024:04:19",
        numero_seguidores: 789,
        canciones:[
        // Array de objetos
        {
            titulo: "Whispering Leaves",
            artista: "Nature's Voice"
        },
        {
            titulo: "Hidden Trails",
            artista: "Silent Footsteps"
        }],
        idiomas: ["Ingles", "Frances", "Castellano", "Aleman"]
    }
]);

// 2
// Actualizar un documento
db.listas.upateOne(
    {}
);

// Actualizar todos los documentos
db.listas.updateMany(
    {}
);

// Reemplazar en el documento
db.listas.replaceOne(
    {}
);

db.listas.find()