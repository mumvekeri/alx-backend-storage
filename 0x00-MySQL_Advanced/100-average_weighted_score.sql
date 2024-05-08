-- Create a stored procedure 'ComputeAverageWeightedScoreForUser' to compute and store the average weighted score for a student
CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
    DECLARE total_score DECIMAL(10,2);
    DECLARE total_weight DECIMAL(10,2);
    DECLARE avg_weighted_score DECIMAL(10,2);

    -- Calculate total weighted score and total weight
    SELECT SUM(score * weight) INTO total_score, SUM(weight) INTO total_weight
    FROM grades
    WHERE user_id = user_id;

    -- Calculate average weighted score
    IF total_weight > 0 THEN
        SET avg_weighted_score = total_score / total_weight;
    ELSE
        SET avg_weighted_score = 0;
    END IF;

    -- Insert or update the average weighted score for the user
    INSERT INTO average_weighted_scores (user_id, avg_weighted_score)
    VALUES (user_id, avg_weighted_score)
    ON DUPLICATE KEY UPDATE avg_weighted_score = VALUES(avg_weighted_score);
END;

