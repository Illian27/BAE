use media;

// Ejercicio 1
db.media.insertMany([{
        tipo: "libro",
        titulo: "Java para todos",
        ISBN: "987-1-2344-5334-8",
        editorial: "Anaya",
        Autor: ["Peper Caballero", "Isabel Sanz", "Timoteo Marino"],
        capitulos: 10
    },

    {
        capitulo: 1,
        titulo: "Primeros pasos en JAVA",
        longitud: 20
    },

    {
        capitulo: 2,
        titulo: "Primeros pasos en JAVA",
        longitud: 25
    },

    {
        tipo: "CD",
        Artista: "Los piratas",
        titulo: "Recuerdos",
        canciones: [{
                cancion: 1,
                titulo: "Adios mi barco",
                longitud: "3:20"
            },
            {
                cancion: 2,
                titulo: "Pajaritos",
                longitud: "4:15"
            }
        ]
    },

    {
        tipo: "DVD",
        titulo: "Matrix",
        estreno: 1999,
        actores: ["keanu Reeves", "carry-Anne Moss", "Laurence Fishburne", "Hugo Veaving", "Gloria Foster", "Joe Pantoliano"]
    }
]);

// Ejercicio 2
db.media.updateOne(
    {titulo:"Matrix"},
    {$set:{tipo: "DVD", titulo: "Matrix", estreno: 1999, genero: "accion"}}
);

// Ejercicio 3
db.media.insertOne({
tipo:"Libro",
titulo:"Constantinopla",
capitulos:12,
leidos:3
});

db.media.updateOne(
    {titulo:"Constantinopla"},
    {$inc:{leidos:5}}
);

// Ejercicio 4
db.media.updateOne(
    {titulo:"Matrix"},
    {$set:{genero:"ciencia ficción"}}
);

// Ejercicio 5
db.media.updateOne(
    {titulo:"Java para todos"},
    {$unset:{editorial:"Anaya"}}
);

// Ejercicio 6
db.media.updateOne(
    {titulo:"Java para todos"},
    {$push:{Autor:"María Sancho"}}
);

// Ejercicio 7
db.media.updateOne(
    {titulo:"Matrix"},
    {$push:{ actores: {$each: ["Antonio Banderas", "Brad Pitt"]}}}
);

// Ejercicio 8
db.media.updateOne(
    {titulo:"Matrix"},
    {$addToSet:{ actores: {$each: ["Joe Pantoliano", "Brad Pitt", "Natalie Portman"]}}}
);

// Ejercicio 9
db.media.updateOne(
    {titulo:"Matrix"},
    {$pop:{ actores: 1}},
    {$pop:{ actores: -1}}
);

// Ejercicio 10
db.media.updateOne(
    {titulo:"Matrix"},
    {$addToSet:{ actores: {$each: ["Joe Pantoliano", "Antonio Banderas"]}}}
);

// Ejercicio 11
db.media.deleteOne(
    {titulo:"Matrix"},
    {$addToSet:{ actores: {$each: ["Joe Pantoliano", "Antonio Banderas"]}}}
);

db.media.find();