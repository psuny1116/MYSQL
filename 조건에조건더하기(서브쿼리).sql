/* 서브쿼리
- 하나의 쿼리 내 포함된 또 하나의 쿼리
- 서브 쿼리는 반드시 괄호 안에 있어야 함
- SELECT, FROM, WHERE, HAVING, ORDER BY절에 사용 가능
- INSERT, UPDATE, DELETE문에도 사용 가능
- 서브 쿼리에는 ;(세미콜론)을 붙이지 않아도 됨
*/

/* SELECT절의 서브 쿼리
- 스칼라 서브쿼리
- SELECT절의 서브 쿼리는 반드시 결과값이 하나의 값이어야 함

SELECT 컬럼이름,
       (SELECT 컬럼이름
        FROM 테이블이름
        WHERE 조건식)
FROM 테이블이름
WHERE 조건식;
*/

# 포켓몬 데이터 입력 쿼리
DROP DATABASE IF EXISTS pokemon;
CREATE DATABASE pokemon;
USE pokemon;
CREATE TABLE mypokemon (
			 number INT,
             name VARCHAR(20));
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

# SELECT절의 서브 쿼리 예제
# 피카츄의 번호, 영문 이름, 키를 가져와라
SELECT number, name, (SELECT height
                      FROM ability
                      WHERE number = 25) AS height
FROM mypokemon
WHERE name = 'pikachu';

/* FROM 절의 서브 쿼리
- 인라인 뷰 서브쿼리
- FROM절의 서브 쿼리는 반드시 결과값이 하나의 테이블이어야 함
- 서브 쿼리로 만든 테이블은 반드시 별명을 가져야 함

SELECT 컬럼이름
FROM (SELECT 컬럼이름
      FROM 테이블이름
      WHERE 조건식) AS 테이블별명
WHERE 조건식;
*/

# FROM절의 서브 쿼리 예제
# 키 순위가 3순위인 포켓몬의 번호와 키 순위를 가져와라.
SELECT number, height_rank
FROM (SELECT number, RANK () OVER(ORDER BY height DESC) AS height_rank
	  FROM ability) AS A
WHERE height_rank = 3;

/* WHERE절의 서브 쿼리
- 중첩 서브쿼리
- WHERE절의 서브 쿼리는 반드시 결과값이 하나의 컬럼이어야 함. (EXISTS 제외. EXISTS는 단독으로 사용하며, 결과값이 여러 칼럼이어도 됨)
- 보통 WHERE 컬럼이름 연산자 서브쿼리 형식으로 사용
SELECT 컬럼이름
FROM 테이블이름
WHERE 컬럼이름 연산자 (SELECT 컬럼이름
                   FROM 테이블이름
                   WHERE 조건식);
- 서브 쿼리에 비교 연산자만 사용하는 경우 WHERE절의 서브 쿼리는 반드시 결과값이 하나의 값이어야 함
*/

# WHERE절의 서브 쿼리 예제1
# 키가 평균 키보다 작은 포켓몬의 번호를 가져와라.
SELECT number
FROM ability
WHERE height < (SELECT AVG(height)
                FROM ability);

# WHERE절의 서브 쿼리 예제2
# 공격력이 모든 전기 포켓몬의 공격력보다 작은 포켓몬의 번호를 가져와라.
SELECT number
FROM ability
WHERE attack < ALL(SELECT attack
                   FROM ability
				   WHERE type = 'electric');
                   
# WHERE절의 서브 쿼리 예제3
# 방어력이 모든 전기 포켓몬의 공격력보다 하나라도 큰 포켓몬의 번호를 가져와라.
SELECT number
FROM ability
WHERE defense > ANY(SELECT attack
                    FROM ability
                    WHERE type = 'electric');

# WHERE절의 서브 쿼리 예제4
# bug타입 포켓몬이 있다면 모든 포켓몬의 번호를 가져와라.
SELECT number
FROM ability
WHERE EXISTS(SELECT *
             FROM ability
             WHERE type = 'bug'); 