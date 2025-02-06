INSERT INTO discs (name, brand_id, type_id, speed_id, glide_id, turn_id, fade_id)
VALUES (
    :Disc_Name, 
    :Disc_Brand::INTEGER,  -- ✅ Directly use the ID
    :Disc_Type::INTEGER,   -- ✅ Directly use the ID
    (SELECT id FROM flight_numbers WHERE category = 'Speed' AND value = :Speed::INTEGER),
    (SELECT id FROM flight_numbers WHERE category = 'Glide' AND value = :Glide::INTEGER),
    (SELECT id FROM flight_numbers WHERE category = 'Turn' AND value = :Turn::INTEGER),
    (SELECT id FROM flight_numbers WHERE category = 'Fade' AND value = :Fade::INTEGER)
)
RETURNING 'redirect' AS component, 'index.sql' AS link;
