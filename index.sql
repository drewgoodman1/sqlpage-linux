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

    'edit_disc.sql?disc_id=' || d.id AS edit_link,
    'delete_disc.sql?disc_id=' || d.id AS delete_link  -- 🔥 Explicit delete link instead of JSON

FROM discs d
JOIN brands b ON d.brand_id = b.id
JOIN disc_types t ON d.type_id = t.id
JOIN flight_numbers s ON d.speed_id = s.id AND s.category = 'Speed'
JOIN flight_numbers g ON d.glide_id = g.id AND g.category = 'Glide'
JOIN flight_numbers tr ON d.turn_id = tr.id AND tr.category = 'Turn'
JOIN flight_numbers f ON d.fade_id = f.id AND f.category = 'Fade';

-- 🔘 **Define the Add New Disc Button**
SELECT 
    'button' AS component,
    'center' AS justify;




-- 🏷️ Define the Form
SELECT 'form' AS component, 
       'Add a New Disc' AS title, 
       'submit-disc.sql' AS action;

-- 📝 Define Input Fields (Merging Dropdown Data)
SELECT 'Disc_Name' AS name, 'text' AS type, 'Disc Name' AS label, TRUE AS required;

SELECT 'Disc_Brand' AS name, 'select' AS type, 'Select a brand' AS label, TRUE AS required,
       jsonb_agg(jsonb_build_object('value', id, 'label', brand_name)) AS options
FROM brands WHERE brand_name IS NOT NULL AND brand_name != '';

SELECT 'Disc_Type' AS name, 'select' AS type, 'Select disc type' AS label, TRUE AS required,
       jsonb_agg(jsonb_build_object('value', id, 'label', type_name)) AS options
FROM disc_types WHERE type_name IS NOT NULL AND type_name != '';

SELECT 'Speed' AS name, 'select' AS type, 'Select speed' AS label, TRUE AS required,
       jsonb_agg(jsonb_build_object('value', value, 'label', value)) AS options
FROM flight_numbers WHERE category = 'Speed';

SELECT 'Glide' AS name, 'select' AS type, 'Select glide' AS label, TRUE AS required,
       jsonb_agg(jsonb_build_object('value', value, 'label', value)) AS options
FROM flight_numbers WHERE category = 'Glide';

SELECT 'Turn' AS name, 'select' AS type, 'Select turn' AS label, TRUE AS required,
       jsonb_agg(jsonb_build_object('value', value, 'label', value)) AS options
FROM flight_numbers WHERE category = 'Turn';

SELECT 'Fade' AS name, 'select' AS type, 'Select fade' AS label, TRUE AS required,
       jsonb_agg(jsonb_build_object('value', value, 'label', value)) AS options
FROM flight_numbers WHERE category = 'Fade';

-- ✅ Submit Button
SELECT 'Submit' AS validate, 'blue' AS validate_color;
