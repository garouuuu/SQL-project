DROP INDEX IF EXISTS actor_last_name ON actor;
CREATE INDEX actor_last_name
ON actor(last_name ASC);

DROP PROCEDURE IF EXISTS actors;
DELIMITER $
CREATE PROCEDURE actors(IN first_last_name VARCHAR(45), IN second_last_name VARCHAR(45))
	BEGIN
			DECLARE actor_name VARCHAR(45);
			DECLARE actor_last_name VARCHAR(45);
			DECLARE actor_number BIGINT UNSIGNED;

			SELECT first_name, last_name, COUNT(*)
			INTO actor_name, actor_last_name, actor_number
			FROM actor
			WHERE actor_last_name BETWEEN /*LIKE*/ 'first_last_name%' AND /*LIKE*/ '%second_last_name';

            SELECT actor_name, actor_last_name, actor_number;
			
	END$
DELIMITER ;

CALL actors('DAV', 'Web');
CALL actors('Alvarez', 'Zamora');
/*pinakas me null gia ta onomata kai midenika gia to actor_number*/	