-- 🚀 Step 1: Update Existing Disc
UPDATE discs 
SET 
    name = :Disc_Name, 
    brand_id = :Disc_Brand::INTEGER,  
    type_id = :Disc_Type::INTEGER,   
    speed_id = (SELECT id FROM flight_numbers WHERE category = 'Speed' AND value = :Speed::INTEGER),
    glide_id = (SELECT id FROM flight_numbers WHERE category = 'Glide' AND value = :Glide::INTEGER),
    turn_id = (SELECT id FROM flight_numbers WHERE category = 'Turn' AND value = :Turn::INTEGER),
    fade_id = (SELECT id FROM flight_numbers WHERE category = 'Fade' AND value = :Fade::INTEGER)
WHERE id = :Disc_ID::INTEGER
RETURNING 'redirect' AS component, 'index.sql' AS link;
