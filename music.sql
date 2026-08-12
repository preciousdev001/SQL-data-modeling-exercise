SELECT
    s.title,
    s.duration_in_seconds,
    s.release_date,
    STRING_AGG(DISTINCT ar.name, ', ') AS artists,
    a.title AS album,
    STRING_AGG(DISTINCT p.name, ', ') AS producers
FROM songs S
JOIN albums a ON s.album_id = a.id
JOIN song_artists sa ON s.id = sa.song_id
JOIN artists ar ON sa.artists_id = ar.id
JOIN song_produceers sp ON s.id = sp.song_id
JOIN producers p ON sp.producer_id = p.id
GROUP BY s.id, a.id;
