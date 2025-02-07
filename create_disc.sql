
INSERT INTO discs (name, brand_id, type_id, speed, glide, turn, fade)
VALUES (
    :Disc_Name, 
    :Disc_Brand::INTEGER,  
    :Disc_Type::INTEGER,   
    :Speed::INTEGER,
    :Glide::INTEGER,
    :Turn::INTEGER,
    :Fade::INTEGER
)
RETURNING 'redirect' AS component, 'index.sql' AS link;
