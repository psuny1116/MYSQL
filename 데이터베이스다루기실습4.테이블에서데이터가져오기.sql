# 데이터베이스 다루기 실습4. 테이블에서 데이터 가져오기
/* 포켓몬 테이블 설명
number: 포켓몬 번호
name: 포켓몬 이름
type: 포켓몬 타입
height: 키(m)
weight: 몸무게(kg)
attack: 공격력
defense: 방어력
speed: 속도 */

## 포켓몬 테이블 생성
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
             speed FLOAT);
INSERT INTO mypokemon(number, name, type, height, weight, attack, defense, speed)
VALUES (10, 'caterpie', 'bug', 0.3, 2.9, 30, 35, 45),
       (25, 'pikachu', 'electric', 0.4, 6, 55, 40, 90),
       (26, 'raichu', 'electric', 0.8, 30, 90, 55, 110),
       (133, 'eevee', 'normal', 0.3, 6.5, 55, 50, 55),
       (152, 'chikorita', 'grass', 0.9, 6.4, 49, 65, 45);
       
## 포켓몬 테이블 불러오기
USE pokemon;
SELECT *
FROM mypokemon;

# 1. 123 곱하기 456을 가져와라.
SELECT 123 * 456;

# 2. 2310 나누기 30을 가져와라.
SELECT 2310 / 30;

# 3. '피카츄'라는 문자열을 '포켓몬'이라는 이름의 칼럼 별명으로 가져와라.
SELECT '피카츄' AS '포켓몬';

# 4. 포켓몬 테이블에서 모든 포켓몬들의 칼럼과 값 전체를 가져와라.
SELECT *
FROM mypokemon;

# 5. 포켓몬 테이블에서 모든 포켓몬들의 이름을 가져와라.
SELECT name
FROM mypokemon;

# 6. 포켓몬 테이블에서 모든 포켓몬들의 이름과 키, 몸무게를 가져와라.
SELECT name, height, weight
FROM mypokemon;

# 7. 포켓몬 테이블에서 포켓몬들의 키를 중복 제거하고 가져와라.
SELECT DISTINCT height
FROM mypokemon;

# 8. 포켓몬 테이블에서 모든 포켓몬들의 공격력을 2배 해 'attack2'라는 별명으로 이름과 함께 가져와라.
SELECT name, attack * 2 AS attack2
FROM mypokemon;

# 9. 포켓몬 테이블에서 모든 포켓몬들의 이름을 '이름'이라는 한글 별명으로 가져와라.
SELECT name AS '이름'
FROM mypokemon;

# 10. 포켓몬 테이블에서 모든 포켓몬들의 공격력은 '공격력'이라는 한글 별명으로, 방어력은 '방어력'이라는 한글 별명으로 가져와라.
SELECT attack AS 공격력, defense AS 방어력
FROM mypokemon;

/* 11. 현재 포켓몬 테이블의 키 컬럼은 m단위이다. 포켓몬 테이블에서 모든 포켓몬들의 키를 cm단위로 환산하여 'height(cm)'라는 별명으로 가져와라.
이때, 괄호가 들어간 경우에는 따옴표로 감싸주어 의미를 분명하게 해야 함. */
SELECT height * 100 AS 'height(cm)'
FROM mypokemon;

# 12. 포켓몬 테이블에서 첫번째 로우에 위치한 포켓몬 데이터만 컬럼 값 전체를 가져와라.
SELECT *
FROM mypokemon
LIMIT 1;

# 13. 포켓몬 테이블에서 2개의 포켓몬 데이터만 이름은 '영문명'이라는 별명으로, 키는 '키(m)'라는 별명으로, 몸무게는 '몸무게(kg)'이라는 별명으로 가져와라.
SELECT name AS 영문명, height AS '키(m)', weight AS '몸무게(kg)'
FROM mypokemon
LIMIT 2;

/* 14. 포켓몬 테이블에서 모든 포켓몬들의 이름과 능력치의 합을 가져오고, 이때 능력치의 합은 'total'이라는 별명으로 가져와라.
이때, 능력치의 합은 공격력, 방어력, 속도의 합을 의미한다. */
SELECT name, attack + defense + speed AS total
FROM mypokemon;

/* 15. 포켓몬 테이블에서 모든 포켓몬들의 BMI 지수를 구해서 'BMI'라는 별명으로 가져와라. 이때, 포켓몬을 구분하기 위해 이름도 함께 가져와라.
이때, BMI지수 = 몸무게(kg) / (키(m))^2 */
SELECT name, weight / height ^ 2 AS BMI
FROM mypokemon;