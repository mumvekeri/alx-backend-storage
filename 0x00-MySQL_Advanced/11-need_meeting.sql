-- Create a view 'need_meeting' to list students with specific criteria
CREATE VIEW need_meeting AS
SELECT u.name
FROM users u
LEFT JOIN meetings m ON u.id = m.user_id
WHERE u.score < 80
    AND (m.last_meeting IS NULL OR m.last_meeting < DATE_SUB(NOW(), INTERVAL 1 MONTH));

