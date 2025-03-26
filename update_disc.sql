
UPDATE discs 
SET 
    name = :Disc_Name, 
    brand_id = :Disc_Brand::INTEGER,  
    type_id = :Disc_Type::INTEGER,   
    speed = :Speed::INTEGER,
    glide = :Glide::INTEGER,
    turn = :Turn::INTEGER,
    fade = :Fade::INTEGER
WHERE id = $disc_id::int;


SELECT 'redirect' AS component, 'index.sql' AS link;
