# 주어진 조건에 맞는 데이터 가져오기
## 포켓몬 테이블(mypokemon)
/*
number: 포켓몬 번호
name: 포켓몬 이름
type: 포켓몬 타입
height: 키(m)
weight: 몸무게(kg)
attack: 공격력
defense: 방어력
speed: 속도
*/

## 포켓몬 데이터 입력
DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon(
             number INT,
             name VARCHAR(20),
             type VARCHAR(20),
             height FLOAT,
             weight FLOAT,
             attack FLOAT,
             defense FLOAT,
             speed FLOAT
             );
INSERT INTO mypokemon(number, name, type, height, weight, attack, defense, speed)
VALUES (10, 'caterpie', 'bug', 0.3, 2.9, 30, 35, 45),
       (25, 'pikachu', 'electric', 0.4, 6, 55, 40, 90),
       (26, 'raichu', 'electric', 0.8, 30, 90, 55, 110),
       (133, 'eevee', 'normal', 0.3, 6.5, 55, 50, 55),
       (152, 'chikorita', 'grass', 0.9, 6.4, 49, 65, 45);
      
SELECT * FROM mypokemon;

# 1. 이브이의 타입을 가져와라.
SELECT type
FROM mypokemon
WHERE name = 'eevee';

# 2. 캐터피의 공격력과 방어력을 가져와라.
SELECT attack, defense
FROM mypokemon
WHERE name = 'caterpie';

# 3. 몸무게가 6kg보다 큰 포켓몬들의 모든 데이터를 가져와라.
SELECT *
FROM mypokemon
WHERE weight > 6;

# 4. 키가 0.5m보다 크고, 몸무게가 6kg보다 크거나 같은 포켓몬들의 이름을 가져와라.
SELECT name
FROM mypokemon
WHERE height > 0.5 AND weight >= 6;

# 5. 포켓몬 테이블에서 공격력이 50미만이거나, 방어력이 50미만인 포켓몬들의 이름을 weak_pokemon이라는 별명으로 가져와라.
SELECT name AS weak_pokemon
FROM mypokemon
WHERE attack < 50 OR defense < 50;

# 6. 노말 타입이 아닌 포켓몬들의 데이터를 전부 가져와라.
SELECT *
FROM mypokemon
WHERE type != 'normal';     # WHERE NOT(type = 'normal'); 이라고 써도 됨

# 7. 타입이 (normal, fire, water, grass) 중에 하나인 포켓몬들의 이름과 타입을 가져와라.
SELECT name, type
FROM mypokemon
WHERE type IN ('normal', 'fire', 'water', 'grass');

# 8. 공격력이 40과 60사이인 포켓몬들의 이름과 공격력을 가져와라.
SELECT name, attack
FROM mypokemon
WHERE attack BETWEEN 40 AND 60;     # WHERE attack >= 40 AND attack <= 60;도 가능.

# 9. 이름에 e가 포함되는 포켓몬들의 이름을 가져와라.
SELECT name
FROM mypokemon
WHERE name LIKE '%e%';

# 10. 이름에 i가 포함되고, 속도가 50이하인 포켓몬 데이터를 전부 가져와라.
SELECT *
FROM mypokemon
WHERE name LIKE '%i%' AND speed <= 50;

# 11. 이름이 chu로 끝나는 포켓몬들의 이름, 키, 몸무게를 가져와라.
SELECT name, height, weight
FROM mypokemon
WHERE name LIKE '%chu';

# 12. 이름이 e로 끝나고, 방어력이 50미만인 포켓몬들의 이름, 방어력을 가져와라.
SELECT name, defense
FROM mypokemon
WHERE name LIKE '%e' AND defense < 50;

# 13. 공격력과 방어력의 차이가 10 이상인 포켓몬들의 이름, 공격력, 방어력을 가져와라.
SELECT name, attack, defense
FROM mypokemon
WHERE ABS(attack - defense) >= 10;

/* 14. 능력치의 합이 150이상인 포켓몬의 이름과 능력치의 합을 가져와라. 이때, 능력치의 합은 total이라는 별명으로 가져와라.
능력치의 합은 공격력, 방어력, 속도의 합을 의미함.*/
SELECT name, attack + defense + speed AS total
FROM mypokemon
WHERE attack + defense + speed >= 150;