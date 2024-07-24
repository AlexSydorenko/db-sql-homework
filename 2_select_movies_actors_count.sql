SELECT
    m.id,
    m.title,
    COUNT(c.person_id) AS actors_count
FROM
    Movie m
JOIN
    Character c ON m.id = c.movie_id
WHERE
    m.release_date >= NOW() - INTERVAL '5 YEARS'
GROUP BY
    m.id;
