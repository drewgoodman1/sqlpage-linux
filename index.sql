
SELECT 'title' AS component, 'My Disc Golf Bag' AS title;


SELECT 'list' AS component, 3 AS columns, 'No discs found' AS empty_title;


SELECT 
    d.name AS title,
    'Brand: ' || b.brand_name || E'\n\n' ||
    'Type: ' || t.type_name || E'\n\n' ||
    'Speed: ' || d.speed || E'\n' ||
    'Glide: ' || d.glide || E'\n' ||
    'Turn: ' || d.turn || E'\n' ||
    'Fade: ' || d.fade AS description_md,

    'edit_disc.sql?disc_id=' || d.id AS edit_link,  
    'delete_disc.sql?disc_id=' || d.id AS delete_link 

FROM discs d
JOIN brands b ON d.brand_id = b.id
JOIN disc_types t ON d.type_id = t.id;


SELECT 'form' AS component, 
    'Add a New Disc' AS title, 
    'create_disc.sql' AS action;  


SELECT 'Disc_Name' AS name, 'text' AS type, 'Disc Name' AS label, TRUE AS required;

SELECT 'Disc_Brand' AS name, 'select' AS type, 'Select a brand' AS label, TRUE AS required,
    jsonb_agg(jsonb_build_object('value', id::text, 'label', brand_name)) AS options
FROM brands;

SELECT 'Disc_Type' AS name, 'select' AS type, 'Select disc type' AS label, TRUE AS required,
    jsonb_agg(jsonb_build_object('value', id::text, 'label', type_name)) AS options
FROM disc_types;

SELECT 'Speed' AS name, 'number' AS type, 'Speed (1-14)' AS label, TRUE AS required, 1 AS min, 14 AS max;
SELECT 'Glide' AS name, 'number' AS type, 'Glide (1-7)' AS label, TRUE AS required, 1 AS min, 7 AS max;
SELECT 'Turn' AS name, 'number' AS type, 'Turn (-5 to 1)' AS label, TRUE AS required, -5 AS min, 1 AS max;
SELECT 'Fade' AS name, 'number' AS type, 'Fade (0-5)' AS label, TRUE AS required, 0 AS min, 5 AS max;


SELECT 'Submit' AS validate, 'blue' AS validate_color;


SELECT 
    'chart' AS component,
    'Disc Flight Analysis' AS title,
    'scatter' AS type,
    'Turn + Fade' AS xtitle,
    'Speed' AS ytitle,
    500 AS height,
    6 AS marker,
    -5 AS xmin,  
    5 AS xmax,   
    0 AS ymin,   
    14 AS ymax,  
    1 AS xticks, 
    2 AS yticks; 


SELECT 
    d.name AS series,  
    (d.turn + d.fade) AS x,  -- X-axis based on Turn + Fade
    d.speed AS y,  -- Y-axis is Speed
    d.name AS label  
FROM discs d;
