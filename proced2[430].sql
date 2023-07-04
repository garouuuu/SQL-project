DROP PROCEDURE IF EXISTS rentCount;
DELIMITER $
CREATE PROCEDURE rentCount(IN email VARCHAR(50), IN inputDay DATE, IN sub_type ENUM('movies', 'shows', 'both'))
	BEGIN
		DECLARE movie_rent_number INT;
		DECLARE serie_rent_number INT;
		DECLARE both_rent_number INT;
		/*DECLARE sub_type VARCHAR(10);*/

		IF(sub_type= 'movies') THEN
		SELECT COUNT(film_rental_id)
		INTO movie_rent_number
		FROM film_rental
		WHERE film_rental_date=inputDay;
		SELECT movie_rent_number;

		ELSEIF(sub_type= 'shows') THEN
		SELECT COUNT(series_rental_id)
		INTO serie_rent_number
		FROM series_rental
		WHERE series_rental_date=inputDay;
		SELECT serie_rent_number;


		ELSE /*IF(sub_type= 'both')*/
		SELECT COUNT(both_rental_id)
		INTO both_rent_number
		FROM both_rental
		WHERE FILM_rental_date=inputDay AND series_rental_date=inputDay;

		SELECT both_rent_number;

		END IF;
	END$
DELIMITER ;

CALL rentCount('LUIS.YANEZ@sakilacustomer.org', '2006-02-14', 'movies');
CALL rentCount('MIGUEL.BETANCOURT@sakilacustomer.org', '2005-06-16', 'shows' );
/*pinakes me midenika*/