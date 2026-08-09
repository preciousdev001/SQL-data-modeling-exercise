SELECT
    p.name AS planet,
    p.orbital_period_in_years,
    s.name AS orbits_around,
    g.name AS galaxy
    COALESCE(ARRAY_AGG(m.name) FILTER (WHERE m.name IS NOT NULL), '{}') AS moons
FROM planets p
JOIN stars s ON p.star_id = s.id
JOIN galaxies g ON s.galaxy_id = g.id
LEFT JOIN moons m ON m.planet_id = p.id
GROUP BY p.id, s.name, g.name;