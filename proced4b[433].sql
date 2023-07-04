DROP INDEX IF EXISTS actor_l_name ON actor;
CREATE INDEX actor_l_name
ON actor(last_name ASC);

DROP PROCEDURE IF EXISTS actors_information;
DELIMITER $
CREATE PROCEDURE actors_information(IN actors_last_name VARCHAR(45))
	BEGIN
		DECLARE actor_name VARCHAR(45);
		DECLARE actor_last_name VARCHAR(45);
		DECLARE actor_number BIGINT UNSIGNED;

		
		SELECT first_name, last_name, COUNT(*)
		INTO actor_name, actor_last_name, actor_number
		FROM actor
		WHERE actor_last_name=actors_last_name;

		SELECT actor_name, actor_last_name, actor_number
		GROUP BY actor_number HAVING COUNT(*)>=1;

	END$
DELIMITER ;

CALL actors_information('Webster');
CALL actors_information('Livingston');
/*pinakas me null gia ta onomata kai midenika gia to actor_number*/