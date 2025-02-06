-- 🏷️ Define the Page Title
SELECT 'title' AS component, 
    (CASE WHEN $disc_id IS NULL THEN 'Add a New Disc' ELSE 'Edit Disc' END) AS title;

-- 📝 Fetch Existing Data If Editing
SELECT 
    id AS Disc_ID, 
    name AS Disc_Name,  
    brand_id::text AS Disc_Brand,  
    type_id::text AS Disc_Type,
    speed_id::text AS Speed,
    glide_id::text AS Glide,
    turn_id::text AS Turn,
    fade_id::text AS Fade
FROM discs 
WHERE id = $disc_id::int;

-- 🏷️ Define the Form
SELECT 'form' AS component, 
    (CASE WHEN $disc_id IS NULL THEN 'Add a New Disc' ELSE 'Edit Disc' END) AS title, 
    (CASE WHEN $disc_id IS NULL THEN 'submit_disc.sql' ELSE 'update_disc.sql' END) AS action;

-- 📝 Define Input Fields (Prefill values when editing)
SELECT 'Disc_Name' AS name, 'text' AS type, 'Disc Name' AS label, TRUE AS required, 
    COALESCE((SELECT name FROM discs WHERE id = $disc_id::int), '') AS value;

SELECT 'Disc_Brand' AS name, 'select' AS type, 'Select a brand' AS label, TRUE AS required,
    jsonb_agg(jsonb_build_object('value', id::text, 'label', brand_name)) AS options
FROM brands;

SELECT 'Disc_Type' AS name, 'select' AS type, 'Select disc type' AS label, TRUE AS required,
    jsonb_agg(jsonb_build_object('value', id::text, 'label', type_name)) AS options
FROM disc_types;

SELECT 'Speed' AS name, 'select' AS type, 'Select speed' AS label, TRUE AS required,
    jsonb_agg(jsonb_build_object('value', id::text, 'label', value)) AS options
FROM flight_numbers WHERE category = 'Speed';

SELECT 'Glide' AS name, 'select' AS type, 'Select glide' AS label, TRUE AS required,
    jsonb_agg(jsonb_build_object('value', id::text, 'label', value)) AS options
FROM flight_numbers WHERE category = 'Glide';

SELECT 'Turn' AS name, 'select' AS type, 'Select turn' AS label, TRUE AS required,
    jsonb_agg(jsonb_build_object('value', id::text, 'label', value)) AS options
FROM flight_numbers WHERE category = 'Turn';

SELECT 'Fade' AS name, 'select' AS type, 'Select fade' AS label, TRUE AS required,
    jsonb_agg(jsonb_build_object('value', id::text, 'label', value)) AS options
FROM flight_numbers WHERE category = 'Fade';

-- ✅ Submit Button
SELECT 'Submit' AS validate, 'blue' AS validate_color;
