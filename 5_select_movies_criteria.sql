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
        'last_name', d.last_name
    ) AS director
FROM
    Movie m
JOIN
    File f ON m.poster_file_id = f.id
JOIN
    Person d ON m.director_id = d.id
WHERE
    m.country_id = 1
    AND m.release_date >= '2022-01-01'
    AND m.duration > 135
    AND EXISTS (
        SELECT 1
        FROM MovieGenre mg
        JOIN Genre g ON mg.genre_id = g.id
        WHERE mg.movie_id = m.id
        AND g.genre_name IN ('Action', 'Drama')
    );
