CREATE DATABASE homework_6;

USE homework_6;

/*
1.	Создайте функцию, которая принимает кол-во сек и 
форматирует их в кол-во дней, часов, минут и секунд.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
*/

DELIMITER //

CREATE FUNCTION SECONDS_TRANSFORM( seconds INT )
RETURNS VARCHAR(45)
  
BEGIN

DECLARE result VARCHAR(45);

SET result = '';

IF seconds >= 86400 THEN
  SET result = CONCAT(FLOOR(seconds / 86400), ' ', "days ");
  SET seconds = seconds - FLOOR(seconds / 86400) * 86400;
END IF;

IF seconds >= 3600 THEN
  SET result = CONCAT(result, TIME_FORMAT(SEC_TO_TIME(seconds),'%H hours %i mimutes %s seconds'));
ELSEIF seconds < 3600 AND seconds >= 60 THEN
  SET result = CONCAT(result, TIME_FORMAT(SEC_TO_TIME(seconds),'%i mimutes %s seconds'));
ELSE
  SET result = CONCAT(result, TIME_FORMAT(SEC_TO_TIME(seconds),'%s seconds'));
END IF;

RETURN result;

END;//

DELIMITER ;

SELECT SECONDS_TRANSFORM(123) AS result;
SELECT SECONDS_TRANSFORM(1234) AS result;
SELECT SECONDS_TRANSFORM(12345) AS result;
SELECT SECONDS_TRANSFORM(123456) AS result;



/*
2.	Выведите только четные числа от 1 до 10 включительно.
Пример: 2,4,6,8,10 (можно сделать через шаг +  2: х = 2, х+=2)
*/

DELIMITER //

CREATE PROCEDURE EVEN_NUMBERS( max_value INT )
 
BEGIN
DECLARE result VARCHAR(100);
DECLARE step INT;

SET step = 0;
SET result = '';

WHILE step < max_value - 1 DO
  SET step = step + 2;
  IF step = 2 THEN
    SET result = step;
  ELSE
    SET result = CONCAT(result,",",step);
  END IF;
  
END WHILE;

SELECT result AS even;
 
END;//
 
DELIMITER ;

CALL EVEN_NUMBERS(10);
