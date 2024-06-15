use Spotify

db.listas.insertMany([
    {
        'nombre_lista': 'Top Hits 2020',
        'alias_creador': 'dj_awesome',
        'fecha_ultima_modificacion': '2020:07:20',
        'numero_seguidores': 2345,
        'canciones': [
            {
                'titulo': 'Blinding Lights',
                'artista': 'The Weeknd'
            },
            {
                'titulo': 'Watermelon Sugar',
                'artista': 'Harry Styles'
            }
        ]
    },
    {
        'nombre_lista': 'Summer Vibes',
        'alias_creador': 'sunny_day',
        'fecha_ultima_modificacion': '2020:06:15',
        'numero_seguidores': 4567,
        'canciones': [
            {
                'titulo': 'Savage Love',
                'artista': 'Jawsh 685, Jason Derulo'
            },
            {
                'titulo': 'Rockstar',
                'artista': 'DaBaby, Roddy Ricch'
            }
        ]
    },
    {
        'nombre_lista': 'Relaxing Instrumentals',
        'alias_creador': 'calm_wave',
        'fecha_ultima_modificacion': '2020:05:22',
        'numero_seguidores': 3421,
        'canciones': [
            {
                'titulo': 'Weightless',
                'artista': 'Marconi Union'
            },
            {
                'titulo': 'Clair de Lune',
                'artista': 'Claude Debussy'
            }
        ]
    },
    {
        'nombre_lista': 'Workout Mix',
        'alias_creador': 'fitness_freak',
        'fecha_ultima_modificacion': '2020:07:01',
        'numero_seguidores': 7890,
        'canciones': [
            {
                'titulo': 'Don\'t Start Now',
                'artista': 'Dua Lipa'
            },
            {
                'titulo': 'Physical',
                'artista': 'Dua Lipa'
            }
        ]
    },
    {
        'nombre_lista': 'Classical Essentials',
        'alias_creador': 'maestro_mind',
        'fecha_ultima_modificacion': '2020:04:10',
        'numero_seguidores': 1234,
        'canciones': [
            {
                'titulo': 'Symphony No. 5',
                'artista': 'Ludwig van Beethoven'
            },
            {
                'titulo': 'The Four Seasons',
                'artista': 'Antonio Vivaldi'
            }
        ]
    }
])

// 2)
// Actualiza la fecha de la lista del creador dj_awesome
db.listas.updateOne(
    {"alias_creador":"dj_awesome"},
    {$set:{"fecha_ultima_modificacion":"2023:04:22"}}
)

// Aumenta el número de seguidores de la lista Summer Vibes en 3
db.listas.updateOne(
    {'nombre_lista':'Summer Vibes'},
    {$inc: {'numero_seguidores':3}}
)

// Actualiza la fecha de la lista del creador calm_wave a la fecha actual
db.listas.updateOne(
    {"alias_creador":"calm_wave"},
    {$currentDate: {"fecha_ultima_modificacion": {$type:"date"}}}
)

// Añade a aquella lista del creador fitness_freak el campo idioma y le añade español
db.listas.updateOne(
    {'alias_creador': 'fitness_freak'},
    {$addToSet:
        {'idiomas': 'Español'}
    }
)

// Añade una nueva canción a la lista Classical Essentials
db.listas.updateOne(
    {'nombre_lista':'Classical Essentials'},
    {$push:
        {'canciones':
            {'titulo':'Billie Jean',
            'artista':'Michael Jackson'
            }
        }
    }
)

// Quita el primer valor del campo idioma a aquel documento cuyo alias de creador sea fitness_freak
db.listas.updateOne(
    {'alias_creador': 'fitness_freak'},
    {$pop: {'idiomas': -1 | 1}}
)

// 4)
// Elimina de las listas la "Top Hits 2020"
db.listas.DELETE One(
{'nombre_lista':'Top Hits 2020'}
)

// Elimina de las listas aquellas que tienen 4000 o menos seguidores
db.listas.DELETE Many(
{'numero_seguidores': {$lte: 4000}}
)