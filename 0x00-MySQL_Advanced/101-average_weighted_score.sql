-- Write a SQL script that creates a stored procedure ComputeAverageWeightedScoreForUsers that computes and store the average weighted score for all students.

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE user_id INT;
    DECLARE total_score DECIMAL(10,2);
    DECLARE total_weight DECIMAL(10,2);
    DECLARE avg_weighted_score DECIMAL(10,2);

    DECLARE cur CURSOR FOR
        SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO user_id;
        IF done THEN
            LEAVE read_loop;
        END IF;

        SELECT SUM(score * weight) INTO total_score, SUM(weight) INTO total_weight
        FROM grades
        WHERE user_id = user_id;

        IF total_weight > 0 THEN
            SET avg_weighted_score = total_score / total_weight;
        ELSE
            SET avg_weighted_score = 0;
        END IF;

        INSERT INTO average_weighted_scores (user_id, avg_weighted_score)
        VALUES (user_id, avg_weighted_score)
        ON DUPLICATE KEY UPDATE avg_weighted_score = VALUES(avg_weighted_score);
    END LOOP;

    CLOSE cur;
END;

