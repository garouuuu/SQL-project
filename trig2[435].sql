DROP TRIGGER IF EXISTS discount;
DELIMITER $
CREATE TRIGGER discount
BEFORE INSERT ON both_rental /*?*/
FOR EACH ROW
BEGIN

	DECLARE customer_mail VARCHAR(50);
	DECLARE movie_rent_number INT;
	DECLARE show_rent_number INT;
	DECLARE inputday DATE;
	DECLARE sub_type ENUM('movies', 'shows', 'both');
	DECLARE kostos_tainiwn DECIMAL;
	DECLARE kostos_seirwn DECIMAL;


	SELECT movies_subscription_cost
	INTO kostos_tainiwn
	FROM subscription;

	SELECT shows_subscription_cost
	INTO kostos_seirwn
	FROM subscription;


	CALL rentCount();
	IF(movie_rent_number=2 OR show_rent_number=2) THEN
		SET kostos_seirwn = kostos_seirwn/2;
		SET kostos_tainiwn = kostos_tainiwn/2;
	END IF;
	/*to NEW. den leitourgei (den briskei to column)*/

END $
DELIMITER ;


/*unknown column kostos seirwn in NEW*/




