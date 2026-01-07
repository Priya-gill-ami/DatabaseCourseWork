USE HealthFitnessDB;
/* 5, a, i  - Get all records from the users table */
SELECT * FROM users;

/* 5, a, ii - Get the fats in particular meal in ascending order from nutrition table  */
SELECT * FROM nutrition
ORDER BY fats_g ASC;

/* 5, a, iii - only give distinct types of goals  */
SELECT distinct goal_type FROM goals;

/* 5, a, iv - Query for giving results if the workoutType is either strength or cardio 
and the workout duration is greater than 30 minutes */
SELECT * FROM workouts
WHERE workout_type = 'Cardio' OR workout_type = 'Strength'AND duration_minutes > 30;

/* 5, a, v - Query for giving all the records of nutrition table where user id is in range of 1 -4 */
SELECT * FROM nutrition
WHERE user_id IN (1, 2, 3);

/* 5, a, vi - Querying the records in user table in which a includes in any name*/
SELECT * FROM users
WHERE name LIKE '%A%';

/* 5, b, i - Aggregate Functions - COUNT - Count the total reocrds in the table workouts*/  
SELECT COUNT(*) AS TotalWorkouts
FROM workouts;
/* 5, b, i - Aggregate Functions - Take the average of the calories as AvgCalories from nutritiont able*/  
SELECT AVG(calories) AS AvgCalories
FROM nutrition;
/* 5, b, i - Aggregate Functions - Sum all the protein from the nutrition table*/  
SELECT SUM(protein) AS TotalProtein
FROM nutrition;

/* 5, c, i - Get the users with the same weight (Self - Join)*/
SELECT A.name AS User1, B.name AS User2
FROM users A, users B
WHERE A.weight_kg = B.weight_kg AND A.user_id <> B.user_id;

/* 5, c, ii - Get the name, workout date and type from workouts where user id matches*/
SELECT u.name, w.workout_date, w.workout_type
FROM users u
INNER JOIN workouts w ON u.user_id = w.user_id;

/* 5, c, iii - Get the sets and reps from workoutExcercise table and sate from the workout if they have similar user*/
SELECT w.workout_date, we.sets, we.reps
FROM workouts w
LEFT JOIN workout_exercises we ON w.workout_id = we.workout_id;

/* 5, d, i - Get the user_id and total*/
SELECT user_id, COUNT(*) AS TotalWorkouts
FROM workouts
GROUP BY user_id
HAVING COUNT(*) <5;

/* 5, e, View -1- User Basic Info*/
CREATE VIEW userBasicInfo AS
SELECT name, age, weight_kg, height_cm
FROM users;

/* 5, e, View -2-  Workout Details with Exercises*/
CREATE VIEW workoutWithExercises AS
SELECT w.workout_date, w.workout_type, e.name AS exercise_name, we.sets, we.reps
FROM workouts w
JOIN workout_exercises we ON w.workout_id = we.workout_id
JOIN exercises e ON we.exercise_id = e.exercise_id;

/* 5, e, View -3-  Daily Nutrition Summary*/
CREATE VIEW daily_nutrition_summary AS
SELECT user_id, meal_date, calories, protein_g, carbs_g, fats_g
FROM nutrition;


/* 5, f, Trigger 1- Before Insert on Workout (check valid duration) */
DELIMITER //

CREATE TRIGGER check_workout_duration
BEFORE INSERT ON workouts
FOR EACH ROW
BEGIN
    IF NEW.duration <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Workout duration must be greater than 0 minutes.';
    END IF;
END;
//

DELIMITER ;

/* 5, f, Trigger 2- After Insert on Nutrition (Update weight) */
DELIMITER //

CREATE TRIGGER update_user_weight
AFTER INSERT ON nutrition
FOR EACH ROW
BEGIN
    UPDATE user
    SET weight = weight + 0.1
    WHERE user_id = NEW.user_id;
END;
//

DELIMITER ;

/* 5, f, Trigger 3-  Before Delete on Exercise (Prevent if used) */
DELIMITER //

CREATE TRIGGER prevent_exercise_delete
BEFORE DELETE ON exercises
FOR EACH ROW
BEGIN
    DECLARE exercise_used INT;
    SELECT COUNT(*) INTO exercise_used
    FROM workout_exercises
    WHERE exercise_id = OLD.exercise_id;

    IF exercise_used > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot delete exercise linked to workouts.';
    END IF;
END;
//

DELIMITER ;