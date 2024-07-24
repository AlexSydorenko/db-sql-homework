SELECT
    m.id,
    m.title,
    m.release_date,
    m.duration,
    m.description,
    json_build_object(
        'id', f.id,
        'file_name', f.file_name,
        'mime_type', f.mime_type,
        'key', f.key,
        'url', f.url
    ) AS poster,
    json_build_object(
        'id', d.id,
        'first_name', d.first_name,
        'last_name', d.last_name,
        'photo', json_build_object(
            'id', df.id,
            'file_name', df.file_name,
            'mime_type', df.mime_type,
            'key', df.key,
            'url', df.url
        )
    ) AS director,
    json_agg(
        json_build_object(
            'id', a.id,
            'first_name', a.first_name,
            'last_name', a.last_name,
            'photo', json_build_object(
                'id', af.id,
                'file_name', af.file_name,
                'mime_type', af.mime_type,
                'key', af.key,
                'url', af.url
            )
        )
    ) AS actors,
    json_agg(
        json_build_object(
            'id', g.id,
            'name', g.genre_name
        )
    ) AS genres
FROM
    Movie m
JOIN
    File f ON m.poster_file_id = f.id
JOIN
    Person d ON m.director_id = d.id
LEFT JOIN
    File df ON d.primary_photo_file_id = df.id
LEFT JOIN
    Character c ON m.id = c.movie_id
LEFT JOIN
    Person a ON c.person_id = a.id
LEFT JOIN
    File af ON a.primary_photo_file_id = af.id
LEFT JOIN
    MovieGenre mg ON m.id = mg.movie_id
LEFT JOIN
    Genre g ON mg.genre_id = g.id
WHERE
    m.id = 1
GROUP BY
    m.id, f.id, d.id, df.id;
