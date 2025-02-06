-- 🏷️ Define the Page Title
SELECT 'title' AS component, 'My Disc Golf Bag' AS title;

-- 📋 Define a List Layout
SELECT 'list' AS component, 3 AS columns, 'No discs found' AS empty_title;

-- 🎴 Define Each Disc as an Individual Card with Links for Actions
SELECT 
    d.name AS title,
    'Brand: ' || b.brand_name || E'\n\n' ||
    'Type: ' || t.type_name || E'\n\n' ||
    'Speed: ' || s.value || E'\n' ||
    'Glide: ' || g.value || E'\n' ||
    'Turn: ' || tr.value || E'\n' ||
    'Fade: ' || f.value AS description_md,

    'edit_disc.sql?disc_id=' || d.id AS edit_link,   -- ✅ Edit link points to edit_disc.sql
    'delete_disc.sql?disc_id=' || d.id AS delete_link  -- ✅ Delete link points to delete_disc.sql

FROM discs d
JOIN brands b ON d.brand_id = b.id
JOIN disc_types t ON d.type_id = t.id
JOIN flight_numbers s ON d.speed_id = s.id AND s.category = 'Speed'
JOIN flight_numbers g ON d.glide_id = g.id AND g.category = 'Glide'
JOIN flight_numbers tr ON d.turn_id = tr.id AND tr.category = 'Turn'
JOIN flight_numbers f ON d.fade_id = f.id AND f.category = 'Fade';


-- 🚀 **Add or Edit Disc Form** (Handles both adding and editing)
SELECT 'form' AS component, 
    'Add or Edit a Disc' AS title, 
    'edit_disc.sql' AS action;  -- ✅ Form always loads edit_disc.sql

-- 📝 Define Input Fields
SELECT 'Disc_Name' AS name, 'text' AS type, 'Disc Name' AS label, TRUE AS required;

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

-- 📊 Scatter Plot for Disc Flight Characteristics
SELECT 
    'chart' AS component,
    'Disc Flight Analysis' AS title,
    'scatter' AS type,
    'Turn - Fade' AS xtitle,
    'Speed' AS ytitle,
    500 AS height,
    6 AS marker;  -- Controls dot size

-- 🎯 Plot All Discs with Unique Colors & Hover Labels
SELECT 
    d.name AS series,  -- Each disc has a unique color
    (f_turn.value - f_fade.value) AS x,  -- X-axis: Turn - Fade
    f_speed.value AS y,  -- Y-axis: Speed
    d.name AS label  -- Show disc name on hover
FROM discs d
JOIN flight_numbers f_speed ON d.speed_id = f_speed.id AND f_speed.category = 'Speed'
JOIN flight_numbers f_turn ON d.turn_id = f_turn.id AND f_turn.category = 'Turn'
JOIN flight_numbers f_fade ON d.fade_id = f_fade.id AND f_fade.category = 'Fade';
