/* 조건 만들기(IF)
IF(조건식, 참일 때 값, 거짓일 때 값)
주로 SELECT절에 사용. 결과값을 새로운 컬럼으로 반환함
*/

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
INSERT INTO mypokemon (number, name, type, attack, defense)
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

# IF 사용 예제
SELECT name, IF(attack >= 60, 'strong', 'weak') AS attack_class
FROM mypokemon;

/* IFNULL: 데이터가 NULL인지 아닌지를 확인해 NULL이라면 새로운 값을 반환하는 함수
IFNULL(컬럼이름, NULL일때 값)
주로 SELECT절에 사용. 결과값을 새로운 컬럼으로 반환
*/

# IFNULL 사용 예제
SELECT name, IFNULL(name, 'unknown') AS full_name     # 현재 mypokemon테이블에는 null값이 없어서 의미 없음.
FROM mypokemon;

/* CASE: 조건을 여러 개 만들 때 사용
- 주로 SELECT절에 사용. 결과값을 새로운 컬럼으로 반환
- ELSE 문장을 생략 시 NULL값을 반환
- 형식1
CASE
	WHEN 조건식1 THEN 결과값1
    WHEN 조건식2 THEN 결과값2
    ELSE 결과값3
END

- 형식2
CASE 컬럼이름
	WHEN 조건값1 THEN 결과값1
    WHEN 조건값2 THEN 결과값2
    ELSE 결과값3
END
*/

# CASE 사용예제(1): 포켓몬의 공격력을 문자열로 매핑
SELECT name, 
CASE
	WHEN attack >= 100 THEN 'very strong'
    WHEN attack >= 60 THEN 'strong'
    ELSE 'weak'
END AS attack_class
FROM mypokemon;

# CASE 사용예제(2): 포켓몬의 라이벌 타입을 문자열로 매핑
SELECT name, type,
CASE type
	WHEN 'bug' THEN 'grass'
    WHEN 'electric' THEN 'water'
    WHEN 'grass' THEN 'bug'
END AS rival_type
FROM mypokemon;

/* 함수 만들기
CREATE FUNCTION 함수이름 (입력값이름 데이터타입, ...)
	   RETURNS 결과값데이터타입
BEGIN
	   DECLARE 임시값이름 데이터타입;
       SET 임시값이름 = 입력값이름;
       쿼리;
       RETURN 결과값
END
*/

/* 함수 지우기
DROP FUNCTION 함수이름;
*/

/* MySQL Workbench에서 함수 생성시 주의할 점
SET GLOBAL log_bin_trust_function_creators = 1;     # 사용자 계정에 function create 권한 생성
DELIMITER //     # 함수의 시작 지정
CREATE FUNCTION 함수이름(입력값이름 데이터타입, ...)
       RETURNS 결과값데이터타입
BEGIN
	   DECLARE 임시값이름 데이터타입;
       SET 임시값이름 = 입력값이름;
       쿼리;
       RETURN 결과값
END
//
DELIMITER ;     # 함수의 끝 지정. 이때 반드시 DELIMITER과 ; 사이에 1칸 띄어야 함.
*/

# 함수 만들기 예시: 공격력과 방어력의 합을 가져오는 함수
SET GLOBAL log_bin_trust_function_creators = 1;
DELIMITER //

CREATE FUNCTION getAbility(attack INT, defense INT)     # 입력값이름: attack, defense / 데이터타입: INT, INT
	   RETURNS INT      # 결과값데이터타입: INT
BEGIN
	DECLARE a INT;     # 임시값이름: a, 임시값데이터타입: INT
    DECLARE b INT;
    DECLARE ability INT;
    SET a = attack;
    SET b = defense;
    SELECT a + b INTO ability;     # 쿼리
    RETURN ability;
END

//
DELIMITER ;