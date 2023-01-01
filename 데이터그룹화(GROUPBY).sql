# 데이터 그룹화 하기(GROUP BY)
/*
- GROUP BY가 쓰인 쿼리의 SELECT절에는 GROUP BY 대상 컬럼과 그룹 함수만 사용 가능함.
- 여러 컬럼으로 그룹화를 할 경우 GROUP BY 컬럼이름을 복수개 입력하면 됨. 컬럼 번호로도 그룹화 가능. 이때, 컬럼 번호는 SELECT절의 컬럼 이름의 순서를 의미함

SELECT 그룹바이대상컬럼이름, ..., 그룹함수
FROM 테이블이름
WHERE 조건식
GROUP BY 컬럼이름;
*/

# 포켓몬 데이터 입력 쿼리
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

# mypokemon 테이블을 type으로 그룹화해라.
SELECT type
FROM mypokemon
GROUP BY type;

# HAVING: 가져올 데이터 그룹에 조건을 지정해주는 키워드 
/*
SELECT 컬럼이름, ..., 그룹함수
FROM 테이블이름
WHERE 조건식
GROUP BY 컬럼이름
HAVING 조건식;
*/

# COUNT: 그룹의 값 수를 세는 함수. SELECT, HAVING 절에서 사용
# SUM: 그룹의 합을 계산하는 함수. SELECT, HAVING 절에서 사용
# AVG: 그룹의 평균을 계산하는 함수. SELECT, HAVING 절에서 사용
# MIN: 그룹의 최솟값을 반환하는 함수. SELECT, HAVING 절에서 사용
# MAX: 그룹의 최댓값을 반환하는 함수. SELECT, HAVING 절에서 사용
/*
SELECT 컬럼이름, ..., COUNT(컬럼이름), SUM(컬럼이름), AVG(컬럼이름), MIN(컬럼이름), MAX(컬럼이름)
FROM 테이블이름
GROUP BY 컬럼이름
HAVING 조건문;
*/

# 그룹 함수 사용 예제(1) SELECT절에서 사용 
SELECT type, COUNT(*), COUNT(1), AVG(height), MAX(weight)     # 테이블에 null 데이터가 있다면 count(*)과 count(1)의 결과가 다를 수 있음 
FROM mypokemon
GROUP BY type;

# 그룹 함수 사용 예제(2) HAVING절에서 사용
SELECT type, COUNT(*), COUNT(1), AVG(height), MAX(weight)
FROM mypokemon
GROUP BY type
HAVING COUNT(1) = 2;     # COUNT(1)가 2인 데이터만 가져오기 

/* 6가지 핵심 쿼리 키워드 & 작성순서 & 실행순서
SELECT 컬럼이름         작성순서: 1,      실행순서: 5
FROM 테이블이름          작성순서: 2,      실행순서: 1
WHERE 조건식            작성순서: 3,      실행순서: 2
GROUP BY 컬럼이름       작성순서: 4,      실행순서: 3
HAVING 조건식           작성순서: 5,      실행순서: 4
ORDER BY 컬럼이름;      작성순서: 6,      실행순서: 6
*/

# mypokemon 테이블에서 name에 a가 들어가는 데이터를 가져와라. 이때, type별로 그룹화해서 가져와라. 그룹화할 때 height의 최대값으 1보다 큰 그룹만 가져와라.
# 정렬은 weight의 최대값을 기준으로 하고 결과값에는 type, 갯수, weight의 최대값이 포함되어야 한다.
SELECT type, COUNT(1), MAX(weight)     # 작성순서: 1, 실행순서: 5
FROM mypokemon                         # 작성순서: 2, 실행순서: 1
WHERE name LIKE '%a%'                  # 작성순서: 3, 실행순서: 2
GROUP BY type                          # 작성순서: 4, 실행순서: 3
HAVING MAX(height) > 1                 # 작성순서: 5, 실행순서: 4
ORDER BY 3;                            # 작성순서: 6, 실행순서: 6     # MAX(weight)순으로 정렬