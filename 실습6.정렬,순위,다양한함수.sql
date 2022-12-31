# 데이터를 요청대로 만들기
## 포켓몬 데이터 입력
DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon(
             number INT,
             name VARCHAR(20),
             type VARCHAR(10),
             attack INT,
             defense INT,
             capture_date DATE
             );
INSERT INTO mypokemon (number, name, type, attack, defense, capture_date)
VALUES (10, 'caterpie', 'bug', 30, 35, '2019-10-14'),
	   (25, 'pikachu', 'electric', 55, 40, '2018-11-04'),
       (26, 'raichu', 'electric', 90, 55, '2019-05-28'),
       (125, 'electabuzz', 'electric', 83, 57, '2020-12-29'),
       (133, 'eevee', 'normal', 55, 50, '2021-10-03'),
       (137, 'porygon', 'normal', 60, 70, '2021-01-16'),
       (152, 'chikoirita', 'grass', 49, 65, '2020-03-05'),
       (153, 'bayleef', 'grass', 62, 80, '2022-01-01');
       
SELECT * FROM mypokemon;

# 1. 포켓몬 테이블에서 포켓몬의 이름과 이름의 글자 수를 이름의 글자 수로 정렬해서 가져와라.(정렬 순서는 글자 수가 적은 것부터 많은 것 순으로)
SELECT name, LENGTH(name)
FROM mypokemon
ORDER BY LENGTH(name);

/* 2. 포켓몬 테이블에서 방어력 순위를 보여주는 컬럼을 새로 만들어서 defense_rank라는 별명으로 가져와라. 이때, 포켓몬 이름 데이터도 함께 가져와라.
조건1. 방어력 순위란 방어력이 큰 순서대로 나열한 순위를 의미함.
조건2. 공동 순위가 있으면 다음 순서로 건너 뛰어라.*/
SELECT name, RANK() OVER (ORDER BY defense DESC) AS defense_rank
FROM mypokemon;

# 3. 포켓몬 테이블에서 포켓몬을 포획한 지 기준 날짜까지 며칠이 지났는 지를 days라는 별명으로 가져와라. 이때, 포켓몬의 이름도 함께 가져와라. 기준날짜는 2022년 2월 14일
SELECT name, DATEDIFF('2022-02-14', capture_date) AS days
FROM mypokemon;

# 4. 포켓몬의 이름을 마지막 3개 문자만, 'last_char'이라는 별명으로 가져와라.
SELECT RIGHT(name, 3) AS 'last_char'
FROM mypokemon;

# 5. 포켓몬 이름을 왼쪽에서 2개 문자를 'left2'라는 별명으로 가져와라.
SELECT LEFT(name, 2) AS 'left2'
FROM mypokemon;

# 6. 포켓몬 이름에서 이름에 o가 포함된 포켓몬만 모든 소문자 o를 대문자 O로 바꿔서 bigO라는 별명으로 가져와라.
SELECT REPLACE(name, 'o', 'O') AS 'bigO'
FROM mypokemon
WHERE name LIKE '%o%';

# 7. 포켓몬 타입을 가장 첫번째 글자 1자, 가장 마지막 글자 1자를 합친 후, 대문자로 변환해서 type_code라는 별명으로 가져와라. 이때, 이름도 함께 가져와라.
SELECT name, UPPER(CONCAT(LEFT(type, 1), RIGHT(type, 1))) AS 'type_code'
FROM mypokemon;

# 8. 포켓몬 이름의 글자 수가 8보다 큰 포켓몬의 데이터를 전부 가져와라.
SELECT *
FROM mypokemon
WHERE LENGTH(name) > 8;

# 9. 모든 포켓몬의 공격력 평균을 정수로 반올림해서 avg_of_attack이라는 별명으로 가져와라.
SELECT ROUND(AVG(attack)) AS 'avg_of_attack'
FROM mypokemon;

# 10. 모든 포켓몬의 방어력 평균을 정수로 내림해서 avg_of_defense이라는 별명으로 가져와라.
SELECT FLOOR(AVG(defense)) AS 'avg_of_defense'
FROM mypokemon;

# 11. 이름의 길이가 8미만인 포켓몬의 공격력의 2 제곱을 attack2라는 별명으로 가져와라. 이때, 이름도 함께 가져와라.
SELECT name, POWER(attack, 2) AS 'attack2'
FROM mypokemon
WHERE LENGTH(name) < 8;

# 12. 모든 포켓몬의 공격력을 2로 나눈 나머지를 div2라는 별명으로 가져와라. 이때, 이름도 함께 가져와라.
SELECT name, MOD(attack, 2) AS 'div2'
FROM mypokemon;

# 13. 공격력이 50이하인 포켓몬의 공격력을 방어력으로 뺀 값의 절대값을 diff라는 별명으로 가져와라. 이때, 이름도 함께 가져와라.
SELECT name, ABS(attack - defense) AS 'diff'
FROM mypokemon
WHERE attack <= 50;

# 14. 현재 날짜와 시간을 가져와라. 각각 now_date, now_time이라는 별명으로 가져와라.
SELECT CURRENT_DATE() AS 'now_date', CURRENT_TIME() AS 'now_time';

# 15. 포켓몬을 포획한 달(월, MONTH)을 숫자와 영어로 가져와라. 숫자는 month_num, 영어는 month_eng이라는 별명으로 가져와라.
SELECT MONTH(capture_date) AS 'month_num', MONTHNAME(capture_date) AS 'month_eng'
FROM mypokemon;

# 16. 포켓몬을 포획한 날의 요일을 숫자와 영어로 가져와라. 숫자는 day_num, 영어는 day_eng이라는 별명으로 가져와라.
SELECT DAYOFWEEK(capture_date) AS 'day_num', DAYNAME(capture_date) AS 'day_eng'
FROM mypokemon;

# 17. 포켓몬을 포획한 날의 연도, 월, 일을 각각 숫자로 가져와라. 연도는 year, 월은 month, 일은 day라는 별명으로 가져와라. 
SELECT YEAR(capture_date) AS 'year', MONTH(capture_date) AS 'month', DAY(capture_date) AS 'day'
FROM mypokemon;