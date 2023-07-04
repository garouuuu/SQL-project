DROP PROCEDURE IF EXISTS mostRented;
DELIMITER $
CREATE PROCEDURE mostRented(IN x ENUM('m', 's'), IN y INT, IN inputDay1 DATETIME, IN inputDay2 DATETIME)
	BEGIN
		

		DECLARE flag INT ;

		DECLARE film_id SMALLINT;
		DECLARE series_id SMALLINT;

		/* TITLOI*/
		DECLARE title VARCHAR(128);
		DECLARE series_title VARCHAR(128);
		
		/* COUNTS*/
		DECLARE movie_number INT;
		DECLARE series_rent_count INT;
		DECLARE season_rent_count INT;
		DECLARE episode_rent_count INT;

		/*IDS
		DECLARE movie_rent_id INT;
		DECLARE series_rent_id INT;
		DECLARE season_rent_id INT;
		DECLARE episode_rent_id INT;*/
        /*DECLARE geia INT;*/


        /*KERSORAS1*/
		DECLARE moviecursor CURSOR FOR
			SELECT film_id, title, movie_number
			FROM film WHERE film_id IN 
            (SELECT film_id FROM film_inventory WHERE film_inventory_id IN 
        	(SELECT film_inventory_id FROM film_rental WHERE film_rental_date>=inputDay1 AND film_rental_date<=inputDay2)
        	)
        	ORDER BY COUNT(film_id) DESC LIMIT 0, y;


        	/*KERSORAS2*/
		DECLARE seriescursor CURSOR FOR
			SELECT series_id, series_title 
			FROM series WHERE series_id IN 
            (SELECT series_id FROM series_inventory WHERE series_inventory_id IN 
        	(SELECT series_inventory_id FROM series_rental 
        		WHERE series_rental_date>=inputDay1 AND season_rental_date<=inputDay2
        		AND season_rental_date>=inputDay1 AND season_rental_date<=inputDay2
        		AND episode_rental_date>=inputDay1 AND episode_rental_date<=inputDay2)
        	) ORDER BY  series_rent_count DESC LIMIT  0, y;
		
		DECLARE CONTINUE HANDLER FOR NOT FOUND SET flag = 1 ;
       
        SELECT COUNT(season_rental_id),COUNT(episode_rental_id)
		INTO season_rent_count, episode_rent_count
		FROM series_rental;
        
        SELECT  COUNT(season_rental_id)  + COUNT(episode_rental_id)
        INTO series_rent_count
        FROM series_rental;

        /*SET COUNT(season_rental_id)  + COUNT(episode_rental_id)= geia;*/
		

       
		IF(x='m') THEN
        OPEN moviecursor;
        SET flag=0;
        REPEAT
        FETCH moviecursor INTO film_id, title, movie_number;
       
        	IF (flag=0) THEN
				SELECT film_id AS movie_id , title AS movie_title , COUNT(film_id) AS movie_number;
				
			END IF;
		UNTIL (flag=1)
		
		END REPEAT;
		CLOSE moviecursor;
		END IF;
        
		
		IF(x='s') THEN
        OPEN seriescursor;
        SET flag=0;
		REPEAT
		FETCH seriescursor INTO series_id, series_title ;
				IF (flag=0) THEN
				  SELECT series_id AS show_id , series_title AS show_title ;
				
        	END IF;
		UNTIL (flag=1)
		END REPEAT;
		CLOSE seriescursor;
 
		END IF;
	    END$
DELIMITER ;

/*OK*/



CALL mostRented('m', 2,'2006-01-01 12:00:00', '2006-08-06 20:38:02');