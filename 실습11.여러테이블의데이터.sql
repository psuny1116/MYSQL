# 포켓몬 데이터 입력 쿼리
DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
             number INT,
             name VARCHAR(20),
             type VARCHAR(10),
             attack INT,
             defense INT);
CREATE TABLE friendpokemon (
             number INT,
             name VARCHAR(20),
             type VARCHAR(10),
             attack INT,
             defense INT);
INSERT INTO mypokemon (number, name, type, attack, defense)
VALUES (10, 'caterpie', 'bug', 30, 35),
	   (25, 'pikachu', 'electric', 55, 40),
       (26, 'raichu', 'electric', 90, 55),
       (133, 'eevee', 'normal', 55, 50),
       (152, 'chikoirita', 'grass', 49, 65);
INSERT INTO friendpokemon (number, name, type, attack, defense)
VALUES (26, 'raichu', 'electric', 80, 60),
       (125, 'electabuzz', 'electric', 83, 57),
       (137, 'porygon', 'normal', 60, 70),
       (153, 'bayleef', 'grass', 62, 80),
       (172, 'pichu', 'electric', 40, 15),
       (470, 'leafeon', 'grass', 110, 130);
       
SELECT * FROM mypokemon;
SELECT * FROM friendpokemon;

# 1. 내 포켓몬과 친구의 포켓몬에 어떤 타입들이 있는지 중복 제외하고 같은 타입은 한번씩만 가져와라. 
SELECT type     # SELECT DISTINCT type해도 됨
FROM mypokemon
UNION
SELECT type     # SELECT DISTINCT type해도 됨
FROM friendpokemon;

# 2. 내 포켓몬과 친구의 포켓몬 중에 풀(grass) 타입 포켓몬들의 포켓몬 번호와 이름을 중복 포함하여 전부 다 가져와라.
SELECT number, name, 'my' AS whose
FROM mypokemon
WHERE type = 'grass'
UNION ALL
SELECT number, name, 'friend' AS whose
FROM friendpokemon
WHERE type = 'grass';

# 3. 나도 가지고 있고, 친구도 가지고 있는 포켓몬의 이름을 가져와라.
SELECT A.name
FROM mypokemon AS A
INNER JOIN friendpokemon AS B
ON A.name = B.name;

# 4. 나만 가지고 있고, 친구는 안 가지고 있는 포켓몬의 이름을 가져와라. 
SELECT A.name
FROM mypokemon AS A
LEFT JOIN friendpokemon AS B
ON A.name = B.name
WHERE B.name IS NULL;