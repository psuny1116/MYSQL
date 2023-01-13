# 포켓몬 데이터 입력 쿼리
DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
             number INT,
             name VARCHAR(20)
             );
INSERT INTO mypokemon (number, name)
VALUES (10, 'caterpie'),
       (25, 'pikachu'),
       (26, 'raichu'),
       (133, 'eevee'),
       (152, 'chikoirita');
CREATE TABLE ability (
             number INT,
             type VARCHAR(10),
             height FLOAT,
             weight FLOAT,
             attack INT,
             defense INT,
             speed INT);
INSERT INTO ability (number, type, height, weight, attack, defense, speed)
VALUES (10, 'bug', 0.3, 2.9, 30, 35, 45),
       (25, 'electric', 0.4, 6, 55, 40, 90),
       (26, 'electric', 0.8, 30, 90, 55, 110),
       (133, 'normal', 0.3, 6.5, 55, 50, 55),
       (152, 'grass', 0.9, 6.4, 49, 65, 45);
       
SELECT * FROM mypokemon;
SELECT * FROM ability;

# 1. 내 포켓몬 중에 몸무게가 가장 많이 나가는 포켓몬의 번호를 가져와라.
SELECT number
FROM ability
WHERE weight = (SELECT MAX(weight)
                FROM ability);

# 2. 속도가 모든 전기 포켓몬의 공격력보다 하나라도 작은 포켓몬의 번호를 가져와라.
SELECT number
FROM ability
WHERE speed < ANY(SELECT attack
                  FROM ability
                  WHERE type = 'electric');

# 3. 공격력이 벙어력보다 큰 포켓몬이 있다면 모든 포켓몬의 이름을 가져와라. 
SELECT name 
FROM mypokemon
WHERE EXISTS (SELECT *
              FROM ability
              WHERE attack > defense);
              
/* 4. 이브이의 번호 133을 활용해서, 이브이의 영문 이름, 키, 몸무게를 가져와라.
이때, 키는 height, 몸무게는 weight이라는 별명으로 가져와라.*/
SELECT (SELECT name FROM mypokemon WHERE number = 133) AS name, height, weight
FROM ability
WHERE number = 133;

# 5. 속도가 2번째로 빠른 포켓몬의 번호와 속도를 가져와라.
SELECT number, speed
FROM (SELECT number, speed, RANK() OVER(ORDER BY speed DESC) AS speed_rank 
      FROM ability) AS A
WHERE speed_rank = 2;

# 6. 방어력이 모든 전기 포켓몬의 방어력보다 큰 포켓몬의 이름을 가져와라.
SELECT name
FROM mypokemon
WHERE number IN (SELECT number
			     FROM ability
                 WHERE defense > ALL(SELECT defense
                                     FROM ability
                                     WHERE type = 'electric'));