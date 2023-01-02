DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon(
             number INT,
             name VARCHAR(20),
             type VARCHAR(10),
             height FLOAT,
             weight FLOAT);
INSERT INTO mypokemon (number, name, type, height, weight)
VALUES (10, 'caterpie', 'bug', 0.3, 2.9),
       (25, 'pikachu', 'electric', 0.4, 6),
       (26, 'raichu', 'electric', 0.8, 30),
       (125, 'electabuzz', 'electric', 1.1, 30),
       (133, 'eevee', 'normal', 0.3, 6.5),
       (137, 'porygon', 'normal', 0.8, 36.5),
       (152, 'chikoirita', 'grass', 0.9, 6.4),
       (153, 'bayleef', 'grass', 1.2, 15.8),
       (172, 'pichu', 'electric', 0.3, 2),
       (470, 'leafeon', 'grass', 1, 25.5);
SELECT * FROM mypokemon;

/* 1. 포켓몬 테이블에서 이름(name)의 길이가 5보다 큰 포켓몬들을 타입(type)을 기준으로 그룹화하고, 몸무게(weight)의 평균이 20이상인 그룹의 타입과, 몸무게의 평균을 가져와라.
이때, 결과는 몸무게의 평균을 내림차순으로 정렬하라. */
SELECT type, AVG(weight)
FROM mypokemon
WHERE LENGTH(name) > 5
GROUP BY type
HAVING AVG(weight) >= 20
ORDER BY AVG(weight) DESC;     # ORDER BY 2 DESC;도 가능

/* 2. 포켓몬 테이블에서 번호(number)가 200보다 작은 포켓몬들을 타입(type)을 기준으로 그룹화한 후에, 몸무게(weight)의 최댓값이 10보다 크거나 같고
최솟값은 2보다 크거나 같은 그룹의 타입, 키(height)의 최솟값, 최댓값을 가져와라. 이때, 결과는 키의 최솟값의 내림차순으로 정렬하고,
만약 키의 최솟값이 같다면 키의 최댓값의 내림차순으로 정렬하라. */
SELECT type, MIN(height), MAX(height)
FROM mypokemon
WHERE number < 200
GROUP BY type
HAVING MAX(weight) >=  10 AND MIN(weight) >= 2
ORDER BY MIN(height) DESC, MAX(height) DESC;     # ORDER BY 2 DESC, 3 DESC;도 가능

# 3. 포켓몬의 타입별 키의 평균을 가져와라. 결과에 타입값을 포함하라.
SELECT type, AVG(height)
FROM mypokemon
GROUP BY type;

# 4. 포켓몬의 타입별 몸무게의 평균을 가져와라. 결과에 타입값을 포함하라.
SELECT type, AVG(weight)
FROM mypokemon
GROUP BY type;

# 5. 포켓몬의 타입별 키의 평균과 몸무게의 평균을 함께 가져와라. 결과에 타입값을 포함하라.
SELECT type, AVG(height), AVG(weight)
FROM mypokemon
GROUP BY type;

# 6. 키의 평균이 0.5 이상인 포켓몬의 타입을 가져와라. 결과에 타입값을 포함하라.
SELECT type
FROM mypokemon
GROUP BY type
HAVING AVG(height) >= 0.5;

# 7. 몸무게의 평균이 20이상인 포켓몬의 타입을 가져와라. 결과에 타입값을 포함하라.
SELECT type
FROM mypokemon
GROUP BY type
HAVING AVG(weight) >= 20;

# 8. 포켓몬의 타입별 번호(number)의 합을 가져와라. 결과에 타입값을 포함하라.
SELECT type, SUM(number)
FROM mypokemon
GROUP BY type;

# 9. 키가 0.5 이상인 포켓몬이 포켓몬의 type 별로 볓 개씩 있는지 가져와라. 결과에 타입값을 포함하라.
SELECT type, COUNT(*)
FROM mypokemon
WHERE height >= 0.5
GROUP BY type;

# 10. 포켓몬 타입별 키의 최솟값을 가져와라. 결과에 타입값을 포함하라.
SELECT type, MIN(height)
FROM mypokemon
GROUP BY type;

# 11. 포켓몬 타입별 몸무게의 최댓값을 가져와라. 결과에 타입값을 포함하라.
SELECT type, MAX(weight)
FROM mypokemon
GROUP BY type;

# 12. 키의 최솟값이 0.5보다 크고 몸무게의 최댓값이 30보다 작은 포켓몬 타입을 가져와라. 결과에 타입값을 포함하라.
SELECT type
FROM mypokemon
GROUP BY type
HAVING MIN(height) > 0.5 AND MAX(weight) < 30;