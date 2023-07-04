DROP TRIGGER IF EXISTS Loginfo;
DELIMITER $
CREATE TRIGGER Loginfo
AFTER INSERT ON log
FOR EACH ROW
BEGIN

	DECLARE what_is_action SMALLINT;
	DECLARE who_is_responsible VARCHAR(45);
	DECLARE changed_time DATETIME;
	DECLARE changed_success ENUM('YES','NO');
	DECLARE changed_table ENUM('payment','rental');

	SELECT action_id, username, action_date, action_success, used_tables_names
	INTO what_is_action, who_is_responsible, changed_time, changed_success, changed_table
	FROM log;

END$
DELIMITER ;


