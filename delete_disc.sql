-- 🚀 Step 1: Try to Delete if Confirmed
DELETE FROM discs 
WHERE id = $disc_id::int AND $confirm = 'yes'
RETURNING 
    'redirect' AS component,  -- 🚀 Redirect to index if deleted
    'index.sql' AS link;

-- 🛑 Step 2: If the above query executed, user is redirected, and the rest won't run.
-- If we're still here, that means the user hasn't confirmed deletion yet.

-- 🏷️ Step 3: Display the Confirmation Page
SELECT 'title' AS component, 'Confirm Deletion' AS title;

-- ⚠️ Step 4: Show Confirmation Alert
SELECT 
    'alert' AS component, 
    'red' AS color,  -- Make it clear that this is a destructive action
    'Confirm deletion' AS title,
    'Are you sure you want to delete this disc?' AS description_md,
    'delete_disc.sql?disc_id=' || $disc_id || '&confirm=yes' AS link, 
    'Delete' AS link_text;
