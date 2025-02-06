-- 📊 Define the Scatter Plot
SELECT 
    'chart' AS component,
    'Disc Flight Characteristics' AS title,
    'scatter' AS type,
    'Turn-Fade' AS xtitle,
    'Speed' AS ytitle,
    500 AS height,
    6 AS marker;

-- 🎯 Get All Discs and Plot Them
SELECT 
    b.brand_name AS series,  -- Group discs by brand
    (f_turn.value - f_fade.value) AS x,  -- Use turn - fade for X-axis
    f_speed.value AS y,  -- Use speed for Y-axis
    d.name AS label  -- Show disc name on hover
FROM discs d
JOIN brands b ON d.brand_id = b.id
JOIN flight_numbers f_speed ON d.speed_id = f_speed.id AND f_speed.category = 'Speed'
JOIN flight_numbers f_turn ON d.turn_id = f_turn.id AND f_turn.category = 'Turn'
JOIN flight_numbers f_fade ON d.fade_id = f_fade.id AND f_fade.category = 'Fade';
