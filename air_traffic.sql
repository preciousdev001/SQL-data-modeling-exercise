SELECT
    p.first_name,
    p.last_name,
    t.seat,
    t.departure,
    t.arrival,
    a.name AS airline,
    fc.name AS from_city,
    tc.name AS to_city
FROM tickets t
JOIN passengers p ON t.passenger_id = p.id
JOIN airlines a ON t.airline_id = a.id
JOIN cities fc ON t.from_city_id = fc.id
JOIN cities tc ON t.to_city_id = tc.id;