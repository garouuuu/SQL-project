DROP TRIGGER IF EXISTS warning;
DELIMITER $
CREATE TRIGGER warning
BEFORE INSERT ON customer 
FOR EACH ROW 
BEGIN
	DECLARE using_name VARCHAR(45);
	DECLARE using_last_name VARCHAR(45);
	DECLARE customer_name VARCHAR(45);
	DECLARE customer_last_name VARCHAR(45);
	DECLARE typosxrhsth ENUM('customer', 'employee', 'administrator');
	DECLARE act SMALLINT;

	SELECT action_id
	INTO act
	FROM log;

	SELECT user_type
	INTO typosxrhsth
	FROM user;

	SELECT first_name, last_name 
	INTO customer_name, customer_last_name
	FROM customer;

	SELECT user_name, user_last_name 
	INTO using_name, using_last_name
	FROM log;


	IF( typosxrhsth='customer' AND customer_name= using_name AND customer_last_name= using_last_name) THEN
	SIGNAL SQLSTATE VALUE '45000'
	SET MESSAGE_TEXT='customers cannot change that';
	END IF;

END $
DELIMITER ;