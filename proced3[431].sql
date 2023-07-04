DROP PROCEDURE IF EXISTS monthly_income;
DELIMITER $
CREATE PROCEDURE monthly_income(IN inputDay DATETIME)
	BEGIN
		DECLARE monthly_movies_income DECIMAL;
		DECLARE monthly_series_income DECIMAL;
		DECLARE month DATETIME;

		/*SELECT MONTHNAME('inputDay');*/

		SET month='inputDay';

		SELECT SUM(movies_subscription_cost), SUM(shows_subscription_cost)
		INTO monthly_movies_income, monthly_series_income
		FROM subscription
		WHERE subscription_date=month;
		SELECT monthly_movies_income, monthly_series_income;
	END$
DELIMITER ;





CALL monthly_income('2005-07-07 11:32:16');
/*pinakas me null*/