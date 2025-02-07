
SELECT 'title' AS component, 'Edit Disc' AS title;


SELECT 
    id AS Disc_ID,
    name AS Disc_Name,  
    brand_id::text AS Disc_Brand,  
    type_id::text AS Disc_Type,
    speed AS Speed,
    glide AS Glide,
    turn AS Turn,
    fade AS Fade
FROM discs 
WHERE id = $disc_id::int;


SELECT 'form' AS component, 
    'Edit Disc' AS title, 
    'update_disc.sql?disc_id=' || $disc_id AS action;


SELECT 'Disc_Name' AS name, 'text' AS type, 'Disc Name' AS label, TRUE AS required, 
    (SELECT name FROM discs WHERE id = $disc_id::int) AS value;

SELECT 'Disc_Brand' AS name, 'select' AS type, 'Select a brand' AS label, TRUE AS required,
    jsonb_agg(jsonb_build_object('value', id::text, 'label', brand_name)) AS options
FROM brands;

SELECT 'Disc_Type' AS name, 'select' AS type, 'Select disc type' AS label, TRUE AS required,
    jsonb_agg(jsonb_build_object('value', id::text, 'label', type_name)) AS options
FROM disc_types;

SELECT 'Speed' AS name, 'number' AS type, 'Speed (1-14)' AS label, TRUE AS required, 1 AS min, 14 AS max,
    (SELECT speed FROM discs WHERE id = $disc_id::int) AS value;

SELECT 'Glide' AS name, 'number' AS type, 'Glide (1-7)' AS label, TRUE AS required, 1 AS min, 7 AS max,
    (SELECT glide FROM discs WHERE id = $disc_id::int) AS value;

SELECT 'Turn' AS name, 'number' AS type, 'Turn (-5 to 1)' AS label, TRUE AS required, -5 AS min, 1 AS max,
    (SELECT turn FROM discs WHERE id = $disc_id::int) AS value;

SELECT 'Fade' AS name, 'number' AS type, 'Fade (0-5)' AS label, TRUE AS required, 0 AS min, 5 AS max,
    (SELECT fade FROM discs WHERE id = $disc_id::int) AS value;


SELECT 'Submit' AS validate, 'blue' AS validate_color;
