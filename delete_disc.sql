
DELETE FROM discs 
WHERE id = $disc_id::int AND $confirm = 'yes'
RETURNING 
    'redirect' AS component,  
    'index.sql' AS link;


SELECT 'title' AS component, 'Confirm Deletion' AS title;


SELECT 
    'alert' AS component, 
    'red' AS color,
    'Confirm deletion' AS title,
    'Are you sure you want to delete this disc?' AS description_md,
    'delete_disc.sql?disc_id=' || $disc_id || '&confirm=yes' AS link, 
    'Delete' AS link_text;
