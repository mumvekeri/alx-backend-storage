-- Write a SQL script that creates a stored procedure ComputeAverageScoreForUser that computes and store the average score for a student. 

DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser(
    IN p_user_id INT
)
BEGIN
    DECLARE avg_score DECIMAL(10, 2);

    -- Compute the average score for the given user
    SELECT AVG(score) INTO avg_score
    FROM corrections
    WHERE user_id = p_user_id;

    -- Update the average_score attribute for the user
    UPDATE users
    SET average_score = avg_score
    WHERE id = p_user_id;
END;

//

DELIMITER ;

