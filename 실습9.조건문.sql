# 포켓몬 데이터 입력 쿼리
DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon(
             number INT,
             name VARCHAR(20),
             type VARCHAR(10),
             attack INT,
             defense INT);
INSERT INTO mypokemon(number, name, type, attack, defense)
VALUES (10, 'caterpie', 'bug', 30, 35),
       (25, 'pikachu', 'electric', 55, 40),
       (26, 'raichu', 'electric', 90, 55),
       (125, 'electabuzz', 'electric', 83, 57),
       (133, 'eevee', 'normal', 55, 50),
       (137, 'porygon', 'normal', 60, 70),
       (152, 'chikoirita', 'grass', 49, 65),
       (153, 'bayleef', 'grass', 62, 80),
       (172, 'pichu', 'electric', 40, 15),
       (470, 'leafeon', 'grass', 110, 130);
SELECT * FROM mypokemon;

# 1. 포켓몬의 번호가 150보다 작으면 값을 'old'로 반환하고, 번호가 150보다 크거나 같으면 값을 'new'로 반환해서 'age'라는 별명으로 가져와라. 포켓몬의 이름을 포함하라.
SELECT name, CASE WHEN number < 150 THEN 'old'
                  WHEN number >= 150 THEN 'new'
                  END AS 'age'     # SELECT name, IF(number < 150, 'old', 'new') AS age로 써도 됨
FROM mypokemon;

# 2. 포켓몬의 공격력과 방어력의 합이 100보다 작으면 값을 'weak'로 반환하고, 100보다 크거나 같으면 값을 'strong'로 반환해서 'ability'라는 별명으로 가져와라. 포켓몬의 이름을 포함하라.
SELECT name, CASE WHEN attack + defense < 100 THEN 'weak'
                  WHEN attack + defense >= 100 THEN 'strong'
                  END AS ability     # SELECT name, IF(attack + defense < 100, 'weak', 'strong') AS ability로 써도 됨
FROM mypokemon;

# 3. 포켓몬의 타입별 공격력의 평균이 60이상이면 값을 True(1)로 반환하고, 60보다 작으면 False(0)를 반환해 'is_strong_type'이라는 별명으로 가져와라. 포켓몬의 타입을 포함하라.
SELECT type, CASE WHEN AVG(attack) >= 60 THEN True
                  WHEN AVG(attack) < 60 THEN False
                  END AS 'is_strong_type'     # SELECT type, IF(AVG(attack) >= 60, True, False) AS 'is_strong_type'로 써도 됨
FROM mypokemon
GROUP BY type;

# 4. 포켓몬의 공격력이 100보다 크고, 방어력도 100보다 크면 값을 True(1)로 반환하고, 둘 중 하나라도 100보다 작으면 False(0)를 반환해 'ace'라는 별명으로 가져와라. 포켓몬의 이름을 포함하라.
SELECT name, CASE WHEN attack > 100 AND defense > 100 THEN True
				  ELSE False
                  END AS 'ace'     # SELECT name, IF(attack > 100 AND defense > 100, True, False) AS ace로 써도 됨 
FROM mypokemon;

/* 5. 포켓몬의 번호가 100보다 작으면 값을 '<100'을 반환하고, 200보다 작으면 값을 '<200'을 반환하고, 500보다 작으면 값을 '<500'을 반환하는 규칙을 만들고 
각 포켓몬 별 규칙 적용 값을 'number_bin'이라는 별명으로 가져와라. 포켓몬의 이름을 포함하라. */
SELECT name, CASE WHEN number < 100 THEN '<100'
                  WHEN number < 200 THEN '<200'
				  WHEN number < 500 THEN '<500'
                  END AS 'number_bin'
FROM mypokemon;

/* 6.
attack >= 50 and number >= 150이면 new_strong
attack >= 50 and number < 150이면 old_strong
attack < 50 and number >= 150이면 new_weak
attack < 50 and number < 150이면 old_weak
위에 따른 값을 반환하는 규칙을 만들고, 각 포켓몬별 규칙 적용 값을 'age_attack'이라는 별명으로 가져와라. 포켓몬의 이름을 포함하라. */
SELECT name, CASE WHEN attack >= 50 AND number >= 150 THEN 'new_strong'
                  WHEN attack >= 50 AND number < 150 THEN 'old_strong'
                  WHEN attack < 50 AND number >= 150 THEN 'new_weak'
                  ELSE 'old_weak'
                  END AS 'age_attack'
FROM mypokemon;

# 7. 타입별 포켓몬 수가 1개면 'solo', 3개 미만이면 'minor', 3개 이상이면 'major'를 반환하고, 'count_by_type'이라는 별명으로 가져와라. 포켓몬의 타입을 포함하라.
SELECT type, CASE WHEN COUNT(1) = 1 THEN 'solo'
                  WHEN COUNT(1) < 3 THEN 'minor'
                  WHEN COUNT(1) >= 3 THEN 'major'
                  END AS 'count_by_type'
FROM mypokemon
GROUP BY type;
